import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/isar_service.dart';
import '../../core/utils/debouncer.dart';
import '../../core/utils/note_colors.dart';
import '../../models/attachment.dart';
import '../../models/label.dart';
import '../../models/note.dart';

class NoteEditorScreen extends ConsumerStatefulWidget {
  const NoteEditorScreen({super.key, this.note, this.initialType = NoteType.text});

  final Note? note;
  final NoteType initialType;

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  late Note _note;
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 380));
  final _uuid = const Uuid();
  bool _isSaving = false;
  bool _showColorPicker = false;
  List<Attachment> _attachments = [];
  bool _isChecklistMode = false;
  Timer? _autoSaveTimer;

  // Rich text helpers — we store bold/italic as inline markdown-like markers for offline simplicity.
  bool _isBold = false;
  bool _isItalic = false;

  @override
  void initState() {
    super.initState();
    _note = widget.note ?? Note.create(type: widget.initialType);
    _isChecklistMode = _note.type == NoteType.checklist;
    _titleController = TextEditingController(text: _note.title);
    _contentController = TextEditingController(text: _note.content);
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);

    if (_note.id != Isar.autoIncrement && _note.id != 0) {
      _loadAttachments();
    }

    // Ensure note has an id quickly for attachments
    if (_note.id == Isar.autoIncrement || _note.id == 0) {
      _ensurePersisted();
    }
  }

  Future<void> _ensurePersisted() async {
    final id = await IsarService.instance.putNote(_note);
    _note.id = id;
  }

  Future<void> _loadAttachments() async {
    final atts = await IsarService.instance.getAttachmentsForNote(_note.id);
    if (mounted) setState(() => _attachments = atts);
  }

  void _onTextChanged() {
    _debouncer(() => _autoSave());
  }

  Future<void> _autoSave() async {
    if (!mounted) return;
    setState(() => _isSaving = true);
    _note.title = _titleController.text;
    _note.content = _contentController.text;
    _note.type = _isChecklistMode ? NoteType.checklist : NoteType.text;
    _note.updatedAt = DateTime.now();
    _note.refreshSearchIndex();
    await IsarService.instance.putNote(_note);
    if (mounted) setState(() => _isSaving = false);
  }

  Future<void> _immediateSave() async {
    _debouncer.dispose();
    await _autoSave();
  }

  @override
  void dispose() {
    // Final save if note non-empty, else delete empty draft
    if (_note.isEmpty && _note.id != 0 && _note.id != Isar.autoIncrement) {
      IsarService.instance.deleteNote(_note.id);
    } else {
      _note.title = _titleController.text;
      _note.content = _contentController.text;
      if (!_note.isEmpty) IsarService.instance.putNote(_note);
    }
    _titleController.dispose();
    _contentController.dispose();
    _debouncer.dispose();
    _autoSaveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = noteSurfaceColor(_note.colorValue, context);

    return PopScope(
      onPopInvokedWithResult: (_, __) => _immediateSave(),
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          elevation: 0,
          scrolledUnderElevation: 1,
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
          actions: [
            IconButton(
              icon: Icon(_note.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
              tooltip: _note.isPinned ? 'Unpin' : 'Pin',
              onPressed: () async {
                setState(() => _note.isPinned = !_note.isPinned);
                await _autoSave();
              },
            ),
            IconButton(icon: const Icon(Icons.palette_outlined), onPressed: () => setState(() => _showColorPicker = !_showColorPicker)),
            PopupMenuButton<String>(
              onSelected: _handleMenu,
              itemBuilder: (c) => [
                const PopupMenuItem(value: 'label', child: Text('Add label')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
                const PopupMenuItem(value: 'copy', child: Text('Make a copy')),
                const PopupMenuItem(value: 'archive', child: Text('Archive')),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            if (_showColorPicker) _ColorPickerStrip(selected: _note.colorValue, onPick: _pickColor),
            if (_attachments.isNotEmpty) _AttachmentStrip(attachments: _attachments, onDelete: _deleteAttachment),
            Expanded(
              child: RepaintBoundary(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  children: [
                    // Title
                    TextField(
                      controller: _titleController,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(hintText: 'Title', border: InputBorder.none, isDense: true),
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: null,
                    ),
                    const SizedBox(height: 4),
                    if (_isChecklistMode) _ChecklistEditor(note: _note, onChanged: _onChecklistChanged) else _ContentEditor(controller: _contentController),
                    const SizedBox(height: 16),
                    // Labels
                    if (_note.labelIds.isNotEmpty)
                      Wrap(
                        spacing: 6,
                        children: _note.labelIds
                            .map((id) => Chip(
                                  label: Text('Label #$id', style: Theme.of(context).textTheme.labelSmall),
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  onDeleted: () async {
                                    setState(() => _note.labelIds.remove(id));
                                    await _autoSave();
                                  },
                                  visualDensity: VisualDensity.compact,
                                ))
                            .toList(),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      'Edited ${_formatTime(_note.updatedAt)}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _EditorBottomBar(
          isSaving: _isSaving,
          isBold: _isBold,
          isItalic: _isItalic,
          isChecklist: _isChecklistMode,
          onBold: _toggleBold,
          onItalic: _toggleItalic,
          onChecklistToggle: () async {
            setState(() => _isChecklistMode = !_isChecklistMode);
            await _autoSave();
          },
          onAddBox: _addChecklistItem,
          onImage: _pickImage,
          onMore: () => _showMoreSheet(),
        ),
      ),
    );
  }

  Future<void> _pickColor(int color) async {
    setState(() => _note.colorValue = color);
    await _autoSave();
  }

  void _onChecklistChanged() {
    _note.refreshSearchIndex();
    _debouncer(() => IsarService.instance.putNote(_note));
    setState(() {});
  }

  void _addChecklistItem() {
    setState(() {
      _isChecklistMode = true;
      _note.checklist.add(ChecklistItem.create(text: '', uid: _uuid.v4()));
    });
    _onChecklistChanged();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final xfile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (xfile == null) return;
    // Ensure note persisted before attaching
    if (_note.id == 0 || _note.id == Isar.autoIncrement) {
      final id = await IsarService.instance.putNote(_note);
      _note.id = id;
    }
    final att = await IsarService.instance.addLocalAttachment(noteId: _note.id, sourcePath: xfile.path, type: AttachmentType.image);
    if (mounted) setState(() => _attachments.add(att));
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image attached (offline)')));
  }

  Future<void> _deleteAttachment(Attachment att) async {
    await IsarService.instance.deleteAttachment(att.id);
    setState(() => _attachments.removeWhere((a) => a.id == att.id));
  }

  void _toggleBold() {
    setState(() => _isBold = !_isBold);
    _wrapSelection('**');
  }

  void _toggleItalic() {
    setState(() => _isItalic = !_isItalic);
    _wrapSelection('*');
  }

  void _wrapSelection(String marker) {
    final sel = _contentController.selection;
    if (!sel.isValid || sel.isCollapsed) return;
    final text = _contentController.text;
    final before = text.substring(0, sel.start);
    final selected = text.substring(sel.start, sel.end);
    final after = text.substring(sel.end);
    final wrapped = '$marker$selected$marker';
    _contentController.value = TextEditingValue(
      text: '$before$wrapped$after',
      selection: TextSelection.collapsed(offset: sel.start + wrapped.length),
    );
  }

  void _handleMenu(String v) async {
    switch (v) {
      case 'label':
        _showLabelDialog();
        break;
      case 'delete':
        if (_note.id != 0) await IsarService.instance.deleteNote(_note.id);
        if (mounted) Navigator.pop(context);
        break;
      case 'copy':
        final copy = Note.create(
          title: _note.title,
          content: _note.content,
          type: _note.type,
          colorValue: _note.colorValue,
          labelIds: List.from(_note.labelIds),
          checklist: _note.checklist.map((c) => ChecklistItem.create(text: c.text, isChecked: c.isChecked, uid: _uuid.v4())).toList(),
        );
        await IsarService.instance.putNote(copy);
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note copied')));
        break;
      case 'archive':
        _note.isArchived = !_note.isArchived;
        await _autoSave();
        if (mounted) Navigator.pop(context);
        break;
    }
  }

  void _showLabelDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Add label'),
        content: TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'Label name', border: OutlineInputBorder())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final name = ctrl.text.trim();
              if (name.isEmpty) return;
              final label = Label(name: name);
              final labelId = await IsarService.instance.putLabel(label);
              setState(() {
                if (!_note.labelIds.contains(labelId)) _note.labelIds.add(labelId);
              });
              await _autoSave();
              if (c.mounted) Navigator.pop(c);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showMoreSheet() {
    showModalBottomSheet(
      context: context,
      builder: (c) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(leading: const Icon(Icons.delete_outline), title: const Text('Delete'), onTap: () => _handleMenu('delete')),
            ListTile(leading: const Icon(Icons.content_copy_outlined), title: const Text('Make a copy'), onTap: () => _handleMenu('copy')),
            ListTile(leading: const Icon(Icons.label_outline), title: const Text('Labels'), onTap: () => _handleMenu('label')),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _ContentEditor extends StatelessWidget {
  const _ContentEditor({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      minLines: 4,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
      decoration: const InputDecoration(hintText: 'Note', border: InputBorder.none, isDense: true),
      textCapitalization: TextCapitalization.sentences,
    );
  }
}

class _ChecklistEditor extends StatefulWidget {
  const _ChecklistEditor({required this.note, required this.onChanged});
  final Note note;
  final VoidCallback onChanged;

  @override
  State<_ChecklistEditor> createState() => _ChecklistEditorState();
}

class _ChecklistEditorState extends State<_ChecklistEditor> {
  final _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    final items = widget.note.checklist;
    return Column(
      children: [
        ...items.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;
          final ctrl = TextEditingController(text: item.text);
          // Avoid recreating controller every build for production: use keyed StateField pattern if needed.
          // For brevity we use onChanged callback.
          return Dismissible(
            key: ValueKey(item.uid.isEmpty ? 'idx_$idx' : item.uid),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              color: Theme.of(context).colorScheme.errorContainer,
              child: const Icon(Icons.delete_outline),
            ),
            onDismissed: (_) {
              setState(() => widget.note.checklist.removeAt(idx));
              widget.onChanged();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: item.isChecked,
                  onChanged: (v) {
                    setState(() => item.isChecked = v ?? false);
                    widget.onChanged();
                  },
                  visualDensity: VisualDensity.compact,
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    decoration: InputDecoration(
                      hintText: 'List item',
                      border: InputBorder.none,
                      isDense: true,
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    style: TextStyle(
                      decoration: item.isChecked ? TextDecoration.lineThrough : null,
                      color: item.isChecked ? Theme.of(context).colorScheme.onSurfaceVariant : null,
                    ),
                    onChanged: (v) {
                      item.text = v;
                      widget.onChanged();
                    },
                    onSubmitted: (_) {
                      setState(() => widget.note.checklist.insert(idx + 1, ChecklistItem.create(text: '', uid: _uuid.v4())));
                      widget.onChanged();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.drag_handle, size: 18),
                  onPressed: () {},
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          );
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () {
              setState(() => widget.note.checklist.add(ChecklistItem.create(text: '', uid: _uuid.v4())));
              widget.onChanged();
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text('List item'),
          ),
        ),
      ],
    );
  }
}

class _ColorPickerStrip extends StatelessWidget {
  const _ColorPickerStrip({required this.selected, required this.onPick});
  final int selected;
  final ValueChanged<int> onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: keepNoteColors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (c, i) {
          final color = keepNoteColors[i];
          final isSel = color == selected;
          return GestureDetector(
            onTap: () => onPick(color),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Color(color),
                shape: BoxShape.circle,
                border: Border.all(color: isSel ? Theme.of(context).colorScheme.primary : Colors.black26, width: isSel ? 3 : 1),
              ),
              child: isSel ? Icon(Icons.check, size: 18, color: color == 0xFFFFFFFF ? Colors.black54 : Colors.black87) : null,
            ),
          );
        },
      ),
    );
  }
}

class _AttachmentStrip extends StatelessWidget {
  const _AttachmentStrip({required this.attachments, required this.onDelete});
  final List<Attachment> attachments;
  final ValueChanged<Attachment> onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        itemCount: attachments.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (c, i) {
          final att = attachments[i];
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(File(att.localPath), width: 110, height: 90, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                          width: 110,
                          height: 90,
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.broken_image_outlined),
                        )),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                  onTap: () => onDelete(att),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.close, size: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EditorBottomBar extends StatelessWidget {
  const _EditorBottomBar({
    required this.isSaving,
    required this.isBold,
    required this.isItalic,
    required this.isChecklist,
    required this.onBold,
    required this.onItalic,
    required this.onChecklistToggle,
    required this.onAddBox,
    required this.onImage,
    required this.onMore,
  });

  final bool isSaving;
  final bool isBold;
  final bool isItalic;
  final bool isChecklist;
  final VoidCallback onBold;
  final VoidCallback onItalic;
  final VoidCallback onChecklistToggle;
  final VoidCallback onAddBox;
  final VoidCallback onImage;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: SafeArea(
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.format_bold, color: isBold ? Theme.of(context).colorScheme.primary : null),
                tooltip: 'Bold',
                onPressed: onBold,
              ),
              IconButton(
                icon: Icon(Icons.format_italic, color: isItalic ? Theme.of(context).colorScheme.primary : null),
                tooltip: 'Italic',
                onPressed: onItalic,
              ),
              IconButton(
                icon: Icon(isChecklist ? Icons.view_agenda_outlined : Icons.check_box_outlined),
                tooltip: isChecklist ? 'Text mode' : 'Checklist mode',
                onPressed: onChecklistToggle,
              ),
              if (isChecklist) IconButton(icon: const Icon(Icons.add_box_outlined), tooltip: 'Add item', onPressed: onAddBox),
              IconButton(icon: const Icon(Icons.image_outlined), tooltip: 'Add image', onPressed: onImage),
              const Spacer(),
              if (isSaving)
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2)),
                ),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: onMore),
            ],
          ),
        ),
      ),
    );
  }
}
