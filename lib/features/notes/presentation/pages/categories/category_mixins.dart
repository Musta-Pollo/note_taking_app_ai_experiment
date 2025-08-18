import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/core/database/tables/notes_table.dart';
import 'package:note_taking_app/features/notes/domain/entities/category_entity.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import 'package:note_taking_app/features/notes/presentation/providers/categories_providers.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';

// Export components
export '../../dialogs/note_creation_sheet.dart';
// Import components

/// Category page state mixin - manages all state access for CategoryPage
///
/// This mixin centralizes all data listening for the category page to enable
/// efficient coordination between related providers and reduce unnecessary rebuilds.
/// Components receive already-resolved AsyncValues instead of listening independently.
mixin class CategoryState {
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
      orElse: () => 'Category',
    );
  }

  /// Get notes by category with sorting
  AsyncValue<List<NoteEntity>> notesByCategory(
    WidgetRef ref,
    String categoryId, {
    SortType sortType = SortType.dateDesc,
  }) =>
      ref.watch(
          sortedNotesProvider(categoryId: categoryId, sortType: sortType));

  /// Get search results for notes
  AsyncValue<List<NoteEntity>> searchResults(WidgetRef ref, String query) =>
      ref.watch(searchNotesProvider(query));

  /// Get filtered notes based on search query or category
  AsyncValue<List<NoteEntity>> getFilteredNotes(
    WidgetRef ref,
    String categoryId,
    String searchQuery, {
    SortType sortType = SortType.dateDesc,
  }) {
    if (searchQuery.isNotEmpty) {
      return searchResults(ref, searchQuery);
    }
    return notesByCategory(ref, categoryId, sortType: sortType);
  }
}

/// Category page events mixin - manages all events/actions for CategoryPage
///
/// This mixin handles all user interactions and navigation events for the category page.
/// It provides clean separation between state management and event handling.
mixin CategoryEvent {
  /// Navigate back to previous page
  void navigateBack(BuildContext context) {
    context.router.maybePop();
  }

  /// Navigate to note page
  void navigateToNote(BuildContext context, NoteEntity note) {
    context.pushRoute(NoteRoute(note: note));
  }

  /// Navigate to note editor for rich text editing
  void navigateToNoteEditor(BuildContext context, String noteId) {
    context.router.push(NoteEditorRoute(noteId: noteId));
  }

  /// Create a simple note
  Future<NoteEntity> createSimpleNote(
    WidgetRef ref, {
    required String content,
    required String categoryId,
  }) async {
    return await ref.read(notesNotifierProvider.notifier).createSimpleNote(
          content: content,
          categoryId: categoryId,
        );
  }

  /// Create a full note
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

  /// Update a note
  Future<NoteEntity> updateNote(WidgetRef ref, NoteEntity note) async {
    return await ref.read(notesNotifierProvider.notifier).updateNote(note);
  }

  /// Delete a note
  Future<void> deleteNote(WidgetRef ref, String noteId) async {
    await ref.read(notesNotifierProvider.notifier).deleteNote(noteId);
  }
}
