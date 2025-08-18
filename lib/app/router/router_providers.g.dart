// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'54cfe953057b7ff6c546e24c553a9062044bcfbd';

/// App router provider
///
/// Copied from [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = AutoDisposeProvider<AppRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppRouterRef = AutoDisposeProviderRef<AppRouter>;
String _$navigationHelperHash() => r'783a77355c5e559be90b6d73366a7688fda00ab5';

/// Navigation helper provider
///
/// Copied from [NavigationHelper].
@ProviderFor(NavigationHelper)
final navigationHelperProvider =
    AutoDisposeNotifierProvider<NavigationHelper, void>.internal(
  NavigationHelper.new,
  name: r'navigationHelperProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$navigationHelperHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NavigationHelper = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
