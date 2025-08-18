import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_taking_app/core/database/tables/notes_table.dart';

import 'category_mixins.dart';
import 'components/category_fab.dart';
import 'components/category_header.dart';
import 'components/category_search_bar.dart';
import 'components/notes_list_view.dart';

@RoutePage()
class CategoryPage extends HookConsumerWidget
    with CategoryState, CategoryEvent {
  const CategoryPage({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortType = useState<SortType>(SortType.dateDesc);
    final searchQuery = useState<String>('');

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CategoryHeader(
          categoryId: categoryId,
          sortType: sortType.value,
          onSortChanged: (newSortType) {
            sortType.value = newSortType;
          },
        ),
      ),
      body: Column(
        children: [
          // Search bar
          CategorySearchBar(
            searchQuery: searchQuery.value,
            onSearchChanged: (value) {
              searchQuery.value = value;
            },
          ),
          // Notes list
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              return NotesListView(
                notesAsync: getFilteredNotes(ref, categoryId, searchQuery.value,
                    sortType: sortType.value),
                searchQuery: searchQuery.value,
              );
            }),
          ),
        ],
      ),
      floatingActionButton: CategoryFab(categoryId: categoryId),
    );
  }
}
