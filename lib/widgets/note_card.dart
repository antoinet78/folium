import 'dart:io';

import 'package:flutter/material.dart';

import '../core/utils/note_colors.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.attachmentPreviewPath,
  });

  final Note note;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final String? attachmentPreviewPath;

  @override
  Widget build(BuildContext context) {
    final bg = noteSurfaceColor(note.colorValue, context);
    final border = noteBorderColor(note.colorValue);

    return RepaintBoundary(
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? Theme.of(context).colorScheme.primary : border, width: isSelected ? 2 : 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (attachmentPreviewPath != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                    child: Image.file(
                      File(attachmentPreviewPath!),
                      fit: BoxFit.cover,
                      height: 140,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (note.title.trim().isNotEmpty)
                        Text(
                          note.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, height: 1.25),
                        ),
                      if (note.title.trim().isNotEmpty && _hasBody) const SizedBox(height: 6),
                      if (note.type == NoteType.checklist && note.checklist.isNotEmpty)
                        ...note.checklist.take(6).map((c) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(c.isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                                      size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      c.text,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        decoration: c.isChecked ? TextDecoration.lineThrough : null,
                                        color: c.isChecked
                                            ? Theme.of(context).colorScheme.onSurfaceVariant
                                            : Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      if (note.type == NoteType.checklist && note.checklist.length > 6)
                        Text('+ ${note.checklist.length - 6} more',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                      if (note.type != NoteType.checklist && note.content.trim().isNotEmpty)
                        Text(
                          note.content,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.35, color: Theme.of(context).colorScheme.onSurface),
                        ),
                      if (note.labelIds.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: note.labelIds.map((id) => _LabelChip(labelId: id)).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _hasBody =>
      note.content.trim().isNotEmpty || (note.type == NoteType.checklist && note.checklist.isNotEmpty);
}

class _LabelChip extends StatelessWidget {
  const _LabelChip({required this.labelId});
  final int labelId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(8)),
      child: Text('#$labelId', style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
