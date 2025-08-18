import 'package:custom_sync_drift_annotations/annotations.dart';
import 'package:drift/drift.dart';
import 'package:note_taking_app/core/database/app_database.dart';
import 'package:uuid/uuid.dart';

part 'categories_table.classsync.dart';

@customSync
class Category extends Table {
  static String get serverTableName => "public.categories";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text().withLength(min: 1, max: 100)();

  // Client-side timestamps (required by sync system)
  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime()
      .clientDefault(() => DateTime.now().toUtc())
      .named('created_at')();
  @JsonKey('updated_at')
  DateTimeColumn get updatedAt => dateTime()
      .clientDefault(() => DateTime.now().toUtc())
      .named('updated_at')();
  @JsonKey('deleted_at')
  DateTimeColumn get deletedAt => dateTime().nullable().named('deleted_at')();

  // Sync control attributes
  @JsonKey('instance_id')
  TextColumn get instanceId => text().nullable().named('instance_id')();
  BoolColumn get isRemote => boolean().withDefault(const Constant(false))();
  @JsonKey('user_id')
  TextColumn get userId => text().named('user_id')();

  @override
  Set<Column> get primaryKey => {id};
}
