import 'package:flutter/material.dart';
import 'package:note_taking_app/core/theme/theme_extensions.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/note_dialogs_service.dart';
import 'package:note_taking_app/shared/constants/k.dart';

class EmptyCategories extends StatelessWidget {
  const EmptyCategories({super.key});

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
                  color: context.colors.tertiary.withValues(alpha: K.opacity10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.folder_outlined,
                  size: K.iconSize48,
                  color: context.colors.tertiary,
                ),
              ),
              K.gap20,
              Text(
                K.noCategoriesYet,
                style: context.titleStyle,
              ),
              K.gap12,
              Text(
                'Create your first category to organize your notes.\nCategories help you keep things tidy!',
                style: context.subtitleStyle?.copyWith(height: 1.5),
                textAlign: TextAlign.center,
              ),
              K.gap24,
              OutlinedButton.icon(
                onPressed: () =>
                    NoteDialogsService.showAddCategoryDialog(context: context),
                icon: const Icon(Icons.add),
                label: const Text(K.createCategory),
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
