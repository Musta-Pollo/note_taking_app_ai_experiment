// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes_table.dart';

// **************************************************************************
// ClassSyncCodeGenerator
// **************************************************************************

extension NoteSyncExtension on Note {
// Note sync code
static Future<void> sync(Map<String, dynamic> changes, AppDatabase db) async {
   final noteChanges = changes[Note.serverTableName] as Map<String, dynamic>;
    final noteInstance = db.note;
   final createdOrUpdated = noteChanges['created'] + noteChanges['updated'];
  for (final record in createdOrUpdated) {
     final existingRecord = await (db.select(noteInstance)
            ..where((tbl) => tbl.id.equals(record['id'])))
          .getSingleOrNull();
      if (existingRecord == null ||
          DateTime.parse(record['updated_at'])
              .isAfter(existingRecord.updatedAt)) {
        await db
            .into(noteInstance)
           .insertOnConflictUpdate(NoteData.fromJson((record as Map<String, dynamic>)..addAll({'isRemote': true})));
      }
    }

    // Handle deleted notes
    final deletedIds = noteChanges['deleted'] as List<dynamic>;
    if (deletedIds.isNotEmpty) {
      await (db.delete(noteInstance)
            ..where((tbl) => tbl.id.isIn(deletedIds.map((e) => e.toString()))))
          .go();
    }
  }
}

extension NoteGetChangesExtension on Note {
// Note getChanges code
static Future<Map<String, Map<String, List<dynamic>>>> getChanges(DateTime lastSyncedAt, AppDatabase database, String currentInstanceId) async {
  final noteInstance = database.note;
  final created = await (database.select(noteInstance)
        ..where((tbl) => tbl.createdAt.isBiggerOrEqualValue(lastSyncedAt) & tbl.isRemote.equals(false)))
      .get();
  final updated = await (database.select(noteInstance)
        ..where((tbl) => tbl.updatedAt.isBiggerOrEqualValue(lastSyncedAt) & tbl.createdAt.isSmallerThanValue(lastSyncedAt) & tbl.isRemote.equals(false)))
      .get();
  final deleted = await (database.select(noteInstance)
        ..where((tbl) => tbl.deletedAt.isBiggerOrEqualValue(lastSyncedAt) & tbl.isRemote.equals(false)))
      .get();
  return {
    Note.serverTableName: {
      'created': created.map((e) => e.toJson()..remove('isRemote')..addAll({
        'instance_id': currentInstanceId,
      })).toList(),
      'updated': updated.map((e) => e.toJson()..remove('isRemote')..addAll({
        'instance_id': currentInstanceId,
      })).toList(),
      'deleted': deleted.map((e) => e.id).toList(),
    }
  };
}
}
