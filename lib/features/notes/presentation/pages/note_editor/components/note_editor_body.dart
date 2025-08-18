import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';
import '../note_editor_mixins.dart';

/// Main editor body component with AppFlowy Editor
class NoteEditorBody extends ConsumerWidget with NoteEditorEvent {
  const NoteEditorBody({
    super.key,
    required this.editorStateAsync,
    required this.onRetry,
  });

  final AsyncValue<EditorState> editorStateAsync;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return editorStateAsync.when(
      data: (editorState) => _buildEditor(context, editorState),
      loading: () => _buildLoadingState(context),
      error: (error, stack) => _buildErrorState(context, error),
    );
  }

  /// Build the AppFlowy Editor
  Widget _buildEditor(BuildContext context, EditorState editorState) {
    return Container(
      color: context.colorScheme.surface,
      child: AppFlowyEditor(
        editorState: editorState,
        editorStyle: EditorStyle.desktop(
          padding: const EdgeInsets.all(24),
          cursorColor: Theme.of(context).primaryColor,
          selectionColor:
              Theme.of(context).primaryColor.withValues(alpha: 0.2),
          textStyleConfiguration: TextStyleConfiguration(
            text: TextStyle(
              fontSize: 16,
              color: context.colorScheme.onSurface,
            ),
            bold: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
            italic: TextStyle(
              fontStyle: FontStyle.italic,
              color: context.colorScheme.onSurface,
            ),
            underline: TextStyle(
              decoration: TextDecoration.underline,
              color: context.colorScheme.onSurface,
            ),
            strikethrough: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: context.colorScheme.onSurface,
            ),
            href: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
            code: TextStyle(
              fontFamily: 'monospace',
              color: context.colorScheme.onSurface,
              backgroundColor: context.colorScheme.surfaceContainerHighest,
            ),
          ),
        ),
      ),
    );
  }

  /// Build loading state
  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Initializing editor with CRDT sync...'),
        ],
      ),
    );
  }

  /// Build error state
  Widget _buildErrorState(BuildContext context, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64),
          const SizedBox(height: 16),
          const Text('Failed to initialize editor'),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}