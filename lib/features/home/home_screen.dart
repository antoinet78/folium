import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../core/database/isar_service.dart';
import '../../core/database/providers.dart';
import '../../core/utils/debouncer.dart';
import '../../models/note.dart';
import '../../widgets/bottom_create_bar.dart';
import '../../widgets/note_card.dart';
import '../../widgets/search_bar.dart';
import '../editor/note_editor_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  final _searchDebouncer = Debouncer(delay: const Duration(milliseconds: 220));
  // Cache attachment preview paths to avoid async per-card
  final Map<int, String?> _previewCache = {};

  @override
  void dispose() {
    _searchController.dispose();
    _searchDebouncer.dispose();
    super.dispose();
  }

  Future<void> _openEditor({Note? note, NoteType initialType = NoteType.text}) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => NoteEditorScreen(note: note, initialType: initialType)));
  }

  Future<void> _createNote(NoteType type) async {
    final svc = IsarService.instance;
    final note = Note.create(type: type);
    final id = await svc.putNote(note);
    final saved = await svc.getNoteById(id);
    if (saved != null && mounted) {
      await _openEditor(note: saved);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewMode = ref.watch(homeViewModeProvider);
    final isMasonry = viewMode == HomeViewMode.masonry;
    final filteredAsync = ref.watch(filteredNotesProvider);
    final selectedIds = ref.watch(selectedNoteIdsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: _FoliumDrawer(onClose: () => Navigator.pop(context)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: KeepSearchBar(
                controller: _searchController,
                isMasonry: isMasonry,
                onChanged: (v) => _searchDebouncer(() => ref.read(searchQueryProvider.notifier).state = v),
                onViewToggle: () => ref.read(homeViewModeProvider.notifier).state =
                    isMasonry ? HomeViewMode.singleColumn : HomeViewMode.masonry,
              ),
            ),
            Expanded(
              child: filteredAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (notes) {
                  if (notes.isEmpty) {
                    final q = ref.read(searchQueryProvider).trim();
                    return _EmptyState(query: q, onCreate: () => _createNote(NoteType.text));
                  }
                  // We already have pinned/unpinned split providers; use them if no custom scope.
                  // But when search active, filteredNotesProvider already filtered, so we re-split from notes.
                  final p = notes.where((n) => n.isPinned).toList();
                  final u = notes.where((n) => !n.isPinned).toList();

                  return CustomScrollView(
                    slivers: [
                      if (p.isNotEmpty) ...[
                        const _SectionHeader(title: 'PINNED'),
                        _NotesSliver(
                          notes: p,
                          isMasonry: isMasonry,
                          selectedIds: selectedIds,
                          previewCache: _previewCache,
                          onTap: (n) => _openEditor(note: n),
                          onLongPress: (n) => _toggleSelect(n.id),
                        ),
                      ],
                      if (u.isNotEmpty) ...[
                        if (p.isNotEmpty) const _SectionHeader(title: 'OTHERS'),
                        _NotesSliver(
                          notes: u,
                          isMasonry: isMasonry,
                          selectedIds: selectedIds,
                          previewCache: _previewCache,
                          onTap: (n) {
                            if (selectedIds.isNotEmpty) {
                              _toggleSelect(n.id);
                            } else {
                              _openEditor(note: n);
                            }
                          },
                          onLongPress: (n) => _toggleSelect(n.id),
                        ),
                      ],
                      const SliverToBoxAdapter(child: SizedBox(height: 80)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: selectedIds.isEmpty
          ? BottomCreateBar(
              onChecklist: () => _createNote(NoteType.checklist),
              onDrawing: () => _createNote(NoteType.drawing),
              onAudio: () => _createNote(NoteType.audio),
              onImage: () => _createNote(NoteType.image),
              onText: () => _createNote(NoteType.text),
            )
          : _SelectionBar(
              count: selectedIds.length,
              onClear: () => ref.read(selectedNoteIdsProvider.notifier).state = {},
              onPin: () => _bulkPin(selectedIds),
              onArchive: () => _bulkArchive(selectedIds),
              onDelete: () => _bulkDelete(selectedIds),
            ),
    );
  }

  void _toggleSelect(int id) {
    final cur = Set<int>.from(ref.read(selectedNoteIdsProvider));
    if (cur.contains(id)) {
      cur.remove(id);
    } else {
      cur.add(id);
    }
    ref.read(selectedNoteIdsProvider.notifier).state = cur;
  }

  Future<void> _bulkPin(Set<int> ids) async {
    for (final id in ids) {
      await IsarService.instance.togglePin(id);
    }
    ref.read(selectedNoteIdsProvider.notifier).state = {};
  }

  Future<void> _bulkArchive(Set<int> ids) async {
    for (final id in ids) {
      await IsarService.instance.toggleArchive(id);
    }
    ref.read(selectedNoteIdsProvider.notifier).state = {};
  }

  Future<void> _bulkDelete(Set<int> ids) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Move to trash?'),
        content: Text('${ids.length} note(s) will be moved to trash.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Move to trash')),
        ],
      ),
    );
    if (confirm != true) return;
    for (final id in ids) {
      await IsarService.instance.trashNote(id);
    }
    if (mounted) ref.read(selectedNoteIdsProvider.notifier).state = {};
  }
}

class _NotesSliver extends StatelessWidget {
  const _NotesSliver({
    required this.notes,
    required this.isMasonry,
    required this.selectedIds,
    required this.previewCache,
    required this.onTap,
    required this.onLongPress,
  });

  final List<Note> notes;
  final bool isMasonry;
  final Set<int> selectedIds;
  final Map<int, String?> previewCache;
  final ValueChanged<Note> onTap;
  final ValueChanged<Note> onLongPress;

  @override
  Widget build(BuildContext context) {
    if (isMasonry) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        sliver: SliverMasonryGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childCount: notes.length,
          itemBuilder: (context, i) {
            final n = notes[i];
            return NoteCard(
              note: n,
              isSelected: selectedIds.contains(n.id),
              attachmentPreviewPath: _resolvePreview(n),
              onTap: () => onTap(n),
              onLongPress: () => onLongPress(n),
            );
          },
        ),
      );
    } else {
      return SliverList.builder(
        itemCount: notes.length,
        itemBuilder: (context, i) {
          final n = notes[i];
          return Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: NoteCard(
              note: n,
              isSelected: selectedIds.contains(n.id),
              attachmentPreviewPath: _resolvePreview(n),
              onTap: () => onTap(n),
              onLongPress: () => onLongPress(n),
            ),
          );
        },
      );
    }
  }

  String? _resolvePreview(Note n) {
    if (n.attachmentIds.isEmpty) return null;
    // We cache the first attachment's path lookup lazily; for now return null and let editor show.
    // To avoid async in build, we rely on sync cache populated elsewhere. Show null initially.
    return previewCache[n.id];
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Text(title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.query, required this.onCreate});
  final String query;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final isSearching = query.isNotEmpty;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSearching ? Icons.search_off : Icons.eco_outlined,
                size: 96, color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text(
              isSearching ? 'No notes matching "$query"' : 'Notes you add appear here',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            if (!isSearching) ...[
              const SizedBox(height: 12),
              FilledButton.icon(onPressed: onCreate, icon: const Icon(Icons.add), label: const Text('Create note')),
            ],
          ],
        ),
      ),
    );
  }
}

class _SelectionBar extends StatelessWidget {
  const _SelectionBar({required this.count, required this.onClear, required this.onPin, required this.onArchive, required this.onDelete});
  final int count;
  final VoidCallback onClear;
  final VoidCallback onPin;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      elevation: 8,
      child: SafeArea(
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.close), onPressed: onClear),
              Text('$count selected', style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              IconButton(icon: const Icon(Icons.push_pin_outlined), tooltip: 'Pin', onPressed: onPin),
              IconButton(icon: const Icon(Icons.archive_outlined), tooltip: 'Archive', onPressed: onArchive),
              IconButton(icon: const Icon(Icons.delete_outline), tooltip: 'Trash', onPressed: onDelete),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _FoliumDrawer extends StatelessWidget {
  const _FoliumDrawer({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (_) => onClose(),
      selectedIndex: 0,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F1E8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD4C7B4)),
                ),
                child: const Icon(Icons.eco_outlined, size: 22, color: Color(0xFF2D4A22)),
              ),
              const SizedBox(width: 12),
              Text('Folium', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        const NavigationDrawerDestination(icon: Icon(Icons.eco_outlined), label: Text('Notes')),
        const NavigationDrawerDestination(icon: Icon(Icons.notifications_none), label: Text('Reminders')),
        const NavigationDrawerDestination(icon: Icon(Icons.label_outline), label: Text('Labels')),
        const Divider(),
        const NavigationDrawerDestination(icon: Icon(Icons.archive_outlined), label: Text('Archive')),
        const NavigationDrawerDestination(icon: Icon(Icons.delete_outline), label: Text('Trash')),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('100% offline • Zero network permissions',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ),
      ],
    );
  }
}
