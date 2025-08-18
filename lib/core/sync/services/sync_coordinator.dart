import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../database/app_database.dart';
import '../../providers/core_providers.dart';
import '../models/sync_status.dart';
import '../sync_manager.dart';
import '../../../shared/constants/k.dart';
import 'offline_user_manager.dart';
import 'realtime_subscriber.dart';

part 'sync_coordinator.g.dart';

/// Main sync coordination service that orchestrates the sync process
@riverpod
class SyncCoordinator extends _$SyncCoordinator {
  @override
  SyncStatus build() {
    _initialize();
    return const SyncStatus.idle();
  }

  late final AppDatabase _database;
  late final SupabaseClient _supabase;
  late final SyncClass _syncClass;
  late final SharedPreferences _prefs;
  late final OfflineUserManager _offlineUserManager;
  late final RealtimeSubscriber _realtimeSubscriber;

  bool _isSyncing = false;
  bool _isLoggedIn = false;
  bool _extraSyncNeeded = false;
  StreamSubscription? _streamSubscription;

  static const String _lastPulledAtKey = K.lastPulledAtKey;
  static const Duration _debounceDelay = K.syncDebounceDelay;
  static const Duration _syncTimeout = K.syncTimeout;

  void _initialize() async {
    _database = ref.read(databaseProvider);
    _supabase = ref.read(supabaseProvider);
    _syncClass = ref.read(syncClassProvider);
    _prefs = await SharedPreferences.getInstance();
    _offlineUserManager = ref.read(offlineUserManagerProvider.notifier);
    _realtimeSubscriber = ref.read(realtimeSubscriberProvider.notifier);

    _checkInitialLoginStatus();

    // Start listening when user is authenticated
    ref.listen(currentUserIdProvider, (previous, next) {
      if (next != null && !_isLoggedIn) {
        signIn();
      } else if (next == null && _isLoggedIn) {
        signOut();
      }
    });
  }

  Future<void> _checkInitialLoginStatus() async {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      signIn();
    }
  }

  void signIn() {
    _isLoggedIn = true;
    _startListening();
  }

  void signOut() {
    _isLoggedIn = false;
    _stopListening();
    _disposeResources();
  }

  void _startListening() {
    queueSync();
    _listenOnLocalUpdates();
    _realtimeSubscriber.startListening(_queueSyncDebounce);
  }

  void _stopListening() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    _realtimeSubscriber.stopListening();
    EasyDebounce.cancel('sync');
  }

  void _disposeResources() {
    _streamSubscription?.cancel();
    _realtimeSubscriber.dispose();
    EasyDebounce.cancel('sync');
  }

  void _listenOnLocalUpdates() {
    final combinedStream = _syncClass.getUpdateStreams(_database);
    _streamSubscription = combinedStream.listen((data) async {
      final hasLocalChanges = await _hasLocalChanges();
      if (hasLocalChanges) {
        _queueSyncDebounce();
      }
    });
  }

  Future<bool> _hasLocalChanges() async {
    final localChanges = await _syncClass.getChanges(
      _getLastPulledAt() ?? DateTime(2000),
      _database,
      _realtimeSubscriber.currentInstanceId,
    );
    
    return !localChanges.values.every((element) {
      return (element as Map<String, dynamic>)
          .values
          .every((innerElement) => innerElement.isEmpty);
    });
  }

  void _queueSyncDebounce() {
    EasyDebounce.debounce('sync', _debounceDelay, () {
      queueSync();
    });
  }

  void queueSync() {
    if (_isSyncing) {
      _extraSyncNeeded = true;
      return;
    }

    _isSyncing = true;
    state = const SyncStatus.syncing();

    _synchronize().then((_) {
      _isSyncing = false;
      state = SyncStatus.completed(DateTime.now());

      if (_extraSyncNeeded) {
        _extraSyncNeeded = false;
        Future.delayed(const Duration(milliseconds: 800), () {
          queueSync();
        });
      }
    }).catchError((error, stackTrace) {
      _isSyncing = false;
      state = SyncStatus.error(error.toString());
    });
  }

  Future<void> _synchronize() async {
    await _synchronizeBase();
  }

  Future<void> _synchronizeBase() async {
    const maxRetries = K.maxSyncRetries;
    const baseDelay = K.baseSyncRetryDelay;

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        final lastPulledAt = _getLastPulledAt() ?? DateTime(2000);
        final now = DateTime.now();

        // Pull changes from server
        final pullResponse = await _supabase.rpc('pull_changes', params: {
          'collections': _syncClass.syncedTables(),
          'last_pulled_at': lastPulledAt.toUtc().toIso8601String(),
        });

        final changes = pullResponse['changes'] as Map<String, dynamic>;

        // Apply changes to the local database
        await _database.transaction(() async {
          await _syncClass.sync(changes, _database);
        });

        await _pushLocalChanges(lastPulledAt, now);
        return; // Success, exit retry loop
      } catch (e) {
        if (attempt == maxRetries - 1) {
          // Last attempt failed, rethrow the error
          rethrow;
        }
        
        // Wait with exponential backoff before retrying
        final delay = baseDelay * (attempt + 1);
        await Future.delayed(delay);
      }
    }
  }

  Future<void> _pushLocalChanges(DateTime lastPulledAt, DateTime now) async {
    try {
      // Push local changes to the server
      final localChanges = await _syncClass.getChanges(
        lastPulledAt,
        _database,
        _realtimeSubscriber.currentInstanceId,
      );

      final isLocalChangesEmpty = localChanges.values.every((element) {
        return (element as Map<String, dynamic>)
            .values
            .every((innerElement) => innerElement.isEmpty);
      });

      if (!isLocalChangesEmpty) {
        // Convert all data where user_id = 'offline-user' to actual user_id
        final correctedChanges = _offlineUserManager.correctOfflineUserIds(localChanges);
        
        try {
          final res = await _supabase.rpc('push_changes', params: {
            '_changes': correctedChanges,
            'last_pulled_at': now.toIso8601String(),
          }).timeout(_syncTimeout);
          await _setLastPulledAt(DateTime.parse(res));
        } catch (e) {
          // Handle push error - will retry on next sync
          rethrow;
        }
      } else {
        await _setLastPulledAt(now.subtract(const Duration(minutes: 2)));
      }
    } catch (e) {
      // Handle push error silently - sync will retry later
      rethrow;
    }
  }

  /// Helper methods for managing last sync timestamp
  DateTime? _getLastPulledAt() {
    final timestamp = _prefs.getString(_lastPulledAtKey);
    return timestamp != null ? DateTime.parse(timestamp) : null;
  }

  Future<void> _setLastPulledAt(DateTime timestamp) async {
    await _prefs.setString(_lastPulledAtKey, timestamp.toIso8601String());
  }

  /// Manual sync trigger for UI
  Future<void> forceSync() async {
    queueSync();
  }

  /// Dispose resources when the service is no longer needed
  void dispose() {
    _disposeResources();
  }
}