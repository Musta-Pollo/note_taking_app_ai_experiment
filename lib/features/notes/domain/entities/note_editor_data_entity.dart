import 'package:drift/drift.dart' hide JsonKey;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';

part 'note_editor_data_entity.freezed.dart';

@freezed
class NoteEditorDataEntity with _$NoteEditorDataEntity {
  const NoteEditorDataEntity._();

  const factory NoteEditorDataEntity({
    required String id,
    required String noteId,
    required String dataB64,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    String? instanceId,
    String? deviceId,
    @Default(false) bool isRemote,
  }) = _NoteEditorDataEntity;

  /// Create new editor data for a note
  factory NoteEditorDataEntity.create({
    required String noteId,
    required String crdtUpdateB64,
    required String userId,
    String? deviceId,
  }) {
    final now = DateTime.now().toUtc();
    return NoteEditorDataEntity(
      id: const Uuid().v4(),
      noteId: noteId,
      dataB64: crdtUpdateB64,
      userId: userId,
      deviceId: deviceId,
      createdAt: now,
      updatedAt: now,
      isRemote: false,
    );
  }

  /// Create from database record
  factory NoteEditorDataEntity.fromDatabase(NoteeditordataData editorData) {
    return NoteEditorDataEntity(
      id: editorData.id,
      noteId: editorData.noteId,
      dataB64: editorData.dataB64,
      userId: editorData.userId,
      deviceId: editorData.deviceId,
      createdAt: editorData.createdAt,
      updatedAt: editorData.updatedAt,
      deletedAt: editorData.deletedAt,
      instanceId: editorData.instanceId,
      isRemote: editorData.isRemote,
    );
  }

  /// Convert to database companion
  NoteeditordataCompanion toCompanion({bool isUpdate = false}) {
    return NoteeditordataCompanion(
      id: Value(id),
      noteId: Value(noteId),
      dataB64: Value(dataB64),
      deviceId: Value(deviceId),
      userId: Value(userId),
      createdAt: isUpdate ? const Value.absent() : Value(createdAt),
      updatedAt: Value(DateTime.now().toUtc()),
      deletedAt: Value(deletedAt),
      instanceId: Value(instanceId),
      isRemote: const Value(false),
    );
  }
}
