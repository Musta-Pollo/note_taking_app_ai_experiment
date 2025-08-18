import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/core/auth/auth_providers.dart';
import 'package:note_taking_app/core/database/tables/notes_table.dart';
import 'package:note_taking_app/core/providers/core_providers.dart';
import 'package:note_taking_app/core/sync/models/sync_status.dart';
import 'package:note_taking_app/core/sync/sync_service.dart';
import 'package:note_taking_app/features/notes/domain/entities/category_entity.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import 'package:note_taking_app/features/notes/presentation/providers/categories_providers.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';

/// Home page state mixin - manages all state access for HomePage
///
/// This mixin centralizes all data listening for the home page to enable
/// efficient coordination between related providers and reduce unnecessary rebuilds.
/// Components receive already-resolved AsyncValues instead of listening independently.
mixin class HomeState {
  /// Get all categories
  AsyncValue<List<CategoryEntity>> categories(WidgetRef ref) =>
      ref.watch(categoriesNotifierProvider);

  /// Get recent notes sorted by date
  AsyncValue<List<NoteEntity>> recentNotes(WidgetRef ref) =>
      ref.watch(sortedNotesProvider(sortType: SortType.dateDesc));

  /// Get search results for a query
  AsyncValue<List<NoteEntity>>? searchResults(WidgetRef ref, String query) =>
      query.isNotEmpty ? ref.watch(searchNotesProvider(query)) : null;

  /// Get notes for a specific category
  AsyncValue<List<NoteEntity>> notesByCategory(
          WidgetRef ref, String categoryId) =>
      ref.watch(sortedNotesProvider(categoryId: categoryId));

  /// Get sync status
  SyncStatus syncStatus(WidgetRef ref) => ref.watch(syncServiceProvider);

  /// Get current user ID
  String? currentUserId(WidgetRef ref) => ref.watch(currentUserIdProvider);

  /// Check if user is offline
  bool isOffline(WidgetRef ref) => currentUserId(ref) == null;
}

/// Home page events mixin - manages all events/actions for HomePage
///
/// This mixin handles all user interactions and navigation events for the home page.
/// It provides clean separation between state management and event handling.
mixin class HomeEvent {
  /// Navigate to search page
  void onSearchTap(BuildContext context) {
    context.router.popUntilRoot();
    context.pushRoute(const SearchRoute());
  }

  /// Navigate to settings page
  void navigateToSettings(BuildContext context) {
    context.router.popUntilRoot();
    context.pushRoute(const SettingsRoute());
  }

  /// Navigate to login page
  void navigateToLogin(BuildContext context) {
    context.router.popUntilRoot();
    context.pushRoute(const LoginRoute());
  }

  /// Navigate to category page
  void navigateToCategory(BuildContext context, String categoryId) {
    context.pushRoute(CategoryRoute(categoryId: categoryId));
  }

  /// Navigate to note page
  void navigateToNote(BuildContext context, NoteEntity note) {
    context.pushRoute(NoteRoute(note: note));
  }

  /// Sign out current user
  void signOut(WidgetRef ref) {
    final authService = ref.read(authServiceProvider.notifier);
    authService.signOut();
  }

  /// Force sync
  Future<void> forceSync(WidgetRef ref) async {
    await ref.read(syncServiceProvider.notifier).forceSync();
  }

  /// Create a new category
  Future<CategoryEntity> createCategory(WidgetRef ref, String name) async {
    return await ref
        .read(categoriesNotifierProvider.notifier)
        .createCategory(name);
  }

  /// Update an existing category
  Future<CategoryEntity> updateCategory(
      WidgetRef ref, CategoryEntity category) async {
    return await ref
        .read(categoriesNotifierProvider.notifier)
        .updateCategory(category);
  }

  /// Delete a category
  Future<void> deleteCategory(WidgetRef ref, String categoryId) async {
    await ref
        .read(categoriesNotifierProvider.notifier)
        .deleteCategory(categoryId);
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

  /// Get note by ID
  Future<NoteEntity?> getNoteById(WidgetRef ref, String noteId) async {
    return await ref.read(notesNotifierProvider.notifier).getNoteById(noteId);
  }
}
