import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dialogs/note_dialogs_service.dart';

/// Floating action button for creating new notes in a category
class CategoryFab extends ConsumerWidget {
  const CategoryFab({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () => NoteDialogsService.showNoteCreationSheet(
        context,
        categoryId,
      ),
      child: const Icon(Icons.add),
    );
  }
}
