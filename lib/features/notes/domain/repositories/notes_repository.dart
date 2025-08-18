import '../../../../core/database/tables/notes_table.dart';
import '../entities/note_entity.dart';

abstract class NotesRepository {
  Stream<List<NoteEntity>> getAllNotes();
  Stream<List<NoteEntity>> getNotesByCategory(String categoryId,
      {SortType sortType});
  Future<NoteEntity?> getNoteById(String id);
  Stream<List<NoteEntity>> searchNotes(String query);
  Future<NoteEntity> createNote({
    required String content,
    required String categoryId,
    required NoteType noteType,
  });
  Future<NoteEntity> updateNote(NoteEntity note);
  Future<void> deleteNote(String id);
  Stream<List<NoteEntity>> getNotesSorted({
    String? categoryId,
    required SortType sortType,
  });
}
