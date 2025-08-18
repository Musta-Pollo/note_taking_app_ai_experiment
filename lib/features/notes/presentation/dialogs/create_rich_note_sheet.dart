import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/features/notes/presentation/components/categories_dropdown.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';

class CreateRichNoteSheet extends HookConsumerWidget {
  final String? initialCategoryId;

  const CreateRichNoteSheet({
    super.key,
    required this.initialCategoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = useState<String?>(initialCategoryId);
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Create Rich Note',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose a category to create your rich note',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Category selection
            Expanded(
                child: CategoriesDropdown(
                    initialCategoryId: initialCategoryId,
                    onCategorySelected: (category) {
                      selectedCategory.value = category.id;
                    })),
            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.maybePop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedCategory.value != null
                        ? () async {
                            final newNote = await ref
                                .read(notesNotifierProvider.notifier)
                                .createFullNote(
                                  categoryId: selectedCategory.value!,
                                );
                            //Get router and then call maybePop two times
                            final router = context.router;
                            await router.maybePop();
                            router.maybePop();
                            router.push(NoteEditorRoute(noteId: newNote.id));
                          }
                        : null,
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
