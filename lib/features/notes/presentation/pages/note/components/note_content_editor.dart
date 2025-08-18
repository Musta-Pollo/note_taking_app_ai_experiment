import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/database/tables/notes_table.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';

import '../note_mixins.dart';

/// Widget for editing note content or displaying rich note placeholder
class NoteContentEditor extends ConsumerWidget with NoteEvent {
  const NoteContentEditor({
    super.key,
    required this.note,
    required this.controller,
    required this.isEditing,
  });

  final NoteEntity note;
  final TextEditingController controller;
  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Content',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: note.noteType == NoteType.full
              ? _buildRichNotePlaceholder(context)
              : _buildSimpleNoteEditor(context),
        ),
      ],
    );
  }

  /// Build rich note placeholder with open editor button
  Widget _buildRichNotePlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.5),
        ),
        color: context.colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_note,
            size: 64,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 16),
          Text(
            'Rich Text Note',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'This note contains rich text content that can only be viewed and edited in the rich text editor.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => navigateToNoteEditor(context, note.id),
            icon: const Icon(Icons.edit_note),
            label: const Text('Open Rich Text Editor'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: context.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  /// Build simple note text editor
  Widget _buildSimpleNoteEditor(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: isEditing,
      maxLines: null,
      expands: true,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: isEditing ? 'Enter your note content...' : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: !isEditing,
        fillColor: isEditing ? null : context.colorScheme.surface,
      ),
      style: context.textTheme.bodyLarge,
    );
  }
}
