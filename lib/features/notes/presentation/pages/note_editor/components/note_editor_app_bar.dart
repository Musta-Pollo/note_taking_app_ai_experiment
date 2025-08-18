import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import 'package:note_taking_app/core/sync/models/sync_status.dart';

import '../../../../../../shared/components/app_popup_menu.dart';
import '../../../../../../shared/enums/menu_actions.dart';
import '../note_editor_mixins.dart';

/// App bar component for note editor with title and actions
class NoteEditorAppBar extends ConsumerWidget
    with NoteEditorState, NoteEditorEvent
    implements PreferredSizeWidget {
  const NoteEditorAppBar({
    super.key,
    required this.note,
    required this.syncStatus,
    required this.onExport,
    required this.onRefresh,
  });

  final NoteEntity? note;
  final SyncStatus syncStatus;
  final VoidCallback onExport;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = generateNoteTitle(note);

    return AppBar(
      title: Text(title),
      leading: const AutoLeadingButton(),
      actions: [
        // Show sync status
        buildSyncStatusIcon(syncStatus),
        EditorPopupMenu(
          actions: const [
            EditorMenuAction.export,
            EditorMenuAction.refresh,
          ],
          onSelected: (action) {
            switch (action) {
              case EditorMenuAction.export:
                onExport();
                break;
              case EditorMenuAction.refresh:
                onRefresh();
                break;
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
