import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_taking_app/features/notes/domain/entities/category_entity.dart';
import 'package:note_taking_app/features/notes/presentation/providers/categories_providers.dart';

class EditCategoryDialog extends HookConsumerWidget {
  const EditCategoryDialog({
    super.key,
    required this.initialCategory,
  });

  final CategoryEntity initialCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: initialCategory.name);
    return AlertDialog(
      title: const Text('Edit Category'),
      content: TextField(
        autofocus: true,
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Category Name',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.maybePop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (controller.text.isNotEmpty) {
              try {
                await ref
                    .read(categoriesNotifierProvider.notifier)
                    .updateCategory(
                        initialCategory.copyWith(name: controller.text.trim()));
                if (context.mounted) {
                  context.maybePop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Category updated successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  context.maybePop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error updating category: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
