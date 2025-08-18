import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_taking_app/features/notes/presentation/components/categories_dropdown.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';
import 'package:note_taking_app/shared/dialogs/shared_dialog_service.dart';

class CreateSimpleNoteSheet extends HookConsumerWidget {
  final String? initialCategoryId;

  const CreateSimpleNoteSheet({
    super.key,
    this.initialCategoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentController = useTextEditingController();
    final selectedCategoryId = useState<String?>(initialCategoryId);

    final canCreate = useState<bool>(false);

    void updateCanCreate() {
      canCreate.value = selectedCategoryId.value != null &&
          contentController.text.trim().isNotEmpty;
    }

    contentController.addListener(() {
      updateCanCreate();
    });

    useEffect(() {
      updateCanCreate();
      return null;
    }, [selectedCategoryId.value]);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
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
              'Create Simple Note',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Category selection
            CategoriesDropdown(
              initialCategoryId: selectedCategoryId.value,
              onCategorySelected: (category) {
                selectedCategoryId.value = category.id;
              },
            ),
            const SizedBox(height: 16),

            // Content input
            Expanded(
              child: TextField(
                controller: contentController,
                autofocus: true,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Start typing your note...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
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
                    onPressed: canCreate.value
                        ? () async {
                            ref
                                .read(notesNotifierProvider.notifier)
                                .createSimpleNote(
                                    content: contentController.text.trim(),
                                    categoryId: selectedCategoryId.value!);

                            final router = context.router;
                            await router.maybePop();
                            await router.maybePop();
                          }
                        : () {
                            SharedDialogService.showInfoMessage(
                                context, 'Please fill in all fields.');
                          },
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
