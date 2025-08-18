import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'models/sync_status.dart';
import 'services/sync_coordinator.dart';

part 'sync_service.g.dart';

/// Main sync service that delegates to the SyncCoordinator
/// This maintains backward compatibility while using the new architecture
@riverpod
class SyncService extends _$SyncService {
  @override
  SyncStatus build() {
    // Delegate to the sync coordinator
    ref.onDispose(dispose);

    return ref.watch(syncCoordinatorProvider);
  }

  /// Manual sync trigger for UI
  Future<void> forceSync() async {
    ref.read(syncCoordinatorProvider.notifier).forceSync();
  }

  /// Dispose resources when the service is no longer needed
  void dispose() {
    // Note: dispose is called via ref.onDispose, so no manual cleanup needed
    // The SyncCoordinator will handle its own cleanup
  }
}

