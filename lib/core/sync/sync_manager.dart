import 'package:custom_sync_drift_annotations/annotations.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../database/app_database.dart';
import '../database/tables/categories_table.dart';
import '../database/tables/note_editor_data_table.dart';
import '../database/tables/notes_table.dart';

part 'sync_manager.sync.dart'; // Will be generated

/// Sync manager using code generation from custom_supabase_drift_doc_sync
/// Tables must be specified IN ORDER OF DEPENDENCIES
/// Categories first, then Notes (depends on Categories), then NoteEditorData (depends on Notes)
@SyncManager(classes: [Category, Note, Noteeditordata])
class SyncClass {
  const SyncClass();

  /// Apply server changes to local database
  /// This will be automatically generated - handles all sync logic
  Future<void> sync(Map<String, dynamic> changes, AppDatabase db) async {
    return _$SyncClassSync(changes, db);
  }

  /// Get local changes that need to be pushed to server
  /// This will be automatically generated
  Future<Map<String, dynamic>> getChanges(
      DateTime lastSyncedAt, AppDatabase db, String currentInstanceId) async {
    return _$SyncClassGetChanges(lastSyncedAt, db, currentInstanceId);
  }

  /// Get list of tables that participate in sync
  /// This will be automatically generated
  List<String> syncedTables() {
    return _$SyncClassSyncedTables();
  }

  /// Get combined stream of local updates for all synced tables
  /// This will be automatically generated - used for triggering sync
  Stream<List<dynamic>> getUpdateStreams(AppDatabase db) {
    return _$SyncClassCombinedStreams(db);
  }
}
