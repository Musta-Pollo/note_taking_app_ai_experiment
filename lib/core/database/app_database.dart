import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:note_taking_app/core/database/tables/categories_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:uuid/uuid.dart';

import 'tables/note_editor_data_table.dart';
import 'tables/notes_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Category, Note, Noteeditordata])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        // Add foreign key constraints for proper cascade behavior
        await customStatement('''
          CREATE INDEX idx_note_category_id ON note(category_id);
        ''');

        await customStatement('''
          CREATE INDEX idx_noteeditordata_note_id ON noteeditordata(note_id);
        ''');

        // Enable FTS5 for full-text search
        await customStatement('''
          CREATE VIRTUAL TABLE note_fts USING fts5(
            id UNINDEXED,
            content,
            content='note',
            content_rowid='rowid'
          );
        ''');

        // FTS5 triggers
        await customStatement('''
          CREATE TRIGGER note_fts_insert AFTER INSERT ON note BEGIN
            INSERT INTO note_fts(id, content) VALUES (new.id, new.content);
          END;
        ''');

        await customStatement('''
          CREATE TRIGGER note_fts_update AFTER UPDATE ON note BEGIN
            UPDATE note_fts SET content = new.content WHERE id = new.id;
          END;
        ''');

        await customStatement('''
          CREATE TRIGGER note_fts_delete AFTER DELETE ON note BEGIN
            DELETE FROM note_fts WHERE id = old.id;
          END;
        ''');
      },
    );
  }

  /// Full-text search using FTS5
  Stream<List<NoteData>> searchNotes(String query) {
    if (query.trim().isEmpty) {
      return customSelect(
        '''
        SELECT n.* FROM note n
        INNER JOIN category c ON n.category_id = c.id
        WHERE n.deleted_at IS NULL AND c.deleted_at IS NULL
        ORDER BY n.created_at DESC
        ''',
        readsFrom: {note, category},
      ).map((row) => note.map(row.data)).watch();
    }

    // Use FTS5 when available, otherwise fallback to simple search
    try {
      return customSelect(
        '''
        SELECT n.* FROM note n
        INNER JOIN note_fts fts ON n.id = fts.id
        INNER JOIN category c ON n.category_id = c.id
        WHERE note_fts MATCH ? AND n.deleted_at IS NULL AND c.deleted_at IS NULL
        ORDER BY rank
        ''',
        variables: [Variable.withString(query)],
        readsFrom: {note, category},
      ).map((row) => note.map(row.data)).watch();
    } catch (e) {
      // Fallback to simple text search if FTS5 is not available
      return customSelect(
        '''
        SELECT n.* FROM note n
        INNER JOIN category c ON n.category_id = c.id
        WHERE n.deleted_at IS NULL AND c.deleted_at IS NULL AND n.content LIKE ?
        ORDER BY n.created_at DESC
        ''',
        variables: [Variable.withString('%$query%')],
        readsFrom: {note, category},
      ).map((row) => note.map(row.data)).watch();
    }
  }

  /// Get notes by category with sorting
  Stream<List<NoteData>> getNotesByCategory(String categoryId,
      {SortType sortType = SortType.dateDesc}) {
    var query = select(note)
      ..where((n) => n.categoryId.equals(categoryId) & n.deletedAt.isNull());

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

    return query.watch();
  }

  /// Get all categories for current user
  Stream<List<CategoryData>> getAllCategories(String userId) {
    return (select(category)
          ..where((c) => c.userId.equals(userId) & c.deletedAt.isNull())
          ..orderBy([(c) => OrderingTerm.asc(c.name)]))
        .watch();
  }

  /// Get all notes for current user
  Stream<List<NoteData>> getAllNotes(String userId,
      {SortType sortType = SortType.dateDesc}) {
    var query = select(note)
      ..where((n) => n.userId.equals(userId) & n.deletedAt.isNull());

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

    return query.watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'notes_app_10.db'));

    // sqlite3.tempDirectory = (await getTemporaryDirectory()).path;

    return NativeDatabase.createInBackground(
      file,
      setup: (database) {
        database.execute('PRAGMA foreign_keys = ON');
        database.execute('PRAGMA journal_mode = WAL');
        database.execute('PRAGMA synchronous = NORMAL');
      },
    );
  });
}
