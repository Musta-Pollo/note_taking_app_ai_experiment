import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/sync/models/sync_status.dart';
import 'package:note_taking_app/core/sync/sync_service.dart';
import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
import 'package:note_taking_app/features/notes/presentation/providers/editor_state_wrapper_providers.dart';
import 'package:note_taking_app/features/notes/presentation/providers/notes_providers.dart';
import 'package:note_taking_app/shared/dialogs/shared_dialog_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// Export components
export 'components/note_editor_app_bar.dart';
export 'components/note_editor_body.dart';

/// Note editor page state mixin - manages all state access for NoteEditorPage
///
/// This mixin centralizes all data listening for the note editor page to enable
/// efficient coordination between related providers and reduce unnecessary rebuilds.
/// Components receive already-resolved AsyncValues instead of listening independently.
mixin class NoteEditorState {
  /// Get note by ID
  Future<NoteEntity?> getNoteById(WidgetRef ref, String noteId) async {
    return await ref.read(notesNotifierProvider.notifier).getNoteById(noteId);
  }

  /// Get editor state for note
  AsyncValue<EditorState> getEditorState(WidgetRef ref, String noteId) =>
      ref.watch(editorStateWrapperProvider(noteId));

  /// Get document sync status
  SyncStatus getSyncStatus(WidgetRef ref) => ref.watch(syncServiceProvider);

  /// Check if sync is in progress
  bool isSyncing(SyncStatus syncStatus) => syncStatus is SyncStatusSyncing;

  /// Check if sync has error
  bool hasSyncError(SyncStatus syncStatus) => syncStatus is SyncStatusError;

  /// Get sync error message
  String? getSyncErrorMessage(SyncStatus syncStatus) {
    return syncStatus is SyncStatusError ? syncStatus.message : null;
  }

  /// Generate note title from content
  String generateNoteTitle(NoteEntity? note) {
    if (note?.content != null && note!.content.isNotEmpty) {
      return note.content.length > 30
          ? '${note.content.substring(0, 30)}...'
          : note.content;
    }
    return 'Rich Text Editor';
  }
}

/// Note editor page events mixin - manages all events/actions for NoteEditorPage
///
/// This mixin handles all user interactions and navigation events for the note editor page.
/// It provides clean separation between state management and event handling.
mixin NoteEditorEvent {
  /// Navigate back to previous page
  void navigateBack(BuildContext context) {
    context.router.maybePop();
  }

  /// Refresh editor state
  void refreshEditor(WidgetRef ref, String noteId) {
    ref.read(editorStateWrapperProvider(noteId).notifier).refresh();
  }

  /// Show error and navigate back
  void showErrorAndGoBack(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      navigateBack(context);
    }
  }

  /// Export document to markdown
  void exportDocument(BuildContext context, EditorState? editorState) {
    if (editorState == null) return;

    // Convert document to markdown
    final markdown = documentToMarkdown(editorState.document);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Document'),
        content: SingleChildScrollView(
          child: SelectableText(markdown),
        ),
        actions: [
          TextButton(
            onPressed: () => context.maybePop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () async {
              context.maybePop();
              await exportMarkdownFile(context, markdown);
            },
            child: const Text('Export File'),
          ),
        ],
      ),
    );
  }

  /// Export markdown content to file and share it
  Future<void> exportMarkdownFile(
    BuildContext context,
    String markdown, {
    String? filename,
  }) async {
    try {
      // Create a safe filename
      String safeFilename = filename ?? 'note';
      if (safeFilename.isNotEmpty) {
        // Sanitize filename
        safeFilename = safeFilename
            .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove invalid chars
            .replaceAll(RegExp(r'\s+'), '_') // Replace spaces with underscores
            .toLowerCase();
        // Limit filename length
        if (safeFilename.length > 50) {
          safeFilename = safeFilename.substring(0, 50);
        }
      }

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$safeFilename.md');

      // Write markdown content to file
      await file.writeAsString(markdown);

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Exported note from Notes App',
      );

      if (context.mounted) {
        SharedDialogService.showSuccessMessage(
          context,
          'Note exported successfully',
        );
      }
    } catch (e) {
      if (context.mounted) {
        SharedDialogService.showErrorMessage(
          context,
          'Error exporting file: $e',
        );
      }
    }
  }

  /// Generate filename from note content
  String generateFilename(String noteId, NoteEntity? note) {
    String filename = 'note_$noteId';
    if (note?.content != null && note!.content.isNotEmpty) {
      // Use first line of content as filename, sanitized
      final firstLine = note.content.split('\n').first.trim();
      if (firstLine.isNotEmpty) {
        filename = firstLine;
      }
    }
    return filename;
  }

  /// Build sync status icon
  Widget buildSyncStatusIcon(SyncStatus syncStatus) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: switch (syncStatus) {
        SyncStatusSyncing() => const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        SyncStatusError() => Icon(
            Icons.sync_problem,
            color: Colors.red[700],
          ),
        SyncStatusIdle() || SyncStatusCompleted() => Icon(
            Icons.sync,
            color: Colors.green[700],
          ),
      },
    );
  }

  /// Get sync status banner color
  Color? getSyncBannerColor(SyncStatus syncStatus) {
    return switch (syncStatus) {
      SyncStatusSyncing() => Colors.blue.withValues(alpha: 0.1),
      SyncStatusError() => Colors.red.withValues(alpha: 0.1),
      SyncStatusIdle() || SyncStatusCompleted() => null,
    };
  }

  /// Get sync status text color
  Color? getSyncTextColor(SyncStatus syncStatus) {
    return switch (syncStatus) {
      SyncStatusSyncing() => Colors.blue[700],
      SyncStatusError() => Colors.red[700],
      SyncStatusIdle() || SyncStatusCompleted() => null,
    };
  }

  /// Get sync status icon for banner
  Widget? getSyncBannerIcon(SyncStatus syncStatus) {
    return switch (syncStatus) {
      SyncStatusSyncing() => SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.blue[700],
          ),
        ),
      SyncStatusError() => Icon(
          Icons.error,
          size: 16,
          color: Colors.red[700],
        ),
      SyncStatusIdle() || SyncStatusCompleted() => null,
    };
  }

  /// Get sync status message
  String? getSyncStatusMessage(SyncStatus syncStatus) {
    return switch (syncStatus) {
      SyncStatusSyncing() => 'Syncing...',
      SyncStatusError() => 'Sync error: ${syncStatus.message}',
      SyncStatusIdle() || SyncStatusCompleted() => null,
    };
  }
}
