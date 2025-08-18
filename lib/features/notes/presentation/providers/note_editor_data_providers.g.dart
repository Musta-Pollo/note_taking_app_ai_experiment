// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_editor_data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$noteEditorDataLocalDataSourceHash() =>
    r'8587045cf6e3f2f8175a9d7c37b1d73c68d36174';

/// NoteEditorData data source provider
///
/// Copied from [noteEditorDataLocalDataSource].
@ProviderFor(noteEditorDataLocalDataSource)
final noteEditorDataLocalDataSourceProvider =
    AutoDisposeProvider<NoteEditorDataLocalDataSource>.internal(
  noteEditorDataLocalDataSource,
  name: r'noteEditorDataLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$noteEditorDataLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NoteEditorDataLocalDataSourceRef
    = AutoDisposeProviderRef<NoteEditorDataLocalDataSource>;
String _$noteEditorDataRepositoryHash() =>
    r'2421ceb1ded558df321dd12a62500b112aecafde';

/// NoteEditorData repository provider
///
/// Copied from [noteEditorDataRepository].
@ProviderFor(noteEditorDataRepository)
final noteEditorDataRepositoryProvider =
    AutoDisposeProvider<NoteEditorDataRepository>.internal(
  noteEditorDataRepository,
  name: r'noteEditorDataRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$noteEditorDataRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NoteEditorDataRepositoryRef
    = AutoDisposeProviderRef<NoteEditorDataRepository>;
String _$editorDataByNoteIdHash() =>
    r'77a8e3de27fc04360e0b68e266d228cc24e47e3f';

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

/// Provider for editor data by note ID
///
/// Copied from [editorDataByNoteId].
@ProviderFor(editorDataByNoteId)
const editorDataByNoteIdProvider = EditorDataByNoteIdFamily();

/// Provider for editor data by note ID
///
/// Copied from [editorDataByNoteId].
class EditorDataByNoteIdFamily
    extends Family<AsyncValue<List<NoteEditorDataEntity>>> {
  /// Provider for editor data by note ID
  ///
  /// Copied from [editorDataByNoteId].
  const EditorDataByNoteIdFamily();

  /// Provider for editor data by note ID
  ///
  /// Copied from [editorDataByNoteId].
  EditorDataByNoteIdProvider call(
    String noteId,
  ) {
    return EditorDataByNoteIdProvider(
      noteId,
    );
  }

  @override
  EditorDataByNoteIdProvider getProviderOverride(
    covariant EditorDataByNoteIdProvider provider,
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
  String? get name => r'editorDataByNoteIdProvider';
}

/// Provider for editor data by note ID
///
/// Copied from [editorDataByNoteId].
class EditorDataByNoteIdProvider
    extends AutoDisposeStreamProvider<List<NoteEditorDataEntity>> {
  /// Provider for editor data by note ID
  ///
  /// Copied from [editorDataByNoteId].
  EditorDataByNoteIdProvider(
    String noteId,
  ) : this._internal(
          (ref) => editorDataByNoteId(
            ref as EditorDataByNoteIdRef,
            noteId,
          ),
          from: editorDataByNoteIdProvider,
          name: r'editorDataByNoteIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editorDataByNoteIdHash,
          dependencies: EditorDataByNoteIdFamily._dependencies,
          allTransitiveDependencies:
              EditorDataByNoteIdFamily._allTransitiveDependencies,
          noteId: noteId,
        );

  EditorDataByNoteIdProvider._internal(
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
    Stream<List<NoteEditorDataEntity>> Function(EditorDataByNoteIdRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditorDataByNoteIdProvider._internal(
        (ref) => create(ref as EditorDataByNoteIdRef),
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
  AutoDisposeStreamProviderElement<List<NoteEditorDataEntity>> createElement() {
    return _EditorDataByNoteIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditorDataByNoteIdProvider && other.noteId == noteId;
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
mixin EditorDataByNoteIdRef
    on AutoDisposeStreamProviderRef<List<NoteEditorDataEntity>> {
  /// The parameter `noteId` of this provider.
  String get noteId;
}

class _EditorDataByNoteIdProviderElement
    extends AutoDisposeStreamProviderElement<List<NoteEditorDataEntity>>
    with EditorDataByNoteIdRef {
  _EditorDataByNoteIdProviderElement(super.provider);

  @override
  String get noteId => (origin as EditorDataByNoteIdProvider).noteId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
