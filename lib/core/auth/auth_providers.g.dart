// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authUserHash() => r'4fbfbf4096c383e5fac40338f1d1df18566a7950';

/// Current authenticated user provider
///
/// Copied from [authUser].
@ProviderFor(authUser)
final authUserProvider = AutoDisposeProvider<AsyncValue<User?>>.internal(
  authUser,
  name: r'authUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthUserRef = AutoDisposeProviderRef<AsyncValue<User?>>;
String _$authStateChangesHash() => r'e843215c40a43b3c6e129a609202494d1bd9bd38';

/// Auth state changes stream provider
///
/// Copied from [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = AutoDisposeStreamProvider<AuthState>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateChangesRef = AutoDisposeStreamProviderRef<AuthState>;
String _$authServiceHash() => r'4622ce8d13a7372f2d055c762c903d59019f8c69';

/// Sign in with email and password
///
/// Copied from [AuthService].
@ProviderFor(AuthService)
final authServiceProvider =
    AutoDisposeNotifierProvider<AuthService, AsyncValue<User?>>.internal(
  AuthService.new,
  name: r'authServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthService = AutoDisposeNotifier<AsyncValue<User?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
