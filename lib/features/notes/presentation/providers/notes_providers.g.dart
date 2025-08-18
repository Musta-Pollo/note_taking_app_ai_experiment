// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notesLocalDataSourceHash() =>
    r'8806839867478f01f92bc7f4aa6599a39e7a9a28';

/// Notes data source provider
///
/// Copied from [notesLocalDataSource].
@ProviderFor(notesLocalDataSource)
final notesLocalDataSourceProvider =
    AutoDisposeProvider<NotesLocalDataSource>.internal(
  notesLocalDataSource,
  name: r'notesLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotesLocalDataSourceRef = AutoDisposeProviderRef<NotesLocalDataSource>;
String _$notesRepositoryHash() => r'5463c5a0bdb89219b35a962e1cd5d47e7b3d6339';

/// Notes repository provider
///
/// Copied from [notesRepository].
@ProviderFor(notesRepository)
final notesRepositoryProvider = AutoDisposeProvider<NotesRepository>.internal(
  notesRepository,
  name: r'notesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotesRepositoryRef = AutoDisposeProviderRef<NotesRepository>;
String _$searchNotesHash() => r'2622105696750e65e197030bff9f6cd75b351a0b';

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

/// Provider for searching notes
///
/// Copied from [searchNotes].
@ProviderFor(searchNotes)
const searchNotesProvider = SearchNotesFamily();

/// Provider for searching notes
///
/// Copied from [searchNotes].
class SearchNotesFamily extends Family<AsyncValue<List<NoteEntity>>> {
  /// Provider for searching notes
  ///
  /// Copied from [searchNotes].
  const SearchNotesFamily();

  /// Provider for searching notes
  ///
  /// Copied from [searchNotes].
  SearchNotesProvider call(
    String query,
  ) {
    return SearchNotesProvider(
      query,
    );
  }

  @override
  SearchNotesProvider getProviderOverride(
    covariant SearchNotesProvider provider,
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
  String? get name => r'searchNotesProvider';
}

/// Provider for searching notes
///
/// Copied from [searchNotes].
class SearchNotesProvider extends AutoDisposeStreamProvider<List<NoteEntity>> {
  /// Provider for searching notes
  ///
  /// Copied from [searchNotes].
  SearchNotesProvider(
    String query,
  ) : this._internal(
          (ref) => searchNotes(
            ref as SearchNotesRef,
            query,
          ),
          from: searchNotesProvider,
          name: r'searchNotesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchNotesHash,
          dependencies: SearchNotesFamily._dependencies,
          allTransitiveDependencies:
              SearchNotesFamily._allTransitiveDependencies,
          query: query,
        );

  SearchNotesProvider._internal(
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
    Stream<List<NoteEntity>> Function(SearchNotesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchNotesProvider._internal(
        (ref) => create(ref as SearchNotesRef),
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
  AutoDisposeStreamProviderElement<List<NoteEntity>> createElement() {
    return _SearchNotesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchNotesProvider && other.query == query;
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
mixin SearchNotesRef on AutoDisposeStreamProviderRef<List<NoteEntity>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchNotesProviderElement
    extends AutoDisposeStreamProviderElement<List<NoteEntity>>
    with SearchNotesRef {
  _SearchNotesProviderElement(super.provider);

  @override
  String get query => (origin as SearchNotesProvider).query;
}

String _$sortedNotesHash() => r'6e269274778c9cc5cae27a94638714bea095b9d0';

/// Provider for sorted notes (can filter by category when categoryId is provided)
///
/// Copied from [sortedNotes].
@ProviderFor(sortedNotes)
const sortedNotesProvider = SortedNotesFamily();

/// Provider for sorted notes (can filter by category when categoryId is provided)
///
/// Copied from [sortedNotes].
class SortedNotesFamily extends Family<AsyncValue<List<NoteEntity>>> {
  /// Provider for sorted notes (can filter by category when categoryId is provided)
  ///
  /// Copied from [sortedNotes].
  const SortedNotesFamily();

  /// Provider for sorted notes (can filter by category when categoryId is provided)
  ///
  /// Copied from [sortedNotes].
  SortedNotesProvider call({
    String? categoryId,
    SortType sortType = SortType.dateDesc,
  }) {
    return SortedNotesProvider(
      categoryId: categoryId,
      sortType: sortType,
    );
  }

  @override
  SortedNotesProvider getProviderOverride(
    covariant SortedNotesProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
      sortType: provider.sortType,
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
  String? get name => r'sortedNotesProvider';
}

/// Provider for sorted notes (can filter by category when categoryId is provided)
///
/// Copied from [sortedNotes].
class SortedNotesProvider extends AutoDisposeStreamProvider<List<NoteEntity>> {
  /// Provider for sorted notes (can filter by category when categoryId is provided)
  ///
  /// Copied from [sortedNotes].
  SortedNotesProvider({
    String? categoryId,
    SortType sortType = SortType.dateDesc,
  }) : this._internal(
          (ref) => sortedNotes(
            ref as SortedNotesRef,
            categoryId: categoryId,
            sortType: sortType,
          ),
          from: sortedNotesProvider,
          name: r'sortedNotesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sortedNotesHash,
          dependencies: SortedNotesFamily._dependencies,
          allTransitiveDependencies:
              SortedNotesFamily._allTransitiveDependencies,
          categoryId: categoryId,
          sortType: sortType,
        );

  SortedNotesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.sortType,
  }) : super.internal();

  final String? categoryId;
  final SortType sortType;

  @override
  Override overrideWith(
    Stream<List<NoteEntity>> Function(SortedNotesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SortedNotesProvider._internal(
        (ref) => create(ref as SortedNotesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        sortType: sortType,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<NoteEntity>> createElement() {
    return _SortedNotesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SortedNotesProvider &&
        other.categoryId == categoryId &&
        other.sortType == sortType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, sortType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SortedNotesRef on AutoDisposeStreamProviderRef<List<NoteEntity>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `sortType` of this provider.
  SortType get sortType;
}

class _SortedNotesProviderElement
    extends AutoDisposeStreamProviderElement<List<NoteEntity>>
    with SortedNotesRef {
  _SortedNotesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as SortedNotesProvider).categoryId;
  @override
  SortType get sortType => (origin as SortedNotesProvider).sortType;
}

String _$notesNotifierHash() => r'3891bd2a6092a29e0a0da503143612d6239fead1';

/// Main notes notifier
///
/// Copied from [NotesNotifier].
@ProviderFor(NotesNotifier)
final notesNotifierProvider =
    AutoDisposeStreamNotifierProvider<NotesNotifier, List<NoteEntity>>.internal(
  NotesNotifier.new,
  name: r'notesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotesNotifier = AutoDisposeStreamNotifier<List<NoteEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
