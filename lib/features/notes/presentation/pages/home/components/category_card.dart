import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/theme/theme_extensions.dart';
import 'package:note_taking_app/features/notes/domain/entities/category_entity.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';
import 'package:note_taking_app/shared/constants/k.dart';

class CategoryCard extends ConsumerWidget {
  final CategoryEntity category;
  final VoidCallback onTap;

  const CategoryCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesInCategory =
        ref.watch(sortedNotesProvider(categoryId: category.id));

    return Container(
      margin: const EdgeInsets.only(bottom: K.spacing12),
      child: Card(
        child: ListTile(
          leading: const Text('📁', style: TextStyle(fontSize: 20)),
          title: Text(category.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              notesInCategory.when(
                data: (notes) => Text(
                  '(${notes.length})',
                  style: context.bodyStyle?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                loading: () => const Text('(...)'),
                error: (_, __) => const Text('(0)'),
              ),
              K.gap8,
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
