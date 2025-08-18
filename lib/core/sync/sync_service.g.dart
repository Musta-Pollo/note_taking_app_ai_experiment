// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncServiceHash() => r'0366c9ff0b5113b6baf1c72705d58502d2b35aab';

/// Main sync service that delegates to the SyncCoordinator
/// This maintains backward compatibility while using the new architecture
///
/// Copied from [SyncService].
@ProviderFor(SyncService)
final syncServiceProvider =
    AutoDisposeNotifierProvider<SyncService, SyncStatus>.internal(
  SyncService.new,
  name: r'syncServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncService = AutoDisposeNotifier<SyncStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
