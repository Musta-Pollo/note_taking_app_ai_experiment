import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/sync/models/sync_status.dart';

/// UI extensions for SyncStatus to provide colors, text, and emojis
extension SyncStatusUI on SyncStatus {
  Color getColor([bool isOffline = false]) {
    if (isOffline) return Colors.orange;
    return switch (this) {
      SyncStatusIdle() => Colors.grey,
      SyncStatusSyncing() => Colors.blue,
      SyncStatusCompleted() => Colors.green,
      SyncStatusError() => Colors.red,
    };
  }

  String getText([bool isOffline = false]) {
    if (isOffline) return 'Offline Mode';
    return switch (this) {
      SyncStatusIdle() => 'Ready to sync',
      SyncStatusSyncing() => 'Syncing...',
      SyncStatusCompleted(lastSync: final lastSync) => _getTimeAgo(lastSync),
      SyncStatusError() => 'Sync Error',
    };
  }

  String getEmoji([bool isOffline = false]) {
    if (isOffline) return '📱';
    return switch (this) {
      SyncStatusIdle() => '⏸️',
      SyncStatusSyncing() => '🔄',
      SyncStatusCompleted() => '✅',
      SyncStatusError() => '❌',
    };
  }

  /// Get icon for sync status
  IconData getIcon() {
    return switch (this) {
      SyncStatusIdle() => Icons.sync_disabled,
      SyncStatusSyncing() => Icons.sync,
      SyncStatusCompleted() => Icons.cloud_done,
      SyncStatusError() => Icons.sync_problem,
    };
  }

  /// Get detailed status text for dialogs
  String getDetailedText([bool isOffline = false]) {
    if (isOffline) return 'Working offline - data stored locally only';
    return switch (this) {
      SyncStatusIdle() => 'Ready to sync',
      SyncStatusSyncing() => 'Synchronizing with server...',
      SyncStatusCompleted() => 'All notes are synced',
      SyncStatusError(message: final message) => 'Sync failed: $message',
    };
  }

  /// Format DateTime using timeago
  static String formatDateTime(DateTime dateTime) {
    return timeago.format(dateTime);
  }

  String _getTimeAgo(DateTime dateTime) {
    return timeago.format(
      dateTime,
      locale: 'en_short',
    );
  }
}
