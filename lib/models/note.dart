import 'package:isar/isar.dart';

part 'note.g.dart';

/// Embedded checklist item — stored inline in Note, zero joins.
@embedded
class ChecklistItem {
  String text = '';
  bool isChecked = false;

  /// Stable id for AnimatedList / Dismissible keys.
  String uid = '';

  ChecklistItem();
  ChecklistItem.create({required this.text, this.isChecked = false, required this.uid});
}

/// Ordering / view helpers
enum NoteType { text, checklist, drawing, audio, image }

@collection
class Note {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String title;

  @Index(caseSensitive: false)
  late String content;

  /// Full-text search helper: normalized lowercased concat of title+content.
  /// Isar has no native FTS5, we emulate via case-insensitive contains on indexed string + in-memory ranking.
  /// For >100 records the query is offloaded to an Isolate.
  @Index(caseSensitive: false)
  late String searchIndex;

  @enumerated
  late NoteType type;

  @Index()
  bool isPinned = false;

  @Index()
  bool isArchived = false;

  @Index()
  bool isTrashed = false;

  /// Background color ARGB int (0xFFFFFFFF = default white). Material 3 tinted.
  int colorValue = 0xFFFFFFFF;

  /// Label ids (many-to-many via id list, no link overhead for offline speed).
  List<int> labelIds = [];

  /// Inline checklist (only used when type == checklist, but available for any note).
  List<ChecklistItem> checklist = [];

  /// Local attachment ids (resolved via attachment collection).
  List<int> attachmentIds = [];

  @Index()
  late DateTime createdAt;

  @Index()
  late DateTime updatedAt;

  /// For staggered grid -- optional cached height hint to avoid layout thrash.
  double? cachedHeightHint;

  Note();

  Note.create({
    String title = '',
    String content = '',
    this.type = NoteType.text,
    this.isPinned = false,
    this.colorValue = 0xFFFFFFFF,
    List<int>? labelIds,
    List<ChecklistItem>? checklist,
  })  : title = title,
        content = content,
        searchIndex = _buildSearchIndex(title, content, checklist),
        createdAt = DateTime.now(),
        updatedAt = DateTime.now() {
    this.labelIds = labelIds ?? [];
    this.checklist = checklist ?? [];
  }

  static String _buildSearchIndex(String title, String content, List<ChecklistItem>? items) {
    final buf = StringBuffer()..write(title.toLowerCase())..write(' ')..write(content.toLowerCase());
    if (items != null) {
      for (final c in items) {
        buf.write(' ');
        buf.write(c.text.toLowerCase());
      }
    }
    return buf.toString();
  }

  void refreshSearchIndex() {
    searchIndex = _buildSearchIndex(title, content, checklist);
    updatedAt = DateTime.now();
  }

  bool get isEmpty =>
      title.trim().isEmpty && content.trim().isEmpty && checklist.every((c) => c.text.trim().isEmpty) && attachmentIds.isEmpty;

  /// Toggle checklist item via uid (used by editor without full rebuild).
  void toggleChecklistItem(String uid) {
    for (final item in checklist) {
      if (item.uid == uid) {
        item.isChecked = !item.isChecked;
        break;
      }
    }
    refreshSearchIndex();
  }
}
