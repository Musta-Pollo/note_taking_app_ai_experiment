import 'package:flutter/material.dart';
import 'package:note_taking_app/core/database/tables/notes_table.dart';

/// Widget that displays the note type (Simple or Rich) with appropriate styling
class NoteTypeIndicator extends StatelessWidget {
  const NoteTypeIndicator({
    super.key,
    required this.noteType,
  });

  final NoteType noteType;

  @override
  Widget build(BuildContext context) {
    final isRichNote = noteType == NoteType.full;
    final color = isRichNote ? Colors.orange : Colors.blue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isRichNote ? Icons.edit_note : Icons.note,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            isRichNote ? 'Rich Text Note' : 'Simple Note',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}