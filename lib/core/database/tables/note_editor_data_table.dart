import 'package:custom_sync_drift_annotations/annotations.dart';
import 'package:drift/drift.dart';
import 'package:note_taking_app/core/database/app_database.dart';
import 'package:note_taking_app/core/database/tables/notes_table.dart';
import 'package:uuid/uuid.dart';

part 'note_editor_data_table.classsync.dart';

@customSync
class Noteeditordata extends Table {
  static String get serverTableName => "public.note_editor_data";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  @JsonKey('note_id')
  TextColumn get noteId => text()
      .references(Note, #id, onDelete: KeyAction.cascade)
      .named('note_id')();

  // Store CRDT updates as base64 string for synchronization
  @JsonKey('data_b64')
  TextColumn get dataB64 => text().named('data_b64')();
  // Store device/instance info for conflict resolution
  @JsonKey('device_id')
  TextColumn get deviceId => text().named('device_id').nullable()();

  // Client-side timestamps only
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

  @JsonKey('instance_id')
  TextColumn get instanceId => text().nullable().named('instance_id')();

  BoolColumn get isRemote => boolean().withDefault(const Constant(false))();
  @JsonKey('user_id')
  TextColumn get userId => text().named('user_id')();

  @override
  Set<Column> get primaryKey => {id};
}
