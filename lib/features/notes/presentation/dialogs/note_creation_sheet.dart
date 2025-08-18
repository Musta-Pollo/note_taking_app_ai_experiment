import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';

import '../pages/categories/category_mixins.dart';
import 'note_dialogs_service.dart';

/// Dialog for selecting note type (simple or rich)
class NoteCreationSheet extends ConsumerWidget with CategoryEvent {
  const NoteCreationSheet({
    super.key,
    required this.categoryId,
  });

  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Create New Note',
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'What type of note?',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            // Simple Note Option
            Card(
              child: ListTile(
                leading: const Text('📝', style: TextStyle(fontSize: 24)),
                title: const Text('Simple Note'),
                subtitle: const Text(
                    'Perfect for lists, reminders\\nand quick thoughts'),
                onTap: () {
                  context.maybePop();
                  NoteDialogsService.showCreateSimpleNoteDialog(
                    context: context,
                    initialCategoryId: categoryId,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Rich Note Option
            Card(
              child: ListTile(
                leading: const Text('✏️', style: TextStyle(fontSize: 24)),
                title: const Text('Rich Note'),
                subtitle: const Text(
                    'Advanced formatting, blocks\\nand rich content'),
                onTap: () {
                  context.maybePop();
                  NoteDialogsService.showCreateRichNoteSheet(
                    context: context,
                    initialCategoryId: categoryId,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
