import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';
import '../note_mixins.dart';

/// Widget for selecting note category during editing
class NoteCategorySelector extends ConsumerWidget with NoteState {
  const NoteCategorySelector({
    super.key,
    required this.selectedCategoryId,
    required this.onCategoryChanged,
  });

  final String? selectedCategoryId;
  final ValueChanged<String?> onCategoryChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = categories(ref);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        categoriesAsync.when(
          data: (categories) => DropdownButtonFormField<String>(
            value: selectedCategoryId,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.folder),
            ),
            items: categories.map((category) {
              return DropdownMenuItem(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: onCategoryChanged,
          ),
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const Text('Error loading categories'),
        ),
      ],
    );
  }
}