// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_table.dart';

// **************************************************************************
// ClassSyncCodeGenerator
// **************************************************************************

extension CategorySyncExtension on Category {
// Category sync code
static Future<void> sync(Map<String, dynamic> changes, AppDatabase db) async {
   final categoryChanges = changes[Category.serverTableName] as Map<String, dynamic>;
    final categoryInstance = db.category;
   final createdOrUpdated = categoryChanges['created'] + categoryChanges['updated'];
  for (final record in createdOrUpdated) {
     final existingRecord = await (db.select(categoryInstance)
            ..where((tbl) => tbl.id.equals(record['id'])))
          .getSingleOrNull();
      if (existingRecord == null ||
          DateTime.parse(record['updated_at'])
              .isAfter(existingRecord.updatedAt)) {
        await db
            .into(categoryInstance)
           .insertOnConflictUpdate(CategoryData.fromJson((record as Map<String, dynamic>)..addAll({'isRemote': true})));
      }
    }

    // Handle deleted categorys
    final deletedIds = categoryChanges['deleted'] as List<dynamic>;
    if (deletedIds.isNotEmpty) {
      await (db.delete(categoryInstance)
            ..where((tbl) => tbl.id.isIn(deletedIds.map((e) => e.toString()))))
          .go();
    }
  }
}

extension CategoryGetChangesExtension on Category {
// Category getChanges code
static Future<Map<String, Map<String, List<dynamic>>>> getChanges(DateTime lastSyncedAt, AppDatabase database, String currentInstanceId) async {
  final categoryInstance = database.category;
  final created = await (database.select(categoryInstance)
        ..where((tbl) => tbl.createdAt.isBiggerOrEqualValue(lastSyncedAt) & tbl.isRemote.equals(false)))
      .get();
  final updated = await (database.select(categoryInstance)
        ..where((tbl) => tbl.updatedAt.isBiggerOrEqualValue(lastSyncedAt) & tbl.createdAt.isSmallerThanValue(lastSyncedAt) & tbl.isRemote.equals(false)))
      .get();
  final deleted = await (database.select(categoryInstance)
        ..where((tbl) => tbl.deletedAt.isBiggerOrEqualValue(lastSyncedAt) & tbl.isRemote.equals(false)))
      .get();
  return {
    Category.serverTableName: {
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
