import 'dart:convert';
import 'dart:typed_data';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor_sync_plugin/appflowy_editor_sync_plugin.dart';
import 'package:appflowy_editor_sync_plugin/types/sync_db_attributes.dart';
import 'package:appflowy_editor_sync_plugin/types/update_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'note_editor_data_providers.dart';

part 'editor_state_wrapper_providers.g.dart';

/// Provider for EditorState with CRDT synchronization
@riverpod
class EditorStateWrapper extends _$EditorStateWrapper {
  static const _deviceId = Uuid();
  late String _currentDeviceId;

  @override
  FutureOr<EditorState> build(String noteId) async {
    _currentDeviceId = _deviceId.v4();

    final repository = ref.watch(noteEditorDataRepositoryProvider);

    final wrapper = EditorStateSyncWrapper(
      syncAttributes: SyncAttributes(
        /// Get initial CRDT updates for this note
        getInitialUpdates: () async {
          final updates = await repository.getEditorDataByNoteId(noteId).first;

          if (updates.isEmpty) {
            // Initialize the document
            // If there is some initial simple note content on the NoteEntity,
            final currentNote =
                await ref.read(notesRepositoryProvider).getNoteById(noteId);

            if (currentNote != null) {
              final initialData = await repository.initializeDocument(
                  noteId: noteId, initialText: currentNote.content);
              return [DbUpdate(update: initialData)];
            }
          }
          // Convert base64 strings back to Uint8List for the sync plugin
          return updates
              .map((update) => DbUpdate(update: base64Decode(update.dataB64)))
              .toList();
        },

        /// Stream of new updates from other devices/instances
        /// Stream of new updates from other devices/instances
        getUpdatesStream:
            repository.getEditorDataByNoteId(noteId).asyncMap((updates) async {
          // Filter for new updates since last known sequence
          final newUpdates = updates
              .where((update) =>
                  update.deviceId != _currentDeviceId) // Ignore our own updates
              .map((update) => DbUpdate(update: base64Decode(update.dataB64)))
              .toList();

          return newUpdates;
        }).where((updates) => updates.isNotEmpty), // Only emit non-empty lists

        /// Save CRDT update when document changes
        saveUpdate: (Uint8List update) async {
          final updateB64 = base64Encode(update);

          await repository.saveCrdtUpdate(
            noteId: noteId,
            crdtUpdateB64: updateB64,
            deviceId: _currentDeviceId,
          );
        },
      ),
    );

    return await wrapper.initAndHandleChanges();
  }

  /// Force refresh the editor state (useful for debugging)
  void refresh() {
    ref.invalidateSelf();
  }
}

/// Provider for checking if document has been initialized
@riverpod
Future<bool> isDocumentInitialized(Ref ref, String noteId) async {
  final repository = ref.watch(noteEditorDataRepositoryProvider);
  final updates = await repository.getEditorDataByNoteId(noteId).first;
  return updates.isNotEmpty;
}


