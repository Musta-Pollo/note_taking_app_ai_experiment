import 'package:flutter/material.dart';
import 'package:note_taking_app/core/sync/models/sync_status.dart';
import 'package:note_taking_app/shared/dialogs/confirmation_dialog.dart';
import 'package:note_taking_app/shared/dialogs/sync_status_dialog.dart';

class SharedDialogService {
  /// Show success message with green background
  static void showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  /// Show error message with red background
  static void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Show info message with blue background
  static void showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /// Show warning message with orange background
  static void showWarningMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
      ),
    );
  }

  // Show sync statuc dialog
  static void showSyncStatusDialog({
    required BuildContext context,
    required SyncStatus syncStatus,
    required bool isOffline,
    required VoidCallback onForceSync,
    required VoidCallback onSignIn,
  }) {
    showDialog<bool>(
      context: context,
      builder: (context) => SyncStatusDialog(
        syncStatus: syncStatus,
        isOffline: isOffline,
        onForceSync: onForceSync,
        onSignIn: onSignIn,
      ),
    );
  }

  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmLabel = 'Delete',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
  }
}
