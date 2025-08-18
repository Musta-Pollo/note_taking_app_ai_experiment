import 'package:flutter/material.dart';
import 'package:note_taking_app/core/theme/theme_extensions.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/note_dialogs_service.dart';
import 'package:note_taking_app/shared/constants/k.dart';

class EmptyNotes extends StatelessWidget {
  const EmptyNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: K.spacing8),
      child: Card(
        elevation: K.elevation2,
        shape: RoundedRectangleBorder(borderRadius: K.borderRadius16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(K.spacing32),
          decoration: AppContainerStyles.gradientBackground(context.colors),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(K.spacing16),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: K.opacity10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.note_add,
                  size: K.iconSize48,
                  color: context.colors.primary,
                ),
              ),
              K.gap20,
              Text(
                K.noNotesYet,
                style: context.titleStyle,
              ),
              K.gap12,
              Text(
                'Start capturing your thoughts and ideas.\nTap the + button to create your first note.',
                style: context.subtitleStyle?.copyWith(height: 1.5),
                textAlign: TextAlign.center,
              ),
              K.gap24,
              OutlinedButton.icon(
                onPressed: () =>
                    NoteDialogsService.showNoteCreationSheet(context, null),
                icon: const Icon(Icons.add),
                label: const Text(K.createNote),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: K.spacing24,
                    vertical: K.spacing12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: K.borderRadius12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
