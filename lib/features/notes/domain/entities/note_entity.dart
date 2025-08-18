import 'package:drift/drift.dart' hide JsonKey;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/notes_table.dart';

part 'note_entity.freezed.dart';

@freezed
class NoteEntity with _$NoteEntity {
  const NoteEntity._();

  const factory NoteEntity({
    required String id,
    required String content,
    required String categoryId,
    required String userId,
    required NoteType noteType,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    String? instanceId,
    required bool isRemote,
  }) = _NoteEntity;

  /// Create new simple note
  factory NoteEntity.createSimple({
    required String content,
    required String categoryId,
    required String userId,
  }) {
    final now = DateTime.now().toUtc();
    return NoteEntity(
      id: const Uuid().v4(),
      content: content,
      categoryId: categoryId,
      userId: userId,
      noteType: NoteType.simple,
      createdAt: now,
      updatedAt: now,
      isRemote: false,
    );
  }

  /// Create new full editor note
  factory NoteEntity.createFull({
    required String categoryId,
    required String userId,
    String content = '',
  }) {
    final now = DateTime.now().toUtc();
    return NoteEntity(
      id: const Uuid().v4(),
      content: content,
      categoryId: categoryId,
      userId: userId,
      noteType: NoteType.full,
      createdAt: now,
      updatedAt: now,
      isRemote: false,
    );
  }

  /// Create from database record
  factory NoteEntity.fromDatabase(NoteData note) {
    return NoteEntity(
      id: note.id,
      content: note.content,
      categoryId: note.categoryId,
      userId: note.userId,
      noteType: note.noteType,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
      deletedAt: note.deletedAt,
      instanceId: note.instanceId,
      isRemote: note.isRemote,
    );
  }

  /// Convert to database companion
  NoteCompanion toCompanion({bool isUpdate = false}) {
    return NoteCompanion(
      id: Value(id),
      content: Value(content),
      categoryId: Value(categoryId),
      userId: Value(userId),
      noteType: Value(noteType),
      createdAt: isUpdate ? const Value.absent() : Value(createdAt),
      updatedAt: Value(DateTime.now().toUtc()),
      deletedAt: Value(deletedAt),
      instanceId: Value(instanceId),
      isRemote: const Value(false),
    );
  }
}
