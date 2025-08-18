import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/sync/models/sync_status.dart';
import '../../../../shared/extensions/sync_status_extensions.dart';

class SyncStatusDialog extends StatelessWidget {
  const SyncStatusDialog({
    super.key,
    required this.syncStatus,
    required this.isOffline,
    required this.onForceSync,
    required this.onSignIn,
  });

  final SyncStatus syncStatus;
  final bool isOffline;
  final VoidCallback onForceSync;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final syncStatus = this.syncStatus;
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            syncStatus.getIcon(),
            color: syncStatus.getColor(isOffline),
          ),
          const SizedBox(width: 8),
          Text(isOffline ? 'Offline Mode' : 'Sync Status'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSyncStatusDetail(
              'Status', syncStatus.getDetailedText(isOffline)),
          if (!isOffline && syncStatus is SyncStatusCompleted) ...[
            const SizedBox(height: 8),
            _buildSyncStatusDetail(
                'Last Sync', SyncStatusUI.formatDateTime(syncStatus.lastSync)),
          ],
          if (!isOffline && syncStatus is SyncStatusError) ...[
            const SizedBox(height: 8),
            _buildSyncStatusDetail('Error', syncStatus.message),
          ],
          if (isOffline) ...[
            const SizedBox(height: 8),
            const Text(
              'Sign in to enable cloud sync and access your notes on all devices.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.maybePop(),
          child: const Text('Close'),
        ),
        if (isOffline)
          ElevatedButton(
            onPressed: () {
              context.maybePop();
              onSignIn();
            },
            child: const Text('Sign In'),
          )
        else if (syncStatus is! SyncStatusSyncing)
          ElevatedButton(
            onPressed: () {
              context.maybePop();
              onForceSync();
            },
            child: const Text('Sync Now'),
          ),
      ],
    );
  }
}

Widget _buildSyncStatusDetail(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 80,
        child: Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      Expanded(
        child: Text(value),
      ),
    ],
  );
}
