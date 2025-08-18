import 'dart:typed_data';

import '../entities/note_editor_data_entity.dart';

abstract class NoteEditorDataRepository {
  /// Get all CRDT updates for a specific note, ordered by sequence
  Stream<List<NoteEditorDataEntity>> getEditorDataByNoteId(String noteId);

  /// Save a new CRDT update for synchronization
  Future<NoteEditorDataEntity> saveCrdtUpdate({
    required String noteId,
    required String crdtUpdateB64,
    String? deviceId,
  });

  /// Initialize a document with initial text
  Future<Uint8List> initializeDocument({
    required String noteId,
    required String initialText,
    String? deviceId,
  });
}
