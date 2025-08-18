import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../providers/core_providers.dart';
import '../sync_manager.dart';

part 'realtime_subscriber.g.dart';

/// Service responsible for handling real-time subscriptions
@riverpod
class RealtimeSubscriber extends _$RealtimeSubscriber {
  @override
  bool build() {
    return false; // Not subscribed initially
  }

  late final SupabaseClient _supabase;

  final String _currentInstanceId = const Uuid().v4();
  RealtimeChannel? _realtimeChannel;
  bool _isInitialized = false;

  /// Initialize the subscriber with dependencies
  void initialize() {
    if (_isInitialized) return;

    _supabase = ref.read(supabaseProvider);
    _isInitialized = true;
  }

  /// Start listening to server updates
  void startListening(VoidCallback onServerChange) {
    if (state) return; // Already listening

    initialize();

    // Clean up any existing channel before creating a new one
    if (_realtimeChannel != null) {
      _realtimeChannel?.unsubscribe();
      _realtimeChannel = null;
    }

    _realtimeChannel = _supabase
        .channel('db-changes-$_currentInstanceId') // Use unique channel name
        .onAllSyncClassChanges(_currentInstanceId, (payload) {
      onServerChange();
    });

    _realtimeChannel?.subscribe();
    state = true;
  }

  /// Stop listening to server updates
  void stopListening() {
    if (!state) return; // Not listening

    _realtimeChannel?.unsubscribe();
    _realtimeChannel = null;
    state = false;
  }

  /// Get the current instance ID
  String get currentInstanceId => _currentInstanceId;

  /// Dispose resources
  void dispose() {
    stopListening();
  }
}
