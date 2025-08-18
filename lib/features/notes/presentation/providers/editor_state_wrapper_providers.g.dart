// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_state_wrapper_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isDocumentInitializedHash() =>
    r'169c4da1cad2c3a184c045743dc96d836e470de4';

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

/// Provider for checking if document has been initialized
///
/// Copied from [isDocumentInitialized].
@ProviderFor(isDocumentInitialized)
const isDocumentInitializedProvider = IsDocumentInitializedFamily();

/// Provider for checking if document has been initialized
///
/// Copied from [isDocumentInitialized].
class IsDocumentInitializedFamily extends Family<AsyncValue<bool>> {
  /// Provider for checking if document has been initialized
  ///
  /// Copied from [isDocumentInitialized].
  const IsDocumentInitializedFamily();

  /// Provider for checking if document has been initialized
  ///
  /// Copied from [isDocumentInitialized].
  IsDocumentInitializedProvider call(
    String noteId,
  ) {
    return IsDocumentInitializedProvider(
      noteId,
    );
  }

  @override
  IsDocumentInitializedProvider getProviderOverride(
    covariant IsDocumentInitializedProvider provider,
  ) {
    return call(
      provider.noteId,
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
  String? get name => r'isDocumentInitializedProvider';
}

/// Provider for checking if document has been initialized
///
/// Copied from [isDocumentInitialized].
class IsDocumentInitializedProvider extends AutoDisposeFutureProvider<bool> {
  /// Provider for checking if document has been initialized
  ///
  /// Copied from [isDocumentInitialized].
  IsDocumentInitializedProvider(
    String noteId,
  ) : this._internal(
          (ref) => isDocumentInitialized(
            ref as IsDocumentInitializedRef,
            noteId,
          ),
          from: isDocumentInitializedProvider,
          name: r'isDocumentInitializedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isDocumentInitializedHash,
          dependencies: IsDocumentInitializedFamily._dependencies,
          allTransitiveDependencies:
              IsDocumentInitializedFamily._allTransitiveDependencies,
          noteId: noteId,
        );

  IsDocumentInitializedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.noteId,
  }) : super.internal();

  final String noteId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsDocumentInitializedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsDocumentInitializedProvider._internal(
        (ref) => create(ref as IsDocumentInitializedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        noteId: noteId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsDocumentInitializedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsDocumentInitializedProvider && other.noteId == noteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, noteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsDocumentInitializedRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `noteId` of this provider.
  String get noteId;
}

class _IsDocumentInitializedProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with IsDocumentInitializedRef {
  _IsDocumentInitializedProviderElement(super.provider);

  @override
  String get noteId => (origin as IsDocumentInitializedProvider).noteId;
}

String _$editorStateWrapperHash() =>
    r'5f1a16a36bfaac3d213bae3e184fa66c8ca35789';

abstract class _$EditorStateWrapper
    extends BuildlessAutoDisposeAsyncNotifier<EditorState> {
  late final String noteId;

  FutureOr<EditorState> build(
    String noteId,
  );
}

/// Provider for EditorState with CRDT synchronization
///
/// Copied from [EditorStateWrapper].
@ProviderFor(EditorStateWrapper)
const editorStateWrapperProvider = EditorStateWrapperFamily();

/// Provider for EditorState with CRDT synchronization
///
/// Copied from [EditorStateWrapper].
class EditorStateWrapperFamily extends Family<AsyncValue<EditorState>> {
  /// Provider for EditorState with CRDT synchronization
  ///
  /// Copied from [EditorStateWrapper].
  const EditorStateWrapperFamily();

  /// Provider for EditorState with CRDT synchronization
  ///
  /// Copied from [EditorStateWrapper].
  EditorStateWrapperProvider call(
    String noteId,
  ) {
    return EditorStateWrapperProvider(
      noteId,
    );
  }

  @override
  EditorStateWrapperProvider getProviderOverride(
    covariant EditorStateWrapperProvider provider,
  ) {
    return call(
      provider.noteId,
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
  String? get name => r'editorStateWrapperProvider';
}

/// Provider for EditorState with CRDT synchronization
///
/// Copied from [EditorStateWrapper].
class EditorStateWrapperProvider extends AutoDisposeAsyncNotifierProviderImpl<
    EditorStateWrapper, EditorState> {
  /// Provider for EditorState with CRDT synchronization
  ///
  /// Copied from [EditorStateWrapper].
  EditorStateWrapperProvider(
    String noteId,
  ) : this._internal(
          () => EditorStateWrapper()..noteId = noteId,
          from: editorStateWrapperProvider,
          name: r'editorStateWrapperProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editorStateWrapperHash,
          dependencies: EditorStateWrapperFamily._dependencies,
          allTransitiveDependencies:
              EditorStateWrapperFamily._allTransitiveDependencies,
          noteId: noteId,
        );

  EditorStateWrapperProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.noteId,
  }) : super.internal();

  final String noteId;

  @override
  FutureOr<EditorState> runNotifierBuild(
    covariant EditorStateWrapper notifier,
  ) {
    return notifier.build(
      noteId,
    );
  }

  @override
  Override overrideWith(EditorStateWrapper Function() create) {
    return ProviderOverride(
      origin: this,
      override: EditorStateWrapperProvider._internal(
        () => create()..noteId = noteId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        noteId: noteId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EditorStateWrapper, EditorState>
      createElement() {
    return _EditorStateWrapperProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditorStateWrapperProvider && other.noteId == noteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, noteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditorStateWrapperRef
    on AutoDisposeAsyncNotifierProviderRef<EditorState> {
  /// The parameter `noteId` of this provider.
  String get noteId;
}

class _EditorStateWrapperProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EditorStateWrapper,
        EditorState> with EditorStateWrapperRef {
  _EditorStateWrapperProviderElement(super.provider);

  @override
  String get noteId => (origin as EditorStateWrapperProvider).noteId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
