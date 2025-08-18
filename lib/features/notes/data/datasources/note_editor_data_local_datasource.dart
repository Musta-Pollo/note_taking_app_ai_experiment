import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/note_editor_data_entity.dart';

class NoteEditorDataLocalDataSource {
  final AppDatabase _database;

  NoteEditorDataLocalDataSource(this._database);

  Stream<List<NoteEditorDataEntity>> getEditorDataByNoteId(String noteId) {
    return (_database.select(_database.noteeditordata)
          ..where((ed) => ed.noteId.equals(noteId) & ed.deletedAt.isNull())
          ..orderBy([(ed) => OrderingTerm.desc(ed.createdAt)]))
        .watch()
        .map((editorDataList) => editorDataList.map((ed) => NoteEditorDataEntity.fromDatabase(ed)).toList());
  }

  Future<NoteEditorDataEntity?> getEditorDataById(String id) async {
    final editorData = await (_database.select(_database.noteeditordata)
          ..where((ed) => ed.id.equals(id) & ed.deletedAt.isNull()))
        .getSingleOrNull();
    
    return editorData != null ? NoteEditorDataEntity.fromDatabase(editorData) : null;
  }

  Future<NoteEditorDataEntity> createEditorData(NoteEditorDataEntity editorData) async {
    await _database.into(_database.noteeditordata).insert(editorData.toCompanion());
    
    final created = await getEditorDataById(editorData.id);
    return created!;
  }

  Future<NoteEditorDataEntity> updateEditorData(NoteEditorDataEntity editorData) async {
    await (_database.update(_database.noteeditordata)
          ..where((ed) => ed.id.equals(editorData.id)))
        .write(editorData.toCompanion(isUpdate: true));
    
    final updated = await getEditorDataById(editorData.id);
    return updated!;
  }

  Future<void> deleteEditorData(String id) async {
    // Soft delete
    await (_database.update(_database.noteeditordata)
          ..where((ed) => ed.id.equals(id)))
        .write(NoteeditordataCompanion(
          deletedAt: Value(DateTime.now().toUtc()),
          updatedAt: Value(DateTime.now().toUtc()),
        ));
  }

  Future<void> deleteEditorDataByNoteId(String noteId) async {
    // Soft delete all editor data for a note
    await (_database.update(_database.noteeditordata)
          ..where((ed) => ed.noteId.equals(noteId)))
        .write(NoteeditordataCompanion(
          deletedAt: Value(DateTime.now().toUtc()),
          updatedAt: Value(DateTime.now().toUtc()),
        ));
  }
}