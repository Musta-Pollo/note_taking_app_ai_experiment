import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_taking_app/features/notes/domain/entities/category_entity.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/note_dialogs_service.dart';
import 'package:note_taking_app/features/notes/presentation/providers/categories_providers.dart';

class CategoriesDropdown extends HookConsumerWidget {
  const CategoriesDropdown(
      {super.key,
      required this.initialCategoryId,
      required this.onCategorySelected});

  final String? initialCategoryId;
  final Function(CategoryEntity) onCategorySelected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryId = useState<String?>(initialCategoryId);

    return Consumer(builder: (context, ref, _) {
      return ref.watch(categoriesNotifierProvider).when(
            data: (categories) {
              if (categories.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No categories available'),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            NoteDialogsService.showAddCategoryDialog(
                              context: context,
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Category'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  DropdownButtonFormField<CategoryEntity>(
                    initialValue: categories.firstWhere(
                      (category) => category.id == selectedCategoryId.value,
                      orElse: () {
                        Future.delayed(Duration.zero).then((_) {
                          selectedCategoryId.value = categories.first.id;
                          onCategorySelected(categories.first);
                        });

                        return categories.first;
                      },
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.folder),
                    ),
                    items: [
                      ...categories.map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name),
                          )),
                      DropdownMenuItem<CategoryEntity>(
                        value: null,
                        child: Row(
                          children: [
                            Icon(Icons.add,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(width: 8),
                            Text(
                              'Add Category',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (category) {
                      if (category == null) {
                        NoteDialogsService.showAddCategoryDialog(
                          context: context,
                        );
                      } else {
                        selectedCategoryId.value = category.id;
                        onCategorySelected(category);
                      }
                    },
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          );
    });
  }
}
