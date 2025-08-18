import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/database/tables/notes_table.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';

import '../../../../../shared/components/app_popup_menu.dart';
import '../../../../../shared/enums/menu_actions.dart';
import 'note_mixins.dart';
import 'components/note_type_indicator.dart';
import 'components/note_category_selector.dart';
import 'components/note_content_editor.dart';
import 'components/note_metadata_card.dart';

@RoutePage()
class NotePage extends ConsumerStatefulWidget {
  const NotePage({super.key, required this.note});

  final NoteEntity note;

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage>
    with NoteState, NoteEvent {
  late TextEditingController _contentController;
  late NoteEntity _currentNote;
  bool _isEditing = false;
  bool _hasChanges = false;
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _currentNote = widget.note;
    _contentController = TextEditingController(text: _currentNote.content);
    _selectedCategoryId = _currentNote.categoryId;

    _contentController.addListener(_onContentChanged);
  }

  @override
  void dispose() {
    _contentController.removeListener(_onContentChanged);
    _contentController.dispose();
    super.dispose();
  }

  void _onContentChanged() {
    setState(() {
      _hasChanges = hasChanges(
        _contentController.text,
        _currentNote.content,
        _selectedCategoryId,
        _currentNote.categoryId,
      );
    });
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _cancelEditing() {
    setState(() {
      _contentController.text = _currentNote.content;
      _selectedCategoryId = _currentNote.categoryId;
      _isEditing = false;
      _hasChanges = false;
    });
  }

  Future<void> _saveNote() async {
    if (!_hasChanges) {
      setState(() {
        _isEditing = false;
      });
      return;
    }

    final savedNote = await saveNote(
      context,
      ref,
      _currentNote,
      _contentController.text,
      _selectedCategoryId,
    );

    if (savedNote != null) {
      setState(() {
        _currentNote = savedNote;
        _isEditing = false;
        _hasChanges = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
        actions: [
          if (_isEditing) ...[
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _cancelEditing,
              tooltip: 'Cancel',
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _hasChanges ? _saveNote : _cancelEditing,
              tooltip: 'Save',
            ),
          ] else ...[
            if (_currentNote.noteType == NoteType.full) ...[
              IconButton(
                icon: const Icon(Icons.edit_note),
                onPressed: () => navigateToNoteEditor(context, _currentNote.id),
                tooltip: 'Edit in Rich Editor',
              ),
            ] else ...[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _startEditing,
                tooltip: 'Edit',
              ),
            ],
            NotePagePopupMenu(
              actions: [
                if (_currentNote.noteType == NoteType.simple)
                  NotePageAction.convert,
                NotePageAction.delete,
              ],
              onSelected: (action) async {
                switch (action) {
                  case NotePageAction.convert:
                    await convertToRichNote(context, ref, _currentNote);
                    break;
                  case NotePageAction.delete:
                    await deleteNoteWithConfirmation(context, ref, _currentNote);
                    break;
                }
              },
            ),
          ],
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Note type indicator
            NoteTypeIndicator(noteType: _currentNote.noteType),
            const SizedBox(height: 16),

            // Category selector (only when editing and for simple notes)
            if (_isEditing && _currentNote.noteType == NoteType.simple) ...[
              NoteCategorySelector(
                selectedCategoryId: _selectedCategoryId,
                onCategoryChanged: (value) {
                  setState(() {
                    _selectedCategoryId = value;
                  });
                  _onContentChanged();
                },
              ),
              const SizedBox(height: 16),
            ],

            // Content area
            Expanded(
              child: NoteContentEditor(
                note: _currentNote,
                controller: _contentController,
                isEditing: _isEditing,
              ),
            ),

            // Metadata
            const SizedBox(height: 16),
            NoteMetadataCard(note: _currentNote),
          ],
        ),
      ),
    );
  }
}
