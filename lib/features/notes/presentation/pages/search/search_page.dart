import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../dialogs/note_dialogs_service.dart';
import 'search_mixins.dart';

@RoutePage()
class SearchPage extends HookConsumerWidget with SearchState, SearchEvent {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Notes'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => NoteDialogsService.showSearchTipsDialog(context),
            tooltip: 'Search Tips',
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBar(
            controller: searchController,
            onChanged: (query) {
              performSearch(query, () => searchQuery.value = query.trim());
            },
            onClear: () {
              clearSearch(searchController, () => searchQuery.value = '');
            },
          ),
          Expanded(
            child: _buildSearchContent(searchQuery.value, searchController),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchContent(String query, TextEditingController controller) {
    if (!isSearchActive(query)) {
      return SearchSuggestions(
        tips: getSearchTips(),
        buildSearchTip: buildSearchTip,
      );
    }

    return SearchResults(
      searchQuery: query,
      onClearSearch: () {
        clearSearch(controller, () => controller.clear());
      },
      formatResultsCount: formatResultsCount,
      getNoResultsMessage: getNoResultsMessage,
    );
  }
}
