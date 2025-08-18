import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/features/notes/domain/entities/category_entity.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import 'package:note_taking_app/features/notes/presentation/providers/categories_providers.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';
import 'package:note_taking_app/shared/dialogs/shared_dialog_service.dart';
import 'package:timeago/timeago.dart' as timeago;

export 'components/note_category_selector.dart';
export 'components/note_content_editor.dart';
export 'components/note_metadata_card.dart';
// Export components
export 'components/note_type_indicator.dart';

/// Note page state mixin - manages all state access for NotePage
///
/// This mixin centralizes all data listening for the note page to enable
/// efficient coordination between related providers and reduce unnecessary rebuilds.
/// Components receive already-resolved AsyncValues instead of listening independently.
mixin class NoteState {
  /// Get all categories
  AsyncValue<List<CategoryEntity>> categories(WidgetRef ref) =>
      ref.watch(categoriesNotifierProvider);

  /// Get category by ID
  CategoryEntity? getCategoryById(WidgetRef ref, String categoryId) {
    return categories(ref).maybeWhen(
      data: (categories) => categories.firstWhere(
        (cat) => cat.id == categoryId,
        orElse: () => throw Exception('Category not found'),
      ),
      orElse: () => null,
    );
  }

  /// Get category name by ID
  String getCategoryName(WidgetRef ref, String categoryId) {
    return categories(ref).maybeWhen(
      data: (categories) {
        final category = categories.firstWhere(
          (cat) => cat.id == categoryId,
          orElse: () => throw Exception('Category not found'),
        );
        return category.name;
      },
      orElse: () => 'Loading...',
    );
  }

  /// Check if content has changed
  bool hasContentChanged(String currentContent, String originalContent) {
    return currentContent != originalContent;
  }

  /// Check if category has changed
  bool hasCategoryChanged(String? currentCategory, String originalCategory) {
    return currentCategory != originalCategory;
  }

  /// Check if any changes exist
  bool hasChanges(
    String currentContent,
    String originalContent,
    String? currentCategory,
    String originalCategory,
  ) {
    return hasContentChanged(currentContent, originalContent) ||
        hasCategoryChanged(currentCategory, originalCategory);
  }

  /// Format date time using timeago
  String formatDateTime(DateTime dateTime) {
    return timeago.format(dateTime);
  }
}

/// Note page events mixin - manages all events/actions for NotePage
///
/// This mixin handles all user interactions and navigation events for the note page.
/// It provides clean separation between state management and event handling.
mixin NoteEvent {
  /// Navigate back to previous page
  void navigateBack(BuildContext context) {
    context.router.maybePop();
  }

  /// Navigate to note editor for rich text editing
  void navigateToNoteEditor(BuildContext context, String noteId) {
    context.router.push(NoteEditorRoute(noteId: noteId));
  }

  /// Replace current page with note editor
  void replaceWithNoteEditor(BuildContext context, String noteId) {
    context.router.replace(NoteEditorRoute(noteId: noteId));
  }

  /// Update a note
  Future<NoteEntity> updateNote(WidgetRef ref, NoteEntity note) async {
    return await ref.read(notesNotifierProvider.notifier).updateNote(note);
  }

  /// Delete a note
  Future<void> deleteNote(WidgetRef ref, String noteId) async {
    await ref.read(notesNotifierProvider.notifier).deleteNote(noteId);
  }

  /// Create a full note (for conversion)
  Future<NoteEntity> createFullNote(
    WidgetRef ref, {
    required String categoryId,
    String content = '',
  }) async {
    return await ref.read(notesNotifierProvider.notifier).createFullNote(
          categoryId: categoryId,
          content: content,
        );
  }

  /// Convert simple note to rich note
  Future<void> convertToRichNote(
    BuildContext context,
    WidgetRef ref,
    NoteEntity note,
  ) async {
    try {
      // Create a rich note with the current content
      final richNote = await createFullNote(
        ref,
        categoryId: note.categoryId,
        content: note.content,
      );

      // Delete the current simple note
      await deleteNote(ref, note.id);

      if (context.mounted) {
        // Navigate to the rich text editor
        replaceWithNoteEditor(context, richNote.id);
      }
    } catch (e) {
      if (context.mounted) {
        SharedDialogService.showErrorMessage(
            context, 'Failed to convert note: $e');
      }
    }
  }

  /// Show delete confirmation dialog
  Future<bool> showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Note'),
            content: const Text(
                'Are you sure you want to delete this note? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => context.maybePop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => context.maybePop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// Delete note with confirmation
  Future<void> deleteNoteWithConfirmation(
    BuildContext context,
    WidgetRef ref,
    NoteEntity note,
  ) async {
    final confirmed = await showDeleteConfirmation(context);
    if (!confirmed) return;

    try {
      await deleteNote(ref, note.id);

      if (context.mounted) {
        navigateBack(context);
        SharedDialogService.showSuccessMessage(
            context, 'Note deleted successfully');
      }
    } catch (e) {
      if (context.mounted) {
        SharedDialogService.showErrorMessage(
            context, 'Failed to delete note: $e');
      }
    }
  }

  /// Save note changes
  Future<NoteEntity?> saveNote(
    BuildContext context,
    WidgetRef ref,
    NoteEntity originalNote,
    String newContent,
    String? newCategoryId,
  ) async {
    try {
      final updatedNote = originalNote.copyWith(
        content: newContent,
        categoryId: newCategoryId ?? originalNote.categoryId,
      );

      final savedNote = await updateNote(ref, updatedNote);

      if (context.mounted) {
        SharedDialogService.showSuccessMessage(
          context,
          'Note saved successfully',
        );
      }

      return savedNote;
    } catch (e) {
      if (context.mounted) {
        SharedDialogService.showErrorMessage(
          context,
          'Failed to save note: $e',
        );
      }
      return null;
    }
  }
}
