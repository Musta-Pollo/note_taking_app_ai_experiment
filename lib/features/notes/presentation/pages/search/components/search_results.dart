import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/note_card_widget.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';
import 'package:note_taking_app/shared/components/loading_state.dart';
import 'package:note_taking_app/shared/components/error_state.dart';
import 'package:note_taking_app/shared/components/empty_state.dart';
import 'package:note_taking_app/shared/constants/k.dart';
import '../../../../../../core/theme/theme_extensions.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({
    super.key,
    required this.searchQuery,
    required this.onClearSearch,
    required this.formatResultsCount,
    required this.getNoResultsMessage,
  });

  final String searchQuery;
  final VoidCallback onClearSearch;
  final String Function(int) formatResultsCount;
  final String Function(String) getNoResultsMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch search results internally for better efficiency
    final searchResultsAsync = ref.watch(searchNotesProvider(searchQuery));
    
    return searchResultsAsync.when(
      data: (notes) {
        if (notes.isEmpty) {
          return EmptyState(
            title: K.noResultsFound,
            message: getNoResultsMessage(searchQuery),
            icon: Icons.search_off,
            actionLabel: 'Clear Search',
            onAction: onClearSearch,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResultsCount(context, notes.length),
            _buildResultsList(notes),
          ],
        );
      },
      loading: () => const LoadingState(message: 'Searching your notes...'),
      error: (error, stack) => ErrorState(
        title: 'Search Error',
        error: error,
      ),
    );
  }

  Widget _buildResultsCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        K.spacing24, 
        K.spacing12, 
        K.spacing24, 
        0
      ),
      child: Text(
        formatResultsCount(count),
        style: context.captionStyle,
      ),
    );
  }

  Widget _buildResultsList(List<NoteEntity> notes) {
    return Expanded(
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteCardWidget(note: note, showCategory: true);
        },
      ),
    );
  }
}