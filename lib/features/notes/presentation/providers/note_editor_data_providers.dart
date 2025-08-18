import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/note_editor_data_local_datasource.dart';
import '../../data/repositories/note_editor_data_repository_impl.dart';
import '../../domain/entities/note_editor_data_entity.dart';
import '../../domain/repositories/note_editor_data_repository.dart';

part 'note_editor_data_providers.g.dart';

/// NoteEditorData data source provider
@riverpod
NoteEditorDataLocalDataSource noteEditorDataLocalDataSource(Ref ref) {
  final database = ref.watch(databaseProvider);
  return NoteEditorDataLocalDataSource(database);
}

/// NoteEditorData repository provider
@riverpod
NoteEditorDataRepository noteEditorDataRepository(Ref ref) {
  final dataSource = ref.watch(noteEditorDataLocalDataSourceProvider);
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) {
    throw Exception('User not authenticated');
  }

  return NoteEditorDataRepositoryImpl(dataSource, userId);
}

/// Provider for editor data by note ID
@riverpod
Stream<List<NoteEditorDataEntity>> editorDataByNoteId(Ref ref, String noteId) {
  final repository = ref.watch(noteEditorDataRepositoryProvider);
  return repository.getEditorDataByNoteId(noteId);
}
