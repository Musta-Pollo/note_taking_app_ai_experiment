import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';
import '../../data/repositories/notes_repository_impl.dart';
import '../../data/datasources/notes_local_datasource.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../core/database/tables/notes_table.dart';
import '../../../../shared/constants/k.dart';

part 'notes_providers.g.dart';

/// Notes data source provider
@riverpod
NotesLocalDataSource notesLocalDataSource(Ref ref) {
  final database = ref.watch(databaseProvider);
  return NotesLocalDataSource(database);
}

/// Notes repository provider
@riverpod
NotesRepository notesRepository(Ref ref) {
  final dataSource = ref.watch(notesLocalDataSourceProvider);
  final userId = ref.watch(currentUserIdProvider);

  // Use offline mode when no user ID (not authenticated)
  final effectiveUserId = userId ?? K.offlineUserId;

  return NotesRepositoryImpl(dataSource, effectiveUserId);
}

/// Main notes notifier
@riverpod
class NotesNotifier extends _$NotesNotifier {
  @override
  Stream<List<NoteEntity>> build() {
    final repository = ref.watch(notesRepositoryProvider);
    return repository.getAllNotes();
  }

  /// Create new simple note
  Future<NoteEntity> createSimpleNote({
    required String content,
    required String categoryId,
  }) async {
    final repository = ref.read(notesRepositoryProvider);
    return await repository.createNote(
      content: content,
      categoryId: categoryId,
      noteType: NoteType.simple,
    );
  }

  /// Create new full editor note
  Future<NoteEntity> createFullNote({
    required String categoryId,
    String content = '',
  }) async {
    final repository = ref.read(notesRepositoryProvider);
    return await repository.createNote(
      content: content,
      categoryId: categoryId,
      noteType: NoteType.full,
    );
  }

  /// Update existing note
  Future<NoteEntity> updateNote(NoteEntity note) async {
    final repository = ref.read(notesRepositoryProvider);
    return await repository.updateNote(note);
  }

  /// Delete note
  Future<void> deleteNote(String id) async {
    final repository = ref.read(notesRepositoryProvider);
    await repository.deleteNote(id);
  }

  /// Get note by ID
  Future<NoteEntity?> getNoteById(String id) async {
    final repository = ref.read(notesRepositoryProvider);
    return await repository.getNoteById(id);
  }
}

/// Provider for searching notes
@riverpod
Stream<List<NoteEntity>> searchNotes(Ref ref, String query) {
  final repository = ref.watch(notesRepositoryProvider);
  return repository.searchNotes(query);
}

/// Provider for sorted notes (can filter by category when categoryId is provided)
@riverpod
Stream<List<NoteEntity>> sortedNotes(
  Ref ref, {
  String? categoryId,
  SortType sortType = SortType.dateDesc,
}) {
  final repository = ref.watch(notesRepositoryProvider);
  return repository.getNotesSorted(categoryId: categoryId, sortType: sortType);
}