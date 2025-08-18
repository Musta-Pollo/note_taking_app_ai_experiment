import 'dart:convert';
import 'dart:typed_data';

import 'package:appflowy_editor_sync_plugin/appflowy_editor_sync_plugin.dart';

import '../../domain/entities/note_editor_data_entity.dart';
import '../../domain/repositories/note_editor_data_repository.dart';
import '../datasources/note_editor_data_local_datasource.dart';

class NoteEditorDataRepositoryImpl implements NoteEditorDataRepository {
  final NoteEditorDataLocalDataSource _localDataSource;
  final String _userId;

  NoteEditorDataRepositoryImpl(this._localDataSource, this._userId);

  @override
  Stream<List<NoteEditorDataEntity>> getEditorDataByNoteId(String noteId) {
    return _localDataSource.getEditorDataByNoteId(noteId);
  }

  @override
  Future<NoteEditorDataEntity> saveCrdtUpdate({
    required String noteId,
    required String crdtUpdateB64,
    String? deviceId,
  }) {
    final editorData = NoteEditorDataEntity.create(
      noteId: noteId,
      crdtUpdateB64: crdtUpdateB64,
      userId: _userId,
    );

    return _localDataSource.createEditorData(editorData);
  }

  @override
  Future<Uint8List> initializeDocument(
      {required String noteId,
      required String initialText,
      String? deviceId}) async {
    final initialUpdate = await AppflowyEditorSyncUtilityFunctions
        .initDocumentFromExistingMarkdownDocument(initialText);

    final crdtUpdateB64 = base64Encode(initialUpdate);

    await _localDataSource.createEditorData(NoteEditorDataEntity.create(
      noteId: noteId,
      crdtUpdateB64: crdtUpdateB64,
      userId: _userId,
    ));

    return initialUpdate;
  }
}
