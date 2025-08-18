import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/shared/dialogs/shared_dialog_service.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../app/router/app_router.dart';
import '../../../../core/database/tables/notes_table.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../shared/components/app_popup_menu.dart';
import '../../../../shared/constants/k.dart';
import '../../../../shared/enums/menu_actions.dart';
import '../../domain/entities/note_entity.dart';
import '../providers/categories_providers.dart';

class NoteCardWidget extends ConsumerWidget {
  const NoteCardWidget({
    super.key,
    required this.note,
    this.showCategory = false,
    this.onTap,
    this.onDelete,
  });

  final NoteEntity note;
  final bool showCategory;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesNotifierProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: K.spacing16),
      child: Card(
        child: ListTile(
          leading: Text(
            note.noteType == NoteType.full
                ? K.fullNoteEmoji
                : K.simpleNoteEmoji,
            style: const TextStyle(fontSize: 20),
          ),
          title: Text(
            note.content.isNotEmpty
                ? (note.content.length > K.noteContentPreviewLength
                    ? '${note.content.substring(0, K.noteContentPreviewLength)}...'
                    : note.content)
                : K.untitledNote,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showCategory) ...[
                categoriesAsync.when(
                  data: (categories) {
                    final category = categories
                        .where((cat) => cat.id == note.categoryId)
                        .firstOrNull;
                    return Text(
                      category != null
                          ? '${category.name} • ${timeago.format(note.createdAt)}'
                          : timeago.format(note.createdAt),
                      style: context.captionStyle,
                    );
                  },
                  loading: () => Text(
                    timeago.format(note.createdAt),
                    style: context.captionStyle,
                  ),
                  error: (_, __) => Text(
                    timeago.format(note.createdAt),
                    style: context.captionStyle,
                  ),
                ),
              ] else ...[
                Text(
                  timeago.format(note.createdAt),
                  style: context.captionStyle,
                ),
              ],
            ],
          ),
          onTap: onTap ?? () => context.router.push(NoteRoute(note: note)),
          trailing: NoteCardMenu(
            note: note,
            onEdit: onTap ?? () => context.router.push(NoteRoute(note: note)),
            onDelete: onDelete,
          ),
        ),
      ),
    );
  }
}

/// Extracted menu widget for note card actions
class NoteCardMenu extends StatelessWidget {
  const NoteCardMenu({
    super.key,
    required this.note,
    required this.onEdit,
    this.onDelete,
  });

  final NoteEntity note;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final actions = [
      NoteMenuAction.edit,
      if (onDelete != null) NoteMenuAction.delete,
    ];

    return NotePopupMenu(
      actions: actions,
      onSelected: (action) async {
        switch (action) {
          case NoteMenuAction.edit:
            onEdit();
            break;
          case NoteMenuAction.delete:
            await _handleDelete(context);
            break;
          case NoteMenuAction.share:
          case NoteMenuAction.duplicate:
          case NoteMenuAction.favorite:
            // TODO: Implement these actions
            break;
        }
      },
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    if (onDelete == null) return;

    final confirmed = await SharedDialogService.showConfirmationDialog(
      context: context,
      title: K.deleteNote,
      content: K.deleteNoteMessage,
      isDestructive: true,
    );

    if (confirmed == true) {
      onDelete!();
    }
  }
}
