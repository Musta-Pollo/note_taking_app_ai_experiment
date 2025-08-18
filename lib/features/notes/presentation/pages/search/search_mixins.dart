import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/core/theme/theme_extensions.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';
import 'package:note_taking_app/shared/constants/k.dart';

// Export components
export 'components/search_bar.dart';
export 'components/search_results.dart';
export 'components/search_suggestions.dart';

/// Search page state mixin - manages all state access for SearchPage
///
/// This mixin centralizes all data listening for the search page to enable
/// efficient coordination between related providers and reduce unnecessary rebuilds.
/// Components receive already-resolved AsyncValues instead of listening independently.
mixin class SearchState {
  /// Get search results for a query
  AsyncValue<List<NoteEntity>> searchResults(WidgetRef ref, String query) =>
      ref.watch(searchNotesProvider(query));

  /// Check if search query is valid
  bool isValidSearchQuery(String query) {
    return query.trim().isNotEmpty && query.trim().length >= 2;
  }

  /// Check if search is active
  bool isSearchActive(String query) {
    return query.trim().isNotEmpty;
  }

  /// Get search tips for display
  List<String> getSearchTips() {
    return [
      '• Search by note content or keywords',
      '• Use specific terms for better results',
      '• Try searching for categories or dates',
      '• Case-insensitive search is supported',
    ];
  }

  /// Format search results count
  String formatResultsCount(int count) {
    return 'Found $count result${count == 1 ? '' : 's'}';
  }

  /// Get no results message
  String getNoResultsMessage(String query) {
    return 'No notes match "$query"';
  }
}

/// Search page events mixin - manages all events/actions for SearchPage
///
/// This mixin handles all user interactions and navigation events for the search page.
/// It provides clean separation between state management and event handling.
mixin SearchEvent {
  /// Navigate back to previous page
  void navigateBack(BuildContext context) {
    context.router.maybePop();
  }

  /// Navigate to note page
  void navigateToNote(BuildContext context, NoteEntity note) {
    context.pushRoute(NoteRoute(note: note));
  }

  /// Navigate to category page
  void navigateToCategory(BuildContext context, String categoryId) {
    context.pushRoute(CategoryRoute(categoryId: categoryId));
  }

  /// Clear search and reset state
  void clearSearch(TextEditingController controller, VoidCallback onUpdate) {
    controller.clear();
    onUpdate();
  }

  /// Perform search with validation
  void performSearch(String query, VoidCallback onUpdate) {
    onUpdate();
  }

  /// Show search tips dialog
  void showSearchTipsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Tips'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Here are some tips to help you find notes faster:'),
            const SizedBox(height: 16),
            ...SearchState().getSearchTips().map((tip) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(tip),
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.maybePop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  /// Build search tip widget
  Widget buildSearchTip(String tip, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: K.spacing4),
      child: Text(
        tip,
        style: context.captionStyle,
      ),
    );
  }
}
