import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';

import 'note_editor_mixins.dart';

@RoutePage()
class NoteEditorPage extends ConsumerStatefulWidget {
  const NoteEditorPage({
    super.key,
    @pathParam required this.noteId,
  });

  final String noteId;

  @override
  ConsumerState<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends ConsumerState<NoteEditorPage>
    with NoteEditorState, NoteEditorEvent {
  NoteEntity? _note;

  @override
  void initState() {
    super.initState();
    _loadNoteInfo();
  }

  Future<void> _loadNoteInfo() async {
    try {
      final note = await getNoteById(ref, widget.noteId);
      if (note == null) {
        showErrorAndGoBack(context, 'Note not found');
        return;
      }

      if (mounted) {
        setState(() => _note = note);
      }
    } catch (e) {
      showErrorAndGoBack(context, 'Error loading note: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the editor state with CRDT sync
    final editorStateAsync = getEditorState(ref, widget.noteId);
    // Watch sync status
    final syncStatus = getSyncStatus(ref);

    return Scaffold(
      appBar: NoteEditorAppBar(
        note: _note,
        syncStatus: syncStatus,
        onExport: () => exportDocument(context, editorStateAsync.valueOrNull),
        onRefresh: () => refreshEditor(ref, widget.noteId),
      ),
      body: Column(
        children: [
          // AppFlowy Editor with CRDT sync
          Expanded(
            child: NoteEditorBody(
              editorStateAsync: editorStateAsync,
              onRetry: () => refreshEditor(ref, widget.noteId),
            ),
          ),
        ],
      ),
    );
  }
}
