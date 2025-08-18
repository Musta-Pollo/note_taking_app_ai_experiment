import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import 'package:note_taking_app/features/notes/presentation/components/note_card_widget.dart';
import '../../home/home_mixins.dart';

/// Notes list view component that displays notes for a category
class NotesListView extends ConsumerWidget with HomeState, HomeEvent {
  const NotesListView({
    super.key,
    required this.notesAsync,
    required this.searchQuery,
  });

  final AsyncValue<List<NoteEntity>> notesAsync;
  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return notesAsync.when(
      data: (notesList) {
        if (notesList.isEmpty) {
          return _buildEmptyState(context);
        }
        return ListView.builder(
          itemCount: notesList.length,
          itemBuilder: (context, index) {
            final note = notesList[index];
            return NoteCardWidget(note: note);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(context, error),
    );
  }

  /// Build empty state widget
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            searchQuery.isNotEmpty ? Icons.search_off : Icons.note_add,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            searchQuery.isNotEmpty
                ? 'No notes found for "$searchQuery"'
                : 'No notes in this category',
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            searchQuery.isNotEmpty
                ? 'Try a different search term'
                : 'Tap the + button to add your first note',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build error state widget
  Widget _buildErrorState(BuildContext context, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error loading notes',
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}