import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/note_dialogs_service.dart';
import 'package:note_taking_app/features/notes/presentation/providers/categories_providers.dart';
import 'package:note_taking_app/features/notes/presentation/providers/note_dialogs_provider.dart';

class CategoriesBottomSheet extends ConsumerWidget {
  const CategoriesBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Logic to add a new category
                    NoteDialogsService.showAddCategoryDialog(
                      context: context,
                    );
                  },
                  icon: const Icon(Icons.add),
                  tooltip: 'Add Category',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                return ref.watch(categoriesNotifierProvider).when(
                      data: (categories) {
                        if (categories.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.folder_outlined,
                                    size: 64, color: Colors.grey),
                                SizedBox(height: 16),
                                Text(
                                  'No categories yet',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Tap the + button to add your first category',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return ListTile(
                              leading: const Icon(Icons.folder),
                              title: Text(category.name),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, size: 16),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete,
                                            size: 16, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Delete',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    NoteDialogsService.showEditCategoryDialog(
                                      context: context,
                                      category: category,
                                    );
                                  } else if (value == 'delete') {
                                    ref
                                        .read(
                                            noteDialogsServiceProviderProvider)
                                        .showDeleteCategoryDialog(
                                            context: context,
                                            category: category);
                                  }
                                },
                              ),
                              onTap: () => context.router.replaceAll(
                                [
                                  HomeRoute(),
                                  CategoryRoute(categoryId: category.id)
                                ],
                              ),
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(
                        child: Text('Error loading categories: $error'),
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
