import 'package:custom_sync_drift_annotations/annotations.dart';
import 'package:drift/drift.dart';
import 'package:note_taking_app/core/database/app_database.dart';
import 'package:note_taking_app/core/database/tables/categories_table.dart';
import 'package:uuid/uuid.dart';

part 'notes_table.classsync.dart';

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
class Note extends Table {
  static String get serverTableName => "public.notes";

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get content => text()();
  @JsonKey('category_id')
  TextColumn get categoryId => text()
      .references(Category, #id, onDelete: KeyAction.cascade)
      .named('category_id')();
  @JsonKey('note_type')
  IntColumn get noteType => intEnum<NoteType>().named('note_type')();

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
