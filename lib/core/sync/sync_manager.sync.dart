// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_manager.dart';

// **************************************************************************
// SyncGenerator
// **************************************************************************

// Sync function
Future<void> _$SyncClassSync(Map<String, dynamic> changes, AppDatabase db) async {
  await Future.wait([
    CategorySyncExtension.sync(changes, db),
    NoteSyncExtension.sync(changes, db),
    NoteeditordataSyncExtension.sync(changes, db),
  ]);
}

// get changes function
Future<Map<String, dynamic>> _$SyncClassGetChanges(DateTime lastSyncedAt, AppDatabase db, String currentInstanceId) async {
final res = await Future.wait([
    CategoryGetChangesExtension.getChanges(lastSyncedAt, db, currentInstanceId),
    NoteGetChangesExtension.getChanges(lastSyncedAt, db, currentInstanceId),
    NoteeditordataGetChangesExtension.getChanges(lastSyncedAt, db, currentInstanceId),
  ]);
return res.fold<Map<String, dynamic>>({}, (prev, element) {
  prev.addAll(element);
  return prev;
});
}

List<String> _$SyncClassSyncedTables() {
  return [
    Category.serverTableName,
    Note.serverTableName,
    Noteeditordata.serverTableName,
  ];
}

// Combined streams function
Stream<List<dynamic>> _$SyncClassCombinedStreams(AppDatabase db) {
  final categoryStream = (db.select(db.category)..where((tbl) => tbl.isRemote.equals(false))).watch();
  final noteStream = (db.select(db.note)..where((tbl) => tbl.isRemote.equals(false))).watch();
  final noteeditordataStream = (db.select(db.noteeditordata)..where((tbl) => tbl.isRemote.equals(false))).watch();

  // Combine N streams
  return Rx.combineLatestList([
    categoryStream,
    noteStream,
    noteeditordataStream,
  ]);
}

extension CategoryRealtimeChannelExtension on RealtimeChannel {
  RealtimeChannel onCategoryChanges(String currentInstanceId, void Function(PostgresChangePayload payload) callback) {
    return this.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: Category.serverTableName.split('.')[0],
      table: Category.serverTableName.split('.')[1],
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.neq,
        column: 'instance_id',
        value: currentInstanceId,
      ),
      callback: callback,
    );
  }
}
extension NoteRealtimeChannelExtension on RealtimeChannel {
  RealtimeChannel onNoteChanges(String currentInstanceId, void Function(PostgresChangePayload payload) callback) {
    return this.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: Note.serverTableName.split('.')[0],
      table: Note.serverTableName.split('.')[1],
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.neq,
        column: 'instance_id',
        value: currentInstanceId,
      ),
      callback: callback,
    );
  }
}
extension NoteeditordataRealtimeChannelExtension on RealtimeChannel {
  RealtimeChannel onNoteeditordataChanges(String currentInstanceId, void Function(PostgresChangePayload payload) callback) {
    return this.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: Noteeditordata.serverTableName.split('.')[0],
      table: Noteeditordata.serverTableName.split('.')[1],
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.neq,
        column: 'instance_id',
        value: currentInstanceId,
      ),
      callback: callback,
    );
  }
}

extension CombinedSyncClassRealtimeChannelExtension on RealtimeChannel {
  RealtimeChannel onAllSyncClassChanges(String currentInstanceId, void Function(PostgresChangePayload payload) callback) {
    return
      this.onCategoryChanges(currentInstanceId, callback).
      onNoteChanges(currentInstanceId, callback).
      onNoteeditordataChanges(currentInstanceId, callback);
  }
}
