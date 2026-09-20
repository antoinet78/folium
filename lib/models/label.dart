import 'package:isar/isar.dart';

part 'label.g.dart';

@collection
class Label {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String name;

  /// Hex color string for label chip, e.g. "#FFDB4437"
  String? colorHex;

  @Index()
  late DateTime createdAt;

  Label({required this.name, this.colorHex, DateTime? createdAtParam})
      : createdAt = createdAtParam ?? DateTime.now();

  Label.create({required String name, this.colorHex}) : name = name.trim(), createdAt = DateTime.now();
}
