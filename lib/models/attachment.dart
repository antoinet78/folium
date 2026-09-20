import 'package:isar/isar.dart';

part 'attachment.g.dart';

enum AttachmentType { image, drawing, audio, file }

@collection
class Attachment {
  Id id = Isar.autoIncrement;

  @Index()
  late int noteId;

  @enumerated
  late AttachmentType type;

  /// Absolute local file path under app documents directory (never external URL).
  late String localPath;

  /// Optional original file name.
  String? fileName;

  /// MIME type e.g. image/jpeg
  String? mimeType;

  int? fileSizeBytes;
  int? width;
  int? height;

  @Index()
  late DateTime createdAt;

  Attachment({
    required this.noteId,
    required this.type,
    required this.localPath,
    this.fileName,
    this.mimeType,
    this.fileSizeBytes,
    this.width,
    this.height,
    DateTime? createdAtParam,
  }) : createdAt = createdAtParam ?? DateTime.now();
}
