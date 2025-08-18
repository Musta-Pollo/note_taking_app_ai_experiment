import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/notes_table.dart';
import '../../domain/entities/note_entity.dart';

class NotesLocalDataSource {
  final AppDatabase _database;

  NotesLocalDataSource(this._database);

  Stream<List<NoteEntity>> getAllNotes(String userId,
      {SortType sortType = SortType.dateDesc}) {
    return _database.getAllNotes(userId, sortType: sortType).map(
        (notes) => notes.map((note) => NoteEntity.fromDatabase(note)).toList());
  }

  Stream<List<NoteEntity>> getNotesByCategory(String categoryId,
      {SortType sortType = SortType.dateDesc}) {
    return _database.getNotesByCategory(categoryId, sortType: sortType).map(
        (notes) => notes.map((note) => NoteEntity.fromDatabase(note)).toList());
  }

  Future<NoteEntity?> getNoteById(String id) async {
    final note = await (_database.select(_database.note)
          ..where((n) => n.id.equals(id) & n.deletedAt.isNull()))
        .getSingleOrNull();

    return note != null ? NoteEntity.fromDatabase(note) : null;
  }

  Stream<List<NoteEntity>> searchNotes(String query) {
    return _database.searchNotes(query).map(
        (notes) => notes.map((note) => NoteEntity.fromDatabase(note)).toList());
  }

  Future<NoteEntity> createNote(NoteEntity note) async {
    await _database.into(_database.note).insert(note.toCompanion());

    final created = await getNoteById(note.id);
    return created!;
  }

  Future<NoteEntity> updateNote(NoteEntity note) async {
    await (_database.update(_database.note)..where((n) => n.id.equals(note.id)))
        .write(note.toCompanion(isUpdate: true));

    final updated = await getNoteById(note.id);
    return updated!;
  }

  Future<void> deleteNote(String id) async {
    // Soft delete
    await (_database.update(_database.note)..where((n) => n.id.equals(id)))
        .write(NoteCompanion(
      deletedAt: Value(DateTime.now().toUtc()),
      updatedAt: Value(DateTime.now().toUtc()),
      isRemote: const Value(false),
    ));
  }

  Stream<List<NoteEntity>> getNotesSorted({
    String? categoryId,
    required SortType sortType,
    required String userId,
  }) {
    var query = _database.select(_database.note)
      ..where((n) => n.userId.equals(userId) & n.deletedAt.isNull());

    if (categoryId != null) {
      query = query..where((n) => n.categoryId.equals(categoryId));
    }

    switch (sortType) {
      case SortType.nameAsc:
        query = query..orderBy([(n) => OrderingTerm.asc(n.content)]);
        break;
      case SortType.nameDesc:
        query = query..orderBy([(n) => OrderingTerm.desc(n.content)]);
        break;
      case SortType.dateAsc:
        query = query..orderBy([(n) => OrderingTerm.asc(n.createdAt)]);
        break;
      case SortType.dateDesc:
        query = query..orderBy([(n) => OrderingTerm.desc(n.createdAt)]);
        break;
    }

    return query.watch().map(
        (notes) => notes.map((note) => NoteEntity.fromDatabase(note)).toList());
  }
}
