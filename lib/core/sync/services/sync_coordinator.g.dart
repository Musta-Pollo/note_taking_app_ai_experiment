// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncCoordinatorHash() => r'7fa3f6e8694c7617dc4df0da630862592b9220e8';

/// Main sync coordination service that orchestrates the sync process
///
/// Copied from [SyncCoordinator].
@ProviderFor(SyncCoordinator)
final syncCoordinatorProvider =
    AutoDisposeNotifierProvider<SyncCoordinator, SyncStatus>.internal(
  SyncCoordinator.new,
  name: r'syncCoordinatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncCoordinatorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncCoordinator = AutoDisposeNotifier<SyncStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
