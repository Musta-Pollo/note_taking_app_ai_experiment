import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import '../note_mixins.dart';

/// Widget that displays note metadata (category, creation date, last updated)
class NoteMetadataCard extends ConsumerWidget with NoteState {
  const NoteMetadataCard({
    super.key,
    required this.note,
  });

  final NoteEntity note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryName = getCategoryName(ref, note.categoryId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Note Information',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildMetadataRow(
              'Category',
              categoryName,
              Icons.folder,
              context,
            ),
            const SizedBox(height: 8),
            _buildMetadataRow(
              'Created',
              formatDateTime(note.createdAt),
              Icons.add_circle_outline,
              context,
            ),
            const SizedBox(height: 8),
            _buildMetadataRow(
              'Last Updated',
              formatDateTime(note.updatedAt),
              Icons.update,
              context,
            ),
          ],
        ),
      ),
    );
  }

  /// Build a metadata row with icon, label and value
  Widget _buildMetadataRow(
    String label,
    String value,
    IconData icon,
    BuildContext context,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: context.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}