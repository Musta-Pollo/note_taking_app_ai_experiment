// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoriesLocalDataSourceHash() =>
    r'317c3dc53261129d32f696b6c8172611d443f0ff';

/// Categories data source provider
///
/// Copied from [categoriesLocalDataSource].
@ProviderFor(categoriesLocalDataSource)
final categoriesLocalDataSourceProvider =
    AutoDisposeProvider<CategoriesLocalDataSource>.internal(
  categoriesLocalDataSource,
  name: r'categoriesLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoriesLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesLocalDataSourceRef
    = AutoDisposeProviderRef<CategoriesLocalDataSource>;
String _$categoriesRepositoryHash() =>
    r'eef23cd2a69227d6f945eff484c7cd6d0dc24ea0';

/// Categories repository provider
///
/// Copied from [categoriesRepository].
@ProviderFor(categoriesRepository)
final categoriesRepositoryProvider =
    AutoDisposeProvider<CategoriesRepository>.internal(
  categoriesRepository,
  name: r'categoriesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoriesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesRepositoryRef = AutoDisposeProviderRef<CategoriesRepository>;
String _$searchCategoriesHash() => r'52c17e970ddcd67a1d421af5ab5ae478433a651e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for searching categories
///
/// Copied from [searchCategories].
@ProviderFor(searchCategories)
const searchCategoriesProvider = SearchCategoriesFamily();

/// Provider for searching categories
///
/// Copied from [searchCategories].
class SearchCategoriesFamily extends Family<AsyncValue<List<CategoryEntity>>> {
  /// Provider for searching categories
  ///
  /// Copied from [searchCategories].
  const SearchCategoriesFamily();

  /// Provider for searching categories
  ///
  /// Copied from [searchCategories].
  SearchCategoriesProvider call(
    String query,
  ) {
    return SearchCategoriesProvider(
      query,
    );
  }

  @override
  SearchCategoriesProvider getProviderOverride(
    covariant SearchCategoriesProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchCategoriesProvider';
}

/// Provider for searching categories
///
/// Copied from [searchCategories].
class SearchCategoriesProvider
    extends AutoDisposeStreamProvider<List<CategoryEntity>> {
  /// Provider for searching categories
  ///
  /// Copied from [searchCategories].
  SearchCategoriesProvider(
    String query,
  ) : this._internal(
          (ref) => searchCategories(
            ref as SearchCategoriesRef,
            query,
          ),
          from: searchCategoriesProvider,
          name: r'searchCategoriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchCategoriesHash,
          dependencies: SearchCategoriesFamily._dependencies,
          allTransitiveDependencies:
              SearchCategoriesFamily._allTransitiveDependencies,
          query: query,
        );

  SearchCategoriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    Stream<List<CategoryEntity>> Function(SearchCategoriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchCategoriesProvider._internal(
        (ref) => create(ref as SearchCategoriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<CategoryEntity>> createElement() {
    return _SearchCategoriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchCategoriesProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchCategoriesRef
    on AutoDisposeStreamProviderRef<List<CategoryEntity>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchCategoriesProviderElement
    extends AutoDisposeStreamProviderElement<List<CategoryEntity>>
    with SearchCategoriesRef {
  _SearchCategoriesProviderElement(super.provider);

  @override
  String get query => (origin as SearchCategoriesProvider).query;
}

String _$categoriesNotifierHash() =>
    r'15fdab0bc4ef09b9e6c1e83fe130a9e0627d491d';

/// Categories notifier for state management
///
/// Copied from [CategoriesNotifier].
@ProviderFor(CategoriesNotifier)
final categoriesNotifierProvider = AutoDisposeStreamNotifierProvider<
    CategoriesNotifier, List<CategoryEntity>>.internal(
  CategoriesNotifier.new,
  name: r'categoriesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoriesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CategoriesNotifier = AutoDisposeStreamNotifier<List<CategoryEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
