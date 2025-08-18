import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_local_datasource.dart';
import '../../../../core/database/tables/notes_table.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource _localDataSource;
  final String _userId;

  NotesRepositoryImpl(this._localDataSource, this._userId);

  @override
  Stream<List<NoteEntity>> getAllNotes() {
    return _localDataSource.getAllNotes(_userId);
  }

  @override
  Stream<List<NoteEntity>> getNotesByCategory(String categoryId, {SortType sortType = SortType.dateDesc}) {
    return _localDataSource.getNotesByCategory(categoryId, sortType: sortType);
  }

  @override
  Future<NoteEntity?> getNoteById(String id) {
    return _localDataSource.getNoteById(id);
  }

  @override
  Stream<List<NoteEntity>> searchNotes(String query) {
    return _localDataSource.searchNotes(query);
  }

  @override
  Future<NoteEntity> createNote({
    required String content,
    required String categoryId,
    required NoteType noteType,
  }) {
    final NoteEntity note;
    
    if (noteType == NoteType.simple) {
      note = NoteEntity.createSimple(
        content: content,
        categoryId: categoryId,
        userId: _userId,
      );
    } else {
      note = NoteEntity.createFull(
        content: content,
        categoryId: categoryId,
        userId: _userId,
      );
    }
    
    return _localDataSource.createNote(note);
  }

  @override
  Future<NoteEntity> updateNote(NoteEntity note) {
    return _localDataSource.updateNote(note);
  }

  @override
  Future<void> deleteNote(String id) {
    return _localDataSource.deleteNote(id);
  }

  @override
  Stream<List<NoteEntity>> getNotesSorted({
    String? categoryId,
    required SortType sortType,
  }) {
    return _localDataSource.getNotesSorted(
      categoryId: categoryId,
      sortType: sortType,
      userId: _userId,
    );
  }
}