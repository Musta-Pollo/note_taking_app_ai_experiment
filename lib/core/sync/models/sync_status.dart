/// Sync status representation
sealed class SyncStatus {
  const SyncStatus();

  const factory SyncStatus.idle() = SyncStatusIdle;
  const factory SyncStatus.syncing() = SyncStatusSyncing;
  const factory SyncStatus.completed(DateTime lastSync) = SyncStatusCompleted;
  const factory SyncStatus.error(String message) = SyncStatusError;
}

class SyncStatusIdle extends SyncStatus {
  const SyncStatusIdle();
}

class SyncStatusSyncing extends SyncStatus {
  const SyncStatusSyncing();
}

class SyncStatusCompleted extends SyncStatus {
  const SyncStatusCompleted(this.lastSync);
  final DateTime lastSync;
}

class SyncStatusError extends SyncStatus {
  const SyncStatusError(this.message);
  final String message;
}