# Flutter Notes App with Real-time Sync - Corrected Implementation Guide

## Project Overview

This guide implements a production-ready Flutter notes application with real-time synchronization using the **custom_supabase_drift_doc_sync** plugin. The sync system uses automatic code generation and follows the WatermelonDB protocol.

**⚠️ IMPORTANT**: This CLAUDE.md is a guide - always verify implementation details against the actual source repositories:

- [custom_supabase_drift_doc_sync](https://github.com/Musta-Pollo/custom_supabase_drift_doc_sync)
- [appflowy_editor_sync_plugin](https://github.com/Musta-Pollo/appflowy_editor_sync_plugin)

---

## Dependencies Setup

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3

  # Database & Sync
  drift: ^2.14.1
  sqlite3_flutter_libs: ^0.5.0
  path: ^1.8.3

  # Custom Sync Plugin (git dependency)
  custom_supabase_drift_doc_sync:
    git:
      url: https://github.com/Musta-Pollo/custom_supabase_drift_doc_sync

  # Supabase Integration
  supabase_flutter: ^2.0.0

  # AppFlowy Editor
  appflowy_editor: ^3.1.0
  appflowy_editor_sync_plugin:
    git:
      url: https://github.com/Musta-Pollo/appflowy_editor_sync_plugin

  # UI & Navigation
  auto_route: ^7.8.4
  flutter_login: ^4.2.1
  adaptive_theme: ^3.4.1
  flex_color_scheme: ^7.3.1

  # Domain Models
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  uuid: ^4.2.1
  equatable: ^2.0.5
  shared_preferences: ^2.2.2

dev_dependencies:
  build_runner: ^2.4.7
  drift_dev: ^2.14.1
  riverpod_generator: ^2.3.9
  auto_route_generator: ^7.3.2
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
```

---

## Project Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── router/
│       ├── app_router.dart
│       └── app_router.gr.dart
├── core/
│   ├── database/
│   │   ├── app_database.dart
│   │   └── tables/
│   │       ├── categories_table.dart
│   │       ├── notes_table.dart
│   │       └── note_editor_data_table.dart
│   ├── sync/
│   │   ├── sync_manager.dart
│   │   ├── sync_manager.sync.dart (generated)
│   │   └── sync_service.dart
│   ├── auth/
│   │   ├── auth_service.dart
│   │   └── auth_providers.dart
│   ├── providers/
│   │   └── core_providers.dart
│   └── theme/
│       └── app_theme.dart
├── features/
│   ├── notes/
│   │   ├── data/
│   │   │   ├── repositories/
│   │   │   │   ├── notes_repository_impl.dart
│   │   │   │   └── categories_repository_impl.dart
│   │   │   └── datasources/
│   │   │       ├── notes_local_datasource.dart
│   │   │       └── categories_local_datasource.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── note_entity.dart
│   │   │   │   └── category_entity.dart
│   │   │   └── repositories/
│   │   │       ├── notes_repository.dart
│   │   │       └── categories_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── notes_providers.dart
│   │       │   └── categories_providers.dart
│   │       ├── pages/
│   │       │   └── (UI pages - implement later)
│   │       └── widgets/
└── shared/
    ├── providers/
    └── widgets/
```

---

## Phase 1: Database Foundation (Corrected)

### **Drift Tables with Correct Sync Attributes**

```dart
// lib/core/database/tables/categories_table.dart
import 'package:drift/drift.dart';
import 'package:custom_supabase_drift_doc_sync/custom_supabase_drift_doc_sync.dart';

@customSync
class Categories extends Table {
  static String get serverTableName => "public.categories";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text().withLength(min: 1, max: 100)();

  // Client-side timestamps (required by plugin)
  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now().toUtc())();

  @JsonKey('updated_at')
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now().toUtc())();

  @JsonKey('deleted_at')
  DateTimeColumn get deletedAt => dateTime().nullable()();

  // Sync control attributes
  @JsonKey('instance_id')
  TextColumn get instanceId => text().nullable()();

  BoolColumn get isRemote => boolean().withDefault(const Constant(false))();

  @JsonKey('user_id')
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// lib/core/database/tables/notes_table.dart
import 'package:drift/drift.dart';
import 'package:custom_supabase_drift_doc_sync/custom_supabase_drift_doc_sync.dart';

enum NoteType {
  simple(0),
  full(1);

  const NoteType(this.value);
  final int value;
}

enum SortType {
  dateAsc,
  dateDesc,
  nameAsc,
  nameDesc,
}

@customSync
class Notes extends Table {
  static String get serverTableName => "public.notes";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get content => text()();
  TextColumn get categoryId => text()();
  IntColumn get noteType => intEnum<NoteType>()();

  // Client-side timestamps only
  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now().toUtc())();

  @JsonKey('updated_at')
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now().toUtc())();

  @JsonKey('deleted_at')
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @JsonKey('instance_id')
  TextColumn get instanceId => text().nullable()();

  BoolColumn get isRemote => boolean().withDefault(const Constant(false))();

  @JsonKey('user_id')
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// lib/core/database/tables/note_editor_data_table.dart
import 'package:drift/drift.dart';
import 'package:custom_supabase_drift_doc_sync/custom_supabase_drift_doc_sync.dart';

@customSync
class NoteEditorData extends Table {
  static String get serverTableName => "public.note_editor_data";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get noteId => text()();

  @JsonKey('data_b64')
  TextColumn get dataB64 => text()();

  // Client-side timestamps only
  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now().toUtc())();

  @JsonKey('updated_at')
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now().toUtc())();

  @JsonKey('deleted_at')
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @JsonKey('instance_id')
  TextColumn get instanceId => text().nullable()();

  BoolColumn get isRemote => boolean().withDefault(const Constant(false))();

  @JsonKey('user_id')
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {id};
}
```

### **Database with Foreign Key References**

```dart
// lib/core/database/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

import 'tables/categories_table.dart';
import 'tables/notes_table.dart';
import 'tables/note_editor_data_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Categories, Notes, NoteEditorData])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        // Add foreign key constraints for proper cascade behavior
        await customStatement('''
          CREATE INDEX idx_notes_category_id ON notes(category_id);
        ''');

        await customStatement('''
          CREATE INDEX idx_note_editor_data_note_id ON note_editor_data(note_id);
        ''');

        // Enable FTS5 for full-text search
        await customStatement('''
          CREATE VIRTUAL TABLE notes_fts USING fts5(
            id UNINDEXED,
            content,
            content='notes',
            content_rowid='rowid'
          );
        ''');

        // FTS5 triggers
        await customStatement('''
          CREATE TRIGGER notes_fts_insert AFTER INSERT ON notes BEGIN
            INSERT INTO notes_fts(id, content) VALUES (new.id, new.content);
          END;
        ''');

        await customStatement('''
          CREATE TRIGGER notes_fts_update AFTER UPDATE ON notes BEGIN
            UPDATE notes_fts SET content = new.content WHERE id = new.id;
          END;
        ''');

        await customStatement('''
          CREATE TRIGGER notes_fts_delete AFTER DELETE ON notes BEGIN
            DELETE FROM notes_fts WHERE id = old.id;
          END;
        ''');
      },
    );
  }

  /// Full-text search using FTS5
  Stream<List<Note>> searchNotes(String query) {
    if (query.trim().isEmpty) {
      return select(notes).where((n) => n.deletedAt.isNull()).watch();
    }

    return customSelect(
      '''
      SELECT n.* FROM notes n
      INNER JOIN notes_fts fts ON n.id = fts.id
      WHERE notes_fts MATCH ? AND n.deleted_at IS NULL
      ORDER BY rank
      ''',
      variables: [Variable.withString(query)],
      readsFrom: {notes},
    ).map((row) => Note.fromData(row.data)).watch();
  }

  /// Get notes by category with sorting
  Stream<List<Note>> getNotesByCategory(String categoryId, {SortType sortType = SortType.dateDesc}) {
    var query = select(notes)..where((n) =>
        n.categoryId.equals(categoryId) & n.deletedAt.isNull());

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
    final file = File(p.join(dbFolder.path, 'notes_app.db'));

    sqlite3.tempDirectory = (await getTemporaryDirectory()).path;

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
```

### **Sync Manager with Code Generation**

```dart
// lib/core/sync/sync_manager.dart
import 'package:custom_supabase_drift_doc_sync/custom_supabase_drift_doc_sync.dart';
import '../database/app_database.dart';
import '../database/tables/categories_table.dart';
import '../database/tables/notes_table.dart';
import '../database/tables/note_editor_data_table.dart';

part 'sync_manager.sync.dart';

/// Sync manager using code generation from custom_supabase_drift_doc_sync
/// Tables must be specified IN ORDER OF DEPENDENCIES
/// Categories first, then Notes (depends on Categories), then NoteEditorData (depends on Notes)
@SyncManager(classes: [Categories, Notes, NoteEditorData])
class SyncClass {
  const SyncClass();

  /// Apply server changes to local database
  /// This is automatically generated - handles all sync logic
  Future<void> sync(Map<String, dynamic> changes, AppDatabase db) =>
      _$SyncClassSync(changes, db);

  /// Get local changes that need to be pushed to server
  /// This is automatically generated
  Future<Map<String, dynamic>> getChanges(
    DateTime lastSyncedAt,
    AppDatabase db,
    String currentInstanceId
  ) => _$SyncClassGetChanges(lastSyncedAt, db, currentInstanceId);

  /// Get list of tables that participate in sync
  /// This is automatically generated
  List<String> syncedTables() => _$SyncClassSyncedTables();

  /// Get combined stream of local updates for all synced tables
  /// This is automatically generated - used for triggering sync
  Stream<List<dynamic>> getUpdateStreams(AppDatabase db) =>
      _$SyncClassCombinedStreams(db);
}
```

---

## Phase 2: Domain Layer with Freezed Models

### **Domain Entities with Corrected Attributes**

```dart
// lib/features/notes/domain/entities/category_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';

part 'category_entity.freezed.dart';
part 'category_entity.g.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String id,
    required String name,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    String? instanceId,
    @Default(false) bool isRemote,
  }) = _CategoryEntity;

  /// Create new category for local insertion
  factory CategoryEntity.create({
    required String name,
    required String userId,
  }) {
    final now = DateTime.now().toUtc();
    return CategoryEntity(
      id: const Uuid().v4(),
      name: name,
      userId: userId,
      createdAt: now,
      updatedAt: now,
      isRemote: false, // This is a local change
    );
  }

  /// Create from database record
  factory CategoryEntity.fromDatabase(Category category) {
    return CategoryEntity(
      id: category.id,
      name: category.name,
      userId: category.userId,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
      deletedAt: category.deletedAt,
      instanceId: category.instanceId,
      isRemote: category.isRemote,
    );
  }

  /// Convert to database companion for updates
  CategoriesCompanion toCompanion({bool isUpdate = false}) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      userId: Value(userId),
      createdAt: isUpdate ? Value.absent() : Value(createdAt),
      updatedAt: Value(DateTime.now().toUtc()),
      deletedAt: Value(deletedAt),
      instanceId: Value(instanceId),
      isRemote: const Value(false), // Always false for local changes
    );
  }

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);
}

// lib/features/notes/domain/entities/note_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/tables/notes_table.dart';
import '../../../../core/database/app_database.dart';

part 'note_entity.freezed.dart';
part 'note_entity.g.dart';

@freezed
class NoteEntity with _$NoteEntity {
  const factory NoteEntity({
    required String id,
    required String content,
    required String categoryId,
    required String userId,
    required NoteType noteType,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    String? instanceId,
    @Default(false) bool isRemote,
  }) = _NoteEntity;

  /// Create new simple note
  factory NoteEntity.createSimple({
    required String content,
    required String categoryId,
    required String userId,
  }) {
    final now = DateTime.now().toUtc();
    return NoteEntity(
      id: const Uuid().v4(),
      content: content,
      categoryId: categoryId,
      userId: userId,
      noteType: NoteType.simple,
      createdAt: now,
      updatedAt: now,
      isRemote: false,
    );
  }

  /// Create new full editor note
  factory NoteEntity.createFull({
    required String categoryId,
    required String userId,
    String content = '',
  }) {
    final now = DateTime.now().toUtc();
    return NoteEntity(
      id: const Uuid().v4(),
      content: content,
      categoryId: categoryId,
      userId: userId,
      noteType: NoteType.full,
      createdAt: now,
      updatedAt: now,
      isRemote: false,
    );
  }

  /// Create from database record
  factory NoteEntity.fromDatabase(Note note) {
    return NoteEntity(
      id: note.id,
      content: note.content,
      categoryId: note.categoryId,
      userId: note.userId,
      noteType: note.noteType,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
      deletedAt: note.deletedAt,
      instanceId: note.instanceId,
      isRemote: note.isRemote,
    );
  }

  /// Convert to database companion
  NotesCompanion toCompanion({bool isUpdate = false}) {
    return NotesCompanion(
      id: Value(id),
      content: Value(content),
      categoryId: Value(categoryId),
      userId: Value(userId),
      noteType: Value(noteType),
      createdAt: isUpdate ? Value.absent() : Value(createdAt),
      updatedAt: Value(DateTime.now().toUtc()),
      deletedAt: Value(deletedAt),
      instanceId: Value(instanceId),
      isRemote: const Value(false),
    );
  }

  factory NoteEntity.fromJson(Map<String, dynamic> json) =>
      _$NoteEntityFromJson(json);
}
```

### **Repository Interfaces**

```dart
// lib/features/notes/domain/repositories/categories_repository.dart
import '../entities/category_entity.dart';

abstract class CategoriesRepository {
  Stream<List<CategoryEntity>> getAllCategories();
  Future<CategoryEntity?> getCategoryById(String id);
  Future<CategoryEntity> createCategory(String name);
  Future<CategoryEntity> updateCategory(CategoryEntity category);
  Future<void> deleteCategory(String id);
  Stream<List<CategoryEntity>> searchCategories(String query);
}

// lib/features/notes/domain/repositories/notes_repository.dart
import '../entities/note_entity.dart';
import '../../../../core/database/tables/notes_table.dart';

abstract class NotesRepository {
  Stream<List<NoteEntity>> getAllNotes();
  Stream<List<NoteEntity>> getNotesByCategory(String categoryId, {SortType sortType});
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
```

---

## Phase 3: Simplified Sync Service (Using Plugin's Generated Functions)

```dart
// lib/core/sync/sync_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import '../providers/core_providers.dart';
import 'sync_manager.dart';

part 'sync_service.g.dart';

/// Simplified sync service using plugin's generated functions
/// The plugin handles most of the complex sync logic automatically
@riverpod
class SyncService extends _$SyncService {
  @override
  SyncStatus build() {
    _initialize();
    return const SyncStatus.idle();
  }

  late final AppDatabase _database;
  late final SupabaseClient _supabase;
  late final SyncClass _syncClass;
  late final SharedPreferences _prefs;

  final String _instanceId = const Uuid().v4();
  bool _isSyncing = false;
  bool _isListening = false;

  void _initialize() async {
    _database = ref.read(databaseProvider);
    _supabase = ref.read(supabaseProvider);
    _syncClass = ref.read(syncClassProvider);
    _prefs = await SharedPreferences.getInstance();

    // Start listening when user is authenticated
    ref.listen(currentUserIdProvider, (previous, next) {
      if (next != null && !_isListening) {
        _startListening();
      } else if (next == null && _isListening) {
        _stopListening();
      }
    });
  }

  void _startListening() {
    _isListening = true;

    // Initial sync
    sync();

    // Use plugin's generated function to listen to local changes
    // The plugin automatically provides this stream
    final updateStream = _syncClass.getUpdateStreams(_database);
    updateStream.listen((_) async {
      // Check if there are actual local changes that need syncing
      final localChanges = await _syncClass.getChanges(
        _getLastPulledAt() ?? DateTime(2000),
        _database,
        _instanceId,
      );

      final hasLocalChanges = localChanges.values.any((collection) {
        final col = collection as Map<String, dynamic>;
        return col.values.any((changes) => (changes as List).isNotEmpty);
      });

      if (hasLocalChanges && !_isSyncing) {
        // Debounce sync calls
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (!_isSyncing) sync();
        });
      }
    });

    // Listen to server changes
    _listenToServerChanges();
  }

  void _stopListening() {
    _isListening = false;
    // The plugin and Supabase handle cleanup automatically
  }

  /// Main sync function - simplified using plugin's capabilities
  Future<void> sync() async {
    if (_isSyncing) return;

    _isSyncing = true;
    state = const SyncStatus.syncing();

    try {
      final lastPulledAt = _getLastPulledAt() ?? DateTime(2000);
      final now = DateTime.now();

      // 1. Pull changes from server (using server functions)
      final pullResponse = await _supabase.rpc('pull_changes', params: {
        'collections': _syncClass.syncedTables(),
        'last_pulled_at': lastPulledAt.toUtc().toIso8601String(),
      });

      final changes = pullResponse['changes'] as Map<String, dynamic>;

      // 2. Apply server changes to local database using plugin's generated sync
      await _database.transaction(() async {
        await _syncClass.sync(changes, _database);
      });

      // 3. Get local changes using plugin's generated function
      final localChanges = await _syncClass.getChanges(
        lastPulledAt,
        _database,
        _instanceId,
      );

      // 4. Check if there are local changes to push
      final hasLocalChanges = localChanges.values.any((collection) {
        final col = collection as Map<String, dynamic>;
        return col.values.any((changes) => (changes as List).isNotEmpty);
      });

      if (hasLocalChanges) {
        // Push local changes to server
        final pushResponse = await _supabase.rpc('push_changes', params: {
          '_changes': localChanges,
          'last_pulled_at': now.toIso8601String(),
        });

        final newLastPulledAt = DateTime.parse(pushResponse);
        await _setLastPulledAt(newLastPulledAt);
      } else {
        await _setLastPulledAt(now.subtract(const Duration(minutes: 2)));
      }

      state = SyncStatus.completed(DateTime.now());
    } catch (e, stack) {
      state = SyncStatus.error(e.toString());
      print('Sync error: $e\n$stack');
    } finally {
      _isSyncing = false;
    }
  }

  /// Listen to server changes via Supabase realtime
  /// This triggers sync when changes come from other devices
  void _listenToServerChanges() {
    final channel = _supabase.channel('db-changes');

    // Listen to all synced tables for changes from other instances
    for (final tableName in _syncClass.syncedTables()) {
      final table = tableName.split('.').last; // Remove 'public.' prefix

      channel.onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: table,
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.neq,
          column: 'instance_id',
          value: _instanceId, // Only listen to changes from other instances
        ),
        callback: (payload) {
          // Trigger sync when server changes detected from other devices
          if (!_isSyncing) {
            Future.delayed(const Duration(milliseconds: 500), () => sync());
          }
        },
      );
    }

    channel.subscribe();
  }

  /// Helper methods for managing last sync timestamp
  DateTime? _getLastPulledAt() {
    final timestamp = _prefs.getString('lastPulledAt');
    return timestamp != null ? DateTime.parse(timestamp) : null;
  }

  Future<void> _setLastPulledAt(DateTime timestamp) async {
    await _prefs.setString('lastPulledAt', timestamp.toIso8601String());
  }

  /// Manual sync trigger for UI
  Future<void> forceSync() async {
    await sync();
  }
}

/// Sync status representation
sealed class SyncStatus {
  const SyncStatus();

  const factory SyncStatus.idle() = SyncStatusIdle;
  const factory SyncStatus.syncing() = SyncStatusSyncing;
  const factory SyncStatus.completed(DateTime lastSync) = SyncStatusCompleted;
  const factory SyncStatus.error(String message) = SyncStatusError;
}

class SyncStatusIdle extends SyncStatus {
  const SyncStatusIdle();
}

class SyncStatusSyncing extends SyncStatus {
  const SyncStatusSyncing();
}

class SyncStatusCompleted extends SyncStatus {
  const SyncStatusCompleted(this.lastSync);
  final DateTime lastSync;
}

class SyncStatusError extends SyncStatus {
  const SyncStatusError(this.message);
  final String message;
}
```

---

## Phase 4: Core Providers

```dart
// lib/core/providers/core_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';
import '../auth/auth_providers.dart';
import '../sync/sync_manager.dart';

part 'core_providers.g.dart';

/// Database provider - single instance across the app
@riverpod
AppDatabase database(Ref ref) {
  return AppDatabase();
}

/// Supabase client provider
@riverpod
SupabaseClient supabase(Ref ref) {
  return Supabase.instance.client;
}

/// Current user ID provider
@riverpod
String? currentUserId(Ref ref) {
  return ref.watch(authUserProvider).value?.id;
}

/// Sync class instance
@riverpod
SyncClass syncClass(Ref ref) {
  return const SyncClass();
}
```

---

## Phase 5: Riverpod Providers for Domain Operations

### **Categories Providers**

```dart
// lib/features/notes/presentation/providers/categories_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../../data/repositories/categories_repository_impl.dart';
import '../../data/datasources/categories_local_datasource.dart';
import '../../../../core/providers/core_providers.dart';

part 'categories_providers.g.dart';

/// Categories data source provider
@riverpod
CategoriesLocalDataSource categoriesLocalDataSource(Ref ref) {
  final database = ref.watch(databaseProvider);
  return CategoriesLocalDataSource(database);
}

/// Categories repository provider
@riverpod
CategoriesRepository categoriesRepository(Ref ref) {
  final dataSource = ref.watch(categoriesLocalDataSourceProvider);
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) {
    throw Exception('User not authenticated');
  }

  return CategoriesRepositoryImpl(dataSource, userId);
}

/// Categories notifier for state management
@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  Stream<List<CategoryEntity>> build() {
    final repository = ref.watch(categoriesRepositoryProvider);
    return repository.getAllCategories();
  }

  /// Create new category
  Future<CategoryEntity> createCategory(String name) async {
    final repository = ref.read(categoriesRepositoryProvider);
    return await repository.createCategory(name);
  }

  /// Update existing category
  Future<CategoryEntity> updateCategory(CategoryEntity category) async {
    final repository = ref.read(categoriesRepositoryProvider);
    return await repository.updateCategory(category);
  }

  /// Delete category
  Future<void> deleteCategory(String id) async {
    final repository = ref.read(categoriesRepositoryProvider);
    await repository.deleteCategory(id);
  }

  /// Get category by ID
  Future<CategoryEntity?> getCategoryById(String id) async {
    final repository = ref.read(categoriesRepositoryProvider);
    return await repository.getCategoryById(id);
  }
}

/// Provider for searching categories
@riverpod
Stream<List<CategoryEntity>> searchCategories(Ref ref, String query) {
  final repository = ref.watch(categoriesRepositoryProvider);
  return repository.searchCategories(query);
}
```

### **Notes Providers**

```dart
// lib/features/notes/presentation/providers/notes_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';
import '../../data/repositories/notes_repository_impl.dart';
import '../../data/datasources/notes_local_datasource.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../core/database/tables/notes_table.dart';

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

  if (userId == null) {
    throw Exception('User not authenticated');
  }

  return NotesRepositoryImpl(dataSource, userId);
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

/// Provider for notes by category with sorting
@riverpod
Stream<List<NoteEntity>> notesByCategory(
  Ref ref,
  String categoryId, {
  SortType sortType = SortType.dateDesc,
}) {
  final repository = ref.watch(notesRepositoryProvider);
  return repository.getNotesByCategory(categoryId, sortType: sortType);
}

/// Provider for searching notes
@riverpod
Stream<List<NoteEntity>> searchNotes(Ref ref, String query) {
  final repository = ref.watch(notesRepositoryProvider);
  return repository.searchNotes(query);
}

/// Provider for sorted notes
@riverpod
Stream<List<NoteEntity>> sortedNotes(
  Ref ref, {
  String? categoryId,
  required SortType sortType,
}) {
  final repository = ref.watch(notesRepositoryProvider);
  return repository.getNotesSorted(categoryId: categoryId, sortType: sortType);
}
```

---

## Supabase Database Schema

**Create these tables in your Supabase project (server-side only has server timestamps):**

```sql
-- Categories table with sync support
CREATE TABLE public.categories (
    id UUID NOT NULL,
    name TEXT NOT NULL,
    user_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ,
    server_created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    server_updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    instance_id UUID
);

-- Notes table with sync support
CREATE TABLE public.notes (
    id UUID NOT NULL,
    content TEXT NOT NULL,
    category_id UUID NOT NULL,
    note_type INTEGER NOT NULL,
    user_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ,
    server_created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    server_updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    instance_id UUID
);

-- Note editor data table
CREATE TABLE public.note_editor_data (
    id UUID NOT NULL,
    note_id UUID NOT NULL,
    data_b64 TEXT NOT NULL,
    user_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ,
    server_created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    server_updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    instance_id UUID
);

-- Add primary keys and foreign keys
ALTER TABLE public.categories ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
ALTER TABLE public.notes ADD CONSTRAINT notes_pkey PRIMARY KEY (id);
ALTER TABLE public.note_editor_data ADD CONSTRAINT note_editor_data_pkey PRIMARY KEY (id);

ALTER TABLE public.notes ADD CONSTRAINT notes_category_id_fkey
    FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;
ALTER TABLE public.note_editor_data ADD CONSTRAINT note_editor_data_note_id_fkey
    FOREIGN KEY (note_id) REFERENCES public.notes(id) ON DELETE CASCADE;

-- Enable RLS and create policies
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.note_editor_data ENABLE ROW LEVEL SECURITY;

CREATE POLICY "categories_rls" ON public.categories
    FOR ALL TO authenticated
    USING ((auth.uid() = user_id))
    WITH CHECK ((auth.uid() = user_id));

CREATE POLICY "notes_rls" ON public.notes
    FOR ALL TO authenticated
    USING ((auth.uid() = user_id))
    WITH CHECK ((auth.uid() = user_id));

CREATE POLICY "note_editor_data_rls" ON public.note_editor_data
    FOR ALL TO authenticated
    USING ((auth.uid() = user_id))
    WITH CHECK ((auth.uid() = user_id));
```

**Also add the provided database functions:**

- `push_changes` and helper functions
- `pull_changes` and helper functions
- (Copy from the provided documents)

---

## Code Generation Commands

```bash
# Generate all code generation files
flutter packages pub run build_runner build

# For development with watch mode
flutter packages pub run build_runner watch

# Clean and rebuild if needed
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

---

## Key Corrections Made

1. **Removed Server Timestamps** from Drift tables - these only exist on the server
2. **Simplified Sync Service** - uses plugin's generated `getUpdateStreams()` instead of custom implementation
3. **Proper Sync Protocol** - relies on plugin's code generation for all sync operations
4. **Cleaner Architecture** - less custom code, more use of tested plugin functionality

## What the Plugin Generates Automatically

- `_$SyncClassSync()` - Applies server changes to local DB
- `_$SyncClassGetChanges()` - Gets local changes for server push
- `_$SyncClassSyncedTables()` - List of synced table names
- `_$SyncClassCombinedStreams()` - Stream of local database changes

## Implementation Notes

- **Always verify against source repositories** - this guide may not cover all edge cases
- **Be efficient with tokens** - read only what you need from documentation
- **Test thoroughly** - especially the sync behavior between devices
- **Use proper UTC timestamps** - crucial for sync to work correctly

This corrected implementation provides a solid foundation following the plugin's intended usage patterns.
