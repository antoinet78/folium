// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNoteCollection on Isar {
  IsarCollection<Note> get notes => this.collection();
}

const NoteSchema = CollectionSchema(
  name: r'Note',
  id: 6284318083599466921,
  properties: {
    r'attachmentIds': PropertySchema(
      id: 0,
      name: r'attachmentIds',
      type: IsarType.longList,
    ),
    r'cachedHeightHint': PropertySchema(
      id: 1,
      name: r'cachedHeightHint',
      type: IsarType.double,
    ),
    r'checklist': PropertySchema(
      id: 2,
      name: r'checklist',
      type: IsarType.objectList,
      target: r'ChecklistItem',
    ),
    r'colorValue': PropertySchema(
      id: 3,
      name: r'colorValue',
      type: IsarType.long,
    ),
    r'content': PropertySchema(
      id: 4,
      name: r'content',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 5,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isArchived': PropertySchema(
      id: 6,
      name: r'isArchived',
      type: IsarType.bool,
    ),
    r'isEmpty': PropertySchema(
      id: 7,
      name: r'isEmpty',
      type: IsarType.bool,
    ),
    r'isPinned': PropertySchema(
      id: 8,
      name: r'isPinned',
      type: IsarType.bool,
    ),
    r'isTrashed': PropertySchema(
      id: 9,
      name: r'isTrashed',
      type: IsarType.bool,
    ),
    r'labelIds': PropertySchema(
      id: 10,
      name: r'labelIds',
      type: IsarType.longList,
    ),
    r'searchIndex': PropertySchema(
      id: 11,
      name: r'searchIndex',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 12,
      name: r'title',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 13,
      name: r'type',
      type: IsarType.byte,
      enumMap: _NotetypeEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 14,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _noteEstimateSize,
  serialize: _noteSerialize,
  deserialize: _noteDeserialize,
  deserializeProp: _noteDeserializeProp,
  idName: r'id',
  indexes: {
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'content': IndexSchema(
      id: 6193209363630369380,
      name: r'content',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'content',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'searchIndex': IndexSchema(
      id: 8181981079648667170,
      name: r'searchIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchIndex',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'isPinned': IndexSchema(
      id: 7607338673446676027,
      name: r'isPinned',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPinned',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isArchived': IndexSchema(
      id: 655844772568347876,
      name: r'isArchived',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isArchived',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isTrashed': IndexSchema(
      id: 3056854837835265747,
      name: r'isTrashed',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isTrashed',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'ChecklistItem': ChecklistItemSchema},
  getId: _noteGetId,
  getLinks: _noteGetLinks,
  attach: _noteAttach,
  version: '3.1.0+1',
);

int _noteEstimateSize(
  Note object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.attachmentIds.length * 8;
  bytesCount += 3 + object.checklist.length * 3;
  {
    final offsets = allOffsets[ChecklistItem]!;
    for (var i = 0; i < object.checklist.length; i++) {
      final value = object.checklist[i];
      bytesCount +=
          ChecklistItemSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.content.length * 3;
  bytesCount += 3 + object.labelIds.length * 8;
  bytesCount += 3 + object.searchIndex.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _noteSerialize(
  Note object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.attachmentIds);
  writer.writeDouble(offsets[1], object.cachedHeightHint);
  writer.writeObjectList<ChecklistItem>(
    offsets[2],
    allOffsets,
    ChecklistItemSchema.serialize,
    object.checklist,
  );
  writer.writeLong(offsets[3], object.colorValue);
  writer.writeString(offsets[4], object.content);
  writer.writeDateTime(offsets[5], object.createdAt);
  writer.writeBool(offsets[6], object.isArchived);
  writer.writeBool(offsets[7], object.isEmpty);
  writer.writeBool(offsets[8], object.isPinned);
  writer.writeBool(offsets[9], object.isTrashed);
  writer.writeLongList(offsets[10], object.labelIds);
  writer.writeString(offsets[11], object.searchIndex);
  writer.writeString(offsets[12], object.title);
  writer.writeByte(offsets[13], object.type.index);
  writer.writeDateTime(offsets[14], object.updatedAt);
}

Note _noteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Note();
  object.attachmentIds = reader.readLongList(offsets[0]) ?? [];
  object.cachedHeightHint = reader.readDoubleOrNull(offsets[1]);
  object.checklist = reader.readObjectList<ChecklistItem>(
        offsets[2],
        ChecklistItemSchema.deserialize,
        allOffsets,
        ChecklistItem(),
      ) ??
      [];
  object.colorValue = reader.readLong(offsets[3]);
  object.content = reader.readString(offsets[4]);
  object.createdAt = reader.readDateTime(offsets[5]);
  object.id = id;
  object.isArchived = reader.readBool(offsets[6]);
  object.isPinned = reader.readBool(offsets[8]);
  object.isTrashed = reader.readBool(offsets[9]);
  object.labelIds = reader.readLongList(offsets[10]) ?? [];
  object.searchIndex = reader.readString(offsets[11]);
  object.title = reader.readString(offsets[12]);
  object.type = _NotetypeValueEnumMap[reader.readByteOrNull(offsets[13])] ??
      NoteType.text;
  object.updatedAt = reader.readDateTime(offsets[14]);
  return object;
}

P _noteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<ChecklistItem>(
            offset,
            ChecklistItemSchema.deserialize,
            allOffsets,
            ChecklistItem(),
          ) ??
          []) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readLongList(offset) ?? []) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (_NotetypeValueEnumMap[reader.readByteOrNull(offset)] ??
          NoteType.text) as P;
    case 14:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _NotetypeEnumValueMap = {
  'text': 0,
  'checklist': 1,
  'drawing': 2,
  'audio': 3,
  'image': 4,
};
const _NotetypeValueEnumMap = {
  0: NoteType.text,
  1: NoteType.checklist,
  2: NoteType.drawing,
  3: NoteType.audio,
  4: NoteType.image,
};

Id _noteGetId(Note object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _noteGetLinks(Note object) {
  return [];
}

void _noteAttach(IsarCollection<dynamic> col, Id id, Note object) {
  object.id = id;
}

extension NoteQueryWhereSort on QueryBuilder<Note, Note, QWhere> {
  QueryBuilder<Note, Note, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Note, Note, QAfterWhere> anyIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isPinned'),
      );
    });
  }

  QueryBuilder<Note, Note, QAfterWhere> anyIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isArchived'),
      );
    });
  }

  QueryBuilder<Note, Note, QAfterWhere> anyIsTrashed() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isTrashed'),
      );
    });
  }

  QueryBuilder<Note, Note, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<Note, Note, QAfterWhere> anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }
}

extension NoteQueryWhere on QueryBuilder<Note, Note, QWhereClause> {
  QueryBuilder<Note, Note, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> titleEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> titleNotEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> contentEqualTo(String content) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'content',
        value: [content],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> contentNotEqualTo(
      String content) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'content',
              lower: [],
              upper: [content],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'content',
              lower: [content],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'content',
              lower: [content],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'content',
              lower: [],
              upper: [content],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> searchIndexEqualTo(
      String searchIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'searchIndex',
        value: [searchIndex],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> searchIndexNotEqualTo(
      String searchIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchIndex',
              lower: [],
              upper: [searchIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchIndex',
              lower: [searchIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchIndex',
              lower: [searchIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'searchIndex',
              lower: [],
              upper: [searchIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> isPinnedEqualTo(bool isPinned) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPinned',
        value: [isPinned],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> isPinnedNotEqualTo(
      bool isPinned) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPinned',
              lower: [],
              upper: [isPinned],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPinned',
              lower: [isPinned],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPinned',
              lower: [isPinned],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPinned',
              lower: [],
              upper: [isPinned],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> isArchivedEqualTo(
      bool isArchived) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isArchived',
        value: [isArchived],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> isArchivedNotEqualTo(
      bool isArchived) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isArchived',
              lower: [],
              upper: [isArchived],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isArchived',
              lower: [isArchived],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isArchived',
              lower: [isArchived],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isArchived',
              lower: [],
              upper: [isArchived],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> isTrashedEqualTo(bool isTrashed) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isTrashed',
        value: [isTrashed],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> isTrashedNotEqualTo(
      bool isTrashed) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isTrashed',
              lower: [],
              upper: [isTrashed],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isTrashed',
              lower: [isTrashed],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isTrashed',
              lower: [isTrashed],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isTrashed',
              lower: [],
              upper: [isTrashed],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> createdAtEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> createdAtNotEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> updatedAtEqualTo(
      DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> updatedAtNotEqualTo(
      DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> updatedAtGreaterThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [updatedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> updatedAtLessThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [],
        upper: [updatedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterWhereClause> updatedAtBetween(
    DateTime lowerUpdatedAt,
    DateTime upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [lowerUpdatedAt],
        includeLower: includeLower,
        upper: [upperUpdatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NoteQueryFilter on QueryBuilder<Note, Note, QFilterCondition> {
  QueryBuilder<Note, Note, QAfterFilterCondition> attachmentIdsElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attachmentIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition>
      attachmentIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attachmentIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> attachmentIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attachmentIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> attachmentIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attachmentIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> attachmentIdsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> attachmentIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> attachmentIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> attachmentIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition>
      attachmentIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> attachmentIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> cachedHeightHintIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cachedHeightHint',
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> cachedHeightHintIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cachedHeightHint',
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> cachedHeightHintEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cachedHeightHint',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> cachedHeightHintGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cachedHeightHint',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> cachedHeightHintLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cachedHeightHint',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> cachedHeightHintBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cachedHeightHint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> checklistLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> checklistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> checklistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> checklistLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> checklistLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> checklistLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'checklist',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> colorValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> colorValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> colorValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> colorValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> isArchivedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isArchived',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> isEmptyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEmpty',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> isPinnedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPinned',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> isTrashedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTrashed',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'labelIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'labelIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'labelIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'labelIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labelIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labelIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labelIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labelIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labelIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> labelIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'labelIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchIndex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> searchIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> typeEqualTo(NoteType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> typeGreaterThan(
    NoteType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> typeLessThan(
    NoteType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> typeBetween(
    NoteType lower,
    NoteType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Note, Note, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NoteQueryObject on QueryBuilder<Note, Note, QFilterCondition> {
  QueryBuilder<Note, Note, QAfterFilterCondition> checklistElement(
      FilterQuery<ChecklistItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'checklist');
    });
  }
}

extension NoteQueryLinks on QueryBuilder<Note, Note, QFilterCondition> {}

extension NoteQuerySortBy on QueryBuilder<Note, Note, QSortBy> {
  QueryBuilder<Note, Note, QAfterSortBy> sortByCachedHeightHint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedHeightHint', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByCachedHeightHintDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedHeightHint', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEmpty', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsEmptyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEmpty', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsTrashed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTrashed', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByIsTrashedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTrashed', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortBySearchIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchIndex', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortBySearchIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchIndex', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension NoteQuerySortThenBy on QueryBuilder<Note, Note, QSortThenBy> {
  QueryBuilder<Note, Note, QAfterSortBy> thenByCachedHeightHint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedHeightHint', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByCachedHeightHintDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedHeightHint', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEmpty', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsEmptyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEmpty', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsTrashed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTrashed', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByIsTrashedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTrashed', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenBySearchIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchIndex', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenBySearchIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchIndex', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Note, Note, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension NoteQueryWhereDistinct on QueryBuilder<Note, Note, QDistinct> {
  QueryBuilder<Note, Note, QDistinct> distinctByAttachmentIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attachmentIds');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByCachedHeightHint() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedHeightHint');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorValue');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isArchived');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEmpty');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPinned');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByIsTrashed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTrashed');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByLabelIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'labelIds');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctBySearchIndex(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchIndex', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<Note, Note, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension NoteQueryProperty on QueryBuilder<Note, Note, QQueryProperty> {
  QueryBuilder<Note, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Note, List<int>, QQueryOperations> attachmentIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attachmentIds');
    });
  }

  QueryBuilder<Note, double?, QQueryOperations> cachedHeightHintProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedHeightHint');
    });
  }

  QueryBuilder<Note, List<ChecklistItem>, QQueryOperations>
      checklistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklist');
    });
  }

  QueryBuilder<Note, int, QQueryOperations> colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorValue');
    });
  }

  QueryBuilder<Note, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<Note, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Note, bool, QQueryOperations> isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isArchived');
    });
  }

  QueryBuilder<Note, bool, QQueryOperations> isEmptyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEmpty');
    });
  }

  QueryBuilder<Note, bool, QQueryOperations> isPinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPinned');
    });
  }

  QueryBuilder<Note, bool, QQueryOperations> isTrashedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTrashed');
    });
  }

  QueryBuilder<Note, List<int>, QQueryOperations> labelIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'labelIds');
    });
  }

  QueryBuilder<Note, String, QQueryOperations> searchIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchIndex');
    });
  }

  QueryBuilder<Note, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Note, NoteType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Note, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ChecklistItemSchema = Schema(
  name: r'ChecklistItem',
  id: 6734995178179243527,
  properties: {
    r'isChecked': PropertySchema(
      id: 0,
      name: r'isChecked',
      type: IsarType.bool,
    ),
    r'text': PropertySchema(
      id: 1,
      name: r'text',
      type: IsarType.string,
    ),
    r'uid': PropertySchema(
      id: 2,
      name: r'uid',
      type: IsarType.string,
    )
  },
  estimateSize: _checklistItemEstimateSize,
  serialize: _checklistItemSerialize,
  deserialize: _checklistItemDeserialize,
  deserializeProp: _checklistItemDeserializeProp,
);

int _checklistItemEstimateSize(
  ChecklistItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.text.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _checklistItemSerialize(
  ChecklistItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isChecked);
  writer.writeString(offsets[1], object.text);
  writer.writeString(offsets[2], object.uid);
}

ChecklistItem _checklistItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChecklistItem();
  object.isChecked = reader.readBool(offsets[0]);
  object.text = reader.readString(offsets[1]);
  object.uid = reader.readString(offsets[2]);
  return object;
}

P _checklistItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ChecklistItemQueryFilter
    on QueryBuilder<ChecklistItem, ChecklistItem, QFilterCondition> {
  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      isCheckedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isChecked',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition> uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition> uidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition> uidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistItem, ChecklistItem, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }
}

extension ChecklistItemQueryObject
    on QueryBuilder<ChecklistItem, ChecklistItem, QFilterCondition> {}
