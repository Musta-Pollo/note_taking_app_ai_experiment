import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';

import '../../../../core/sync/sync_service.dart';
import '../../../../shared/extensions/sync_status_extensions.dart';

class SyncStatusIndicator extends ConsumerWidget {
  final VoidCallback? onTap;
  final bool isOffline;

  const SyncStatusIndicator({
    super.key,
    this.onTap,
    this.isOffline = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncStatus = ref.watch(syncServiceProvider);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              syncStatus.getColor(isOffline).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: syncStatus.getColor(isOffline)
                .withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  syncStatus.getEmoji(isOffline),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  syncStatus.getText(isOffline),
                  style: TextStyle(
                    fontSize: 14,
                    color: syncStatus.getColor(isOffline),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              isOffline ? '📱' : '📶',
              style: TextStyle(
                fontSize: 16,
                color: context.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
