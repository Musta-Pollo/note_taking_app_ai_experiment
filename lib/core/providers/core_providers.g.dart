// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'd7a35a83ad0e3d2e5c3a40b438bc9be186d6af93';

/// Database provider - single instance across the app
///
/// Copied from [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeProvider<AppDatabase>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = AutoDisposeProviderRef<AppDatabase>;
String _$supabaseHash() => r'6abeb04f6d303eb0dd323e0401492c39546c0428';

/// Supabase client provider
///
/// Copied from [supabase].
@ProviderFor(supabase)
final supabaseProvider = AutoDisposeProvider<SupabaseClient>.internal(
  supabase,
  name: r'supabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$supabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SupabaseRef = AutoDisposeProviderRef<SupabaseClient>;
String _$currentUserIdHash() => r'5148bff582669d5454a37a4993cc4c5a5f41f531';

/// Current user ID provider
///
/// Copied from [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = AutoDisposeProvider<String?>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserIdRef = AutoDisposeProviderRef<String?>;
String _$syncClassHash() => r'936712edab234c73935f77c7068a78b3937cdf4d';

/// Sync class instance
///
/// Copied from [syncClass].
@ProviderFor(syncClass)
final syncClassProvider = AutoDisposeProvider<SyncClass>.internal(
  syncClass,
  name: r'syncClassProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncClassHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncClassRef = AutoDisposeProviderRef<SyncClass>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
