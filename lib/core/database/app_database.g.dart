// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoryTable extends Category
    with TableInfo<$CategoryTable, CategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _instanceIdMeta =
      const VerificationMeta('instanceId');
  @override
  late final GeneratedColumn<String> instanceId = GeneratedColumn<String>(
      'instance_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isRemoteMeta =
      const VerificationMeta('isRemote');
  @override
  late final GeneratedColumn<bool> isRemote = GeneratedColumn<bool>(
      'is_remote', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_remote" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, createdAt, updatedAt, deletedAt, instanceId, isRemote, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('instance_id')) {
      context.handle(
          _instanceIdMeta,
          instanceId.isAcceptableOrUnknown(
              data['instance_id']!, _instanceIdMeta));
    }
    if (data.containsKey('is_remote')) {
      context.handle(_isRemoteMeta,
          isRemote.isAcceptableOrUnknown(data['is_remote']!, _isRemoteMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      instanceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instance_id']),
      isRemote: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_remote'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $CategoryTable createAlias(String alias) {
    return $CategoryTable(attachedDatabase, alias);
  }
}

class CategoryData extends DataClass implements Insertable<CategoryData> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? instanceId;
  final bool isRemote;
  final String userId;
  const CategoryData(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.instanceId,
      required this.isRemote,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || instanceId != null) {
      map['instance_id'] = Variable<String>(instanceId);
    }
    map['is_remote'] = Variable<bool>(isRemote);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  CategoryCompanion toCompanion(bool nullToAbsent) {
    return CategoryCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      instanceId: instanceId == null && nullToAbsent
          ? const Value.absent()
          : Value(instanceId),
      isRemote: Value(isRemote),
      userId: Value(userId),
    );
  }

  factory CategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
      instanceId: serializer.fromJson<String?>(json['instance_id']),
      isRemote: serializer.fromJson<bool>(json['isRemote']),
      userId: serializer.fromJson<String>(json['user_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
      'instance_id': serializer.toJson<String?>(instanceId),
      'isRemote': serializer.toJson<bool>(isRemote),
      'user_id': serializer.toJson<String>(userId),
    };
  }

  CategoryData copyWith(
          {String? id,
          String? name,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          Value<String?> instanceId = const Value.absent(),
          bool? isRemote,
          String? userId}) =>
      CategoryData(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        instanceId: instanceId.present ? instanceId.value : this.instanceId,
        isRemote: isRemote ?? this.isRemote,
        userId: userId ?? this.userId,
      );
  CategoryData copyWithCompanion(CategoryCompanion data) {
    return CategoryData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      instanceId:
          data.instanceId.present ? data.instanceId.value : this.instanceId,
      isRemote: data.isRemote.present ? data.isRemote.value : this.isRemote,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('instanceId: $instanceId, ')
          ..write('isRemote: $isRemote, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, createdAt, updatedAt, deletedAt, instanceId, isRemote, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.instanceId == this.instanceId &&
          other.isRemote == this.isRemote &&
          other.userId == this.userId);
}

class CategoryCompanion extends UpdateCompanion<CategoryData> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> instanceId;
  final Value<bool> isRemote;
  final Value<String> userId;
  final Value<int> rowid;
  const CategoryCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.instanceId = const Value.absent(),
    this.isRemote = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.instanceId = const Value.absent(),
    this.isRemote = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        userId = Value(userId);
  static Insertable<CategoryData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? instanceId,
    Expression<bool>? isRemote,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (instanceId != null) 'instance_id': instanceId,
      if (isRemote != null) 'is_remote': isRemote,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String?>? instanceId,
      Value<bool>? isRemote,
      Value<String>? userId,
      Value<int>? rowid}) {
    return CategoryCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      instanceId: instanceId ?? this.instanceId,
      isRemote: isRemote ?? this.isRemote,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (instanceId.present) {
      map['instance_id'] = Variable<String>(instanceId.value);
    }
    if (isRemote.present) {
      map['is_remote'] = Variable<bool>(isRemote.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('instanceId: $instanceId, ')
          ..write('isRemote: $isRemote, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NoteTable extends Note with TableInfo<$NoteTable, NoteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES category (id) ON DELETE CASCADE'));
  @override
  late final GeneratedColumnWithTypeConverter<NoteType, int> noteType =
      GeneratedColumn<int>('note_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<NoteType>($NoteTable.$converternoteType);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _instanceIdMeta =
      const VerificationMeta('instanceId');
  @override
  late final GeneratedColumn<String> instanceId = GeneratedColumn<String>(
      'instance_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isRemoteMeta =
      const VerificationMeta('isRemote');
  @override
  late final GeneratedColumn<bool> isRemote = GeneratedColumn<bool>(
      'is_remote', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_remote" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        content,
        categoryId,
        noteType,
        createdAt,
        updatedAt,
        deletedAt,
        instanceId,
        isRemote,
        userId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note';
  @override
  VerificationContext validateIntegrity(Insertable<NoteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('instance_id')) {
      context.handle(
          _instanceIdMeta,
          instanceId.isAcceptableOrUnknown(
              data['instance_id']!, _instanceIdMeta));
    }
    if (data.containsKey('is_remote')) {
      context.handle(_isRemoteMeta,
          isRemote.isAcceptableOrUnknown(data['is_remote']!, _isRemoteMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      noteType: $NoteTable.$converternoteType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}note_type'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      instanceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instance_id']),
      isRemote: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_remote'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $NoteTable createAlias(String alias) {
    return $NoteTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<NoteType, int, int> $converternoteType =
      const EnumIndexConverter<NoteType>(NoteType.values);
}

class NoteData extends DataClass implements Insertable<NoteData> {
  final String id;
  final String content;
  final String categoryId;
  final NoteType noteType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? instanceId;
  final bool isRemote;
  final String userId;
  const NoteData(
      {required this.id,
      required this.content,
      required this.categoryId,
      required this.noteType,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.instanceId,
      required this.isRemote,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['content'] = Variable<String>(content);
    map['category_id'] = Variable<String>(categoryId);
    {
      map['note_type'] =
          Variable<int>($NoteTable.$converternoteType.toSql(noteType));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || instanceId != null) {
      map['instance_id'] = Variable<String>(instanceId);
    }
    map['is_remote'] = Variable<bool>(isRemote);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  NoteCompanion toCompanion(bool nullToAbsent) {
    return NoteCompanion(
      id: Value(id),
      content: Value(content),
      categoryId: Value(categoryId),
      noteType: Value(noteType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      instanceId: instanceId == null && nullToAbsent
          ? const Value.absent()
          : Value(instanceId),
      isRemote: Value(isRemote),
      userId: Value(userId),
    );
  }

  factory NoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteData(
      id: serializer.fromJson<String>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      categoryId: serializer.fromJson<String>(json['category_id']),
      noteType: $NoteTable.$converternoteType
          .fromJson(serializer.fromJson<int>(json['note_type'])),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
      instanceId: serializer.fromJson<String?>(json['instance_id']),
      isRemote: serializer.fromJson<bool>(json['isRemote']),
      userId: serializer.fromJson<String>(json['user_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'content': serializer.toJson<String>(content),
      'category_id': serializer.toJson<String>(categoryId),
      'note_type': serializer
          .toJson<int>($NoteTable.$converternoteType.toJson(noteType)),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
      'instance_id': serializer.toJson<String?>(instanceId),
      'isRemote': serializer.toJson<bool>(isRemote),
      'user_id': serializer.toJson<String>(userId),
    };
  }

  NoteData copyWith(
          {String? id,
          String? content,
          String? categoryId,
          NoteType? noteType,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          Value<String?> instanceId = const Value.absent(),
          bool? isRemote,
          String? userId}) =>
      NoteData(
        id: id ?? this.id,
        content: content ?? this.content,
        categoryId: categoryId ?? this.categoryId,
        noteType: noteType ?? this.noteType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        instanceId: instanceId.present ? instanceId.value : this.instanceId,
        isRemote: isRemote ?? this.isRemote,
        userId: userId ?? this.userId,
      );
  NoteData copyWithCompanion(NoteCompanion data) {
    return NoteData(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      noteType: data.noteType.present ? data.noteType.value : this.noteType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      instanceId:
          data.instanceId.present ? data.instanceId.value : this.instanceId,
      isRemote: data.isRemote.present ? data.isRemote.value : this.isRemote,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('categoryId: $categoryId, ')
          ..write('noteType: $noteType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('instanceId: $instanceId, ')
          ..write('isRemote: $isRemote, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, categoryId, noteType, createdAt,
      updatedAt, deletedAt, instanceId, isRemote, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteData &&
          other.id == this.id &&
          other.content == this.content &&
          other.categoryId == this.categoryId &&
          other.noteType == this.noteType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.instanceId == this.instanceId &&
          other.isRemote == this.isRemote &&
          other.userId == this.userId);
}

class NoteCompanion extends UpdateCompanion<NoteData> {
  final Value<String> id;
  final Value<String> content;
  final Value<String> categoryId;
  final Value<NoteType> noteType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> instanceId;
  final Value<bool> isRemote;
  final Value<String> userId;
  final Value<int> rowid;
  const NoteCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.noteType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.instanceId = const Value.absent(),
    this.isRemote = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NoteCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required String categoryId,
    required NoteType noteType,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.instanceId = const Value.absent(),
    this.isRemote = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : content = Value(content),
        categoryId = Value(categoryId),
        noteType = Value(noteType),
        userId = Value(userId);
  static Insertable<NoteData> custom({
    Expression<String>? id,
    Expression<String>? content,
    Expression<String>? categoryId,
    Expression<int>? noteType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? instanceId,
    Expression<bool>? isRemote,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (categoryId != null) 'category_id': categoryId,
      if (noteType != null) 'note_type': noteType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (instanceId != null) 'instance_id': instanceId,
      if (isRemote != null) 'is_remote': isRemote,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NoteCompanion copyWith(
      {Value<String>? id,
      Value<String>? content,
      Value<String>? categoryId,
      Value<NoteType>? noteType,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String?>? instanceId,
      Value<bool>? isRemote,
      Value<String>? userId,
      Value<int>? rowid}) {
    return NoteCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      categoryId: categoryId ?? this.categoryId,
      noteType: noteType ?? this.noteType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      instanceId: instanceId ?? this.instanceId,
      isRemote: isRemote ?? this.isRemote,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (noteType.present) {
      map['note_type'] =
          Variable<int>($NoteTable.$converternoteType.toSql(noteType.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (instanceId.present) {
      map['instance_id'] = Variable<String>(instanceId.value);
    }
    if (isRemote.present) {
      map['is_remote'] = Variable<bool>(isRemote.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('categoryId: $categoryId, ')
          ..write('noteType: $noteType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('instanceId: $instanceId, ')
          ..write('isRemote: $isRemote, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NoteeditordataTable extends Noteeditordata
    with TableInfo<$NoteeditordataTable, NoteeditordataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteeditordataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
      'note_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES note (id) ON DELETE CASCADE'));
  static const VerificationMeta _dataB64Meta =
      const VerificationMeta('dataB64');
  @override
  late final GeneratedColumn<String> dataB64 = GeneratedColumn<String>(
      'data_b64', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _instanceIdMeta =
      const VerificationMeta('instanceId');
  @override
  late final GeneratedColumn<String> instanceId = GeneratedColumn<String>(
      'instance_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isRemoteMeta =
      const VerificationMeta('isRemote');
  @override
  late final GeneratedColumn<bool> isRemote = GeneratedColumn<bool>(
      'is_remote', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_remote" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        noteId,
        dataB64,
        deviceId,
        createdAt,
        updatedAt,
        deletedAt,
        instanceId,
        isRemote,
        userId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'noteeditordata';
  @override
  VerificationContext validateIntegrity(Insertable<NoteeditordataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('data_b64')) {
      context.handle(_dataB64Meta,
          dataB64.isAcceptableOrUnknown(data['data_b64']!, _dataB64Meta));
    } else if (isInserting) {
      context.missing(_dataB64Meta);
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('instance_id')) {
      context.handle(
          _instanceIdMeta,
          instanceId.isAcceptableOrUnknown(
              data['instance_id']!, _instanceIdMeta));
    }
    if (data.containsKey('is_remote')) {
      context.handle(_isRemoteMeta,
          isRemote.isAcceptableOrUnknown(data['is_remote']!, _isRemoteMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteeditordataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteeditordataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_id'])!,
      dataB64: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data_b64'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      instanceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instance_id']),
      isRemote: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_remote'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $NoteeditordataTable createAlias(String alias) {
    return $NoteeditordataTable(attachedDatabase, alias);
  }
}

class NoteeditordataData extends DataClass
    implements Insertable<NoteeditordataData> {
  final String id;
  final String noteId;
  final String dataB64;
  final String? deviceId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? instanceId;
  final bool isRemote;
  final String userId;
  const NoteeditordataData(
      {required this.id,
      required this.noteId,
      required this.dataB64,
      this.deviceId,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.instanceId,
      required this.isRemote,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['note_id'] = Variable<String>(noteId);
    map['data_b64'] = Variable<String>(dataB64);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || instanceId != null) {
      map['instance_id'] = Variable<String>(instanceId);
    }
    map['is_remote'] = Variable<bool>(isRemote);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  NoteeditordataCompanion toCompanion(bool nullToAbsent) {
    return NoteeditordataCompanion(
      id: Value(id),
      noteId: Value(noteId),
      dataB64: Value(dataB64),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      instanceId: instanceId == null && nullToAbsent
          ? const Value.absent()
          : Value(instanceId),
      isRemote: Value(isRemote),
      userId: Value(userId),
    );
  }

  factory NoteeditordataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteeditordataData(
      id: serializer.fromJson<String>(json['id']),
      noteId: serializer.fromJson<String>(json['note_id']),
      dataB64: serializer.fromJson<String>(json['data_b64']),
      deviceId: serializer.fromJson<String?>(json['device_id']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
      instanceId: serializer.fromJson<String?>(json['instance_id']),
      isRemote: serializer.fromJson<bool>(json['isRemote']),
      userId: serializer.fromJson<String>(json['user_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'note_id': serializer.toJson<String>(noteId),
      'data_b64': serializer.toJson<String>(dataB64),
      'device_id': serializer.toJson<String?>(deviceId),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
      'instance_id': serializer.toJson<String?>(instanceId),
      'isRemote': serializer.toJson<bool>(isRemote),
      'user_id': serializer.toJson<String>(userId),
    };
  }

  NoteeditordataData copyWith(
          {String? id,
          String? noteId,
          String? dataB64,
          Value<String?> deviceId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          Value<String?> instanceId = const Value.absent(),
          bool? isRemote,
          String? userId}) =>
      NoteeditordataData(
        id: id ?? this.id,
        noteId: noteId ?? this.noteId,
        dataB64: dataB64 ?? this.dataB64,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        instanceId: instanceId.present ? instanceId.value : this.instanceId,
        isRemote: isRemote ?? this.isRemote,
        userId: userId ?? this.userId,
      );
  NoteeditordataData copyWithCompanion(NoteeditordataCompanion data) {
    return NoteeditordataData(
      id: data.id.present ? data.id.value : this.id,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      dataB64: data.dataB64.present ? data.dataB64.value : this.dataB64,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      instanceId:
          data.instanceId.present ? data.instanceId.value : this.instanceId,
      isRemote: data.isRemote.present ? data.isRemote.value : this.isRemote,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteeditordataData(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('dataB64: $dataB64, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('instanceId: $instanceId, ')
          ..write('isRemote: $isRemote, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, noteId, dataB64, deviceId, createdAt,
      updatedAt, deletedAt, instanceId, isRemote, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteeditordataData &&
          other.id == this.id &&
          other.noteId == this.noteId &&
          other.dataB64 == this.dataB64 &&
          other.deviceId == this.deviceId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.instanceId == this.instanceId &&
          other.isRemote == this.isRemote &&
          other.userId == this.userId);
}

class NoteeditordataCompanion extends UpdateCompanion<NoteeditordataData> {
  final Value<String> id;
  final Value<String> noteId;
  final Value<String> dataB64;
  final Value<String?> deviceId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> instanceId;
  final Value<bool> isRemote;
  final Value<String> userId;
  final Value<int> rowid;
  const NoteeditordataCompanion({
    this.id = const Value.absent(),
    this.noteId = const Value.absent(),
    this.dataB64 = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.instanceId = const Value.absent(),
    this.isRemote = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NoteeditordataCompanion.insert({
    this.id = const Value.absent(),
    required String noteId,
    required String dataB64,
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.instanceId = const Value.absent(),
    this.isRemote = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : noteId = Value(noteId),
        dataB64 = Value(dataB64),
        userId = Value(userId);
  static Insertable<NoteeditordataData> custom({
    Expression<String>? id,
    Expression<String>? noteId,
    Expression<String>? dataB64,
    Expression<String>? deviceId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? instanceId,
    Expression<bool>? isRemote,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteId != null) 'note_id': noteId,
      if (dataB64 != null) 'data_b64': dataB64,
      if (deviceId != null) 'device_id': deviceId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (instanceId != null) 'instance_id': instanceId,
      if (isRemote != null) 'is_remote': isRemote,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NoteeditordataCompanion copyWith(
      {Value<String>? id,
      Value<String>? noteId,
      Value<String>? dataB64,
      Value<String?>? deviceId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String?>? instanceId,
      Value<bool>? isRemote,
      Value<String>? userId,
      Value<int>? rowid}) {
    return NoteeditordataCompanion(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      dataB64: dataB64 ?? this.dataB64,
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      instanceId: instanceId ?? this.instanceId,
      isRemote: isRemote ?? this.isRemote,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value);
    }
    if (dataB64.present) {
      map['data_b64'] = Variable<String>(dataB64.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (instanceId.present) {
      map['instance_id'] = Variable<String>(instanceId.value);
    }
    if (isRemote.present) {
      map['is_remote'] = Variable<bool>(isRemote.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteeditordataCompanion(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('dataB64: $dataB64, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('instanceId: $instanceId, ')
          ..write('isRemote: $isRemote, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoryTable category = $CategoryTable(this);
  late final $NoteTable note = $NoteTable(this);
  late final $NoteeditordataTable noteeditordata = $NoteeditordataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [category, note, noteeditordata];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('category',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('note', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('note',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('noteeditordata', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CategoryTableCreateCompanionBuilder = CategoryCompanion Function({
  Value<String> id,
  required String name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> instanceId,
  Value<bool> isRemote,
  required String userId,
  Value<int> rowid,
});
typedef $$CategoryTableUpdateCompanionBuilder = CategoryCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> instanceId,
  Value<bool> isRemote,
  Value<String> userId,
  Value<int> rowid,
});

final class $$CategoryTableReferences
    extends BaseReferences<_$AppDatabase, $CategoryTable, CategoryData> {
  $$CategoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$NoteTable, List<NoteData>> _noteRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.note,
          aliasName: $_aliasNameGenerator(db.category.id, db.note.categoryId));

  $$NoteTableProcessedTableManager get noteRefs {
    final manager = $$NoteTableTableManager($_db, $_db.note)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_noteRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoryTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRemote => $composableBuilder(
      column: $table.isRemote, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  Expression<bool> noteRefs(
      Expression<bool> Function($$NoteTableFilterComposer f) f) {
    final $$NoteTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.note,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NoteTableFilterComposer(
              $db: $db,
              $table: $db.note,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoryTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRemote => $composableBuilder(
      column: $table.isRemote, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$CategoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => column);

  GeneratedColumn<bool> get isRemote =>
      $composableBuilder(column: $table.isRemote, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  Expression<T> noteRefs<T extends Object>(
      Expression<T> Function($$NoteTableAnnotationComposer a) f) {
    final $$NoteTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.note,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NoteTableAnnotationComposer(
              $db: $db,
              $table: $db.note,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoryTable,
    CategoryData,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (CategoryData, $$CategoryTableReferences),
    CategoryData,
    PrefetchHooks Function({bool noteRefs})> {
  $$CategoryTableTableManager(_$AppDatabase db, $CategoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> instanceId = const Value.absent(),
            Value<bool> isRemote = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoryCompanion(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            instanceId: instanceId,
            isRemote: isRemote,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String name,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> instanceId = const Value.absent(),
            Value<bool> isRemote = const Value.absent(),
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoryCompanion.insert(
            id: id,
            name: name,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            instanceId: instanceId,
            isRemote: isRemote,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CategoryTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({noteRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (noteRefs) db.note],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (noteRefs)
                    await $_getPrefetchedData<CategoryData, $CategoryTable,
                            NoteData>(
                        currentTable: table,
                        referencedTable:
                            $$CategoryTableReferences._noteRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoryTableReferences(db, table, p0).noteRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoryTable,
    CategoryData,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (CategoryData, $$CategoryTableReferences),
    CategoryData,
    PrefetchHooks Function({bool noteRefs})>;
typedef $$NoteTableCreateCompanionBuilder = NoteCompanion Function({
  Value<String> id,
  required String content,
  required String categoryId,
  required NoteType noteType,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> instanceId,
  Value<bool> isRemote,
  required String userId,
  Value<int> rowid,
});
typedef $$NoteTableUpdateCompanionBuilder = NoteCompanion Function({
  Value<String> id,
  Value<String> content,
  Value<String> categoryId,
  Value<NoteType> noteType,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> instanceId,
  Value<bool> isRemote,
  Value<String> userId,
  Value<int> rowid,
});

final class $$NoteTableReferences
    extends BaseReferences<_$AppDatabase, $NoteTable, NoteData> {
  $$NoteTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoryTable _categoryIdTable(_$AppDatabase db) => db.category
      .createAlias($_aliasNameGenerator(db.note.categoryId, db.category.id));

  $$CategoryTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoryTableTableManager($_db, $_db.category)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$NoteeditordataTable, List<NoteeditordataData>>
      _noteeditordataRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.noteeditordata,
              aliasName:
                  $_aliasNameGenerator(db.note.id, db.noteeditordata.noteId));

  $$NoteeditordataTableProcessedTableManager get noteeditordataRefs {
    final manager = $$NoteeditordataTableTableManager($_db, $_db.noteeditordata)
        .filter((f) => f.noteId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_noteeditordataRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$NoteTableFilterComposer extends Composer<_$AppDatabase, $NoteTable> {
  $$NoteTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<NoteType, NoteType, int> get noteType =>
      $composableBuilder(
          column: $table.noteType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRemote => $composableBuilder(
      column: $table.isRemote, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  $$CategoryTableFilterComposer get categoryId {
    final $$CategoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableFilterComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> noteeditordataRefs(
      Expression<bool> Function($$NoteeditordataTableFilterComposer f) f) {
    final $$NoteeditordataTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.noteeditordata,
        getReferencedColumn: (t) => t.noteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NoteeditordataTableFilterComposer(
              $db: $db,
              $table: $db.noteeditordata,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$NoteTableOrderingComposer extends Composer<_$AppDatabase, $NoteTable> {
  $$NoteTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get noteType => $composableBuilder(
      column: $table.noteType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRemote => $composableBuilder(
      column: $table.isRemote, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  $$CategoryTableOrderingComposer get categoryId {
    final $$CategoryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableOrderingComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NoteTableAnnotationComposer
    extends Composer<_$AppDatabase, $NoteTable> {
  $$NoteTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NoteType, int> get noteType =>
      $composableBuilder(column: $table.noteType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => column);

  GeneratedColumn<bool> get isRemote =>
      $composableBuilder(column: $table.isRemote, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  $$CategoryTableAnnotationComposer get categoryId {
    final $$CategoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableAnnotationComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> noteeditordataRefs<T extends Object>(
      Expression<T> Function($$NoteeditordataTableAnnotationComposer a) f) {
    final $$NoteeditordataTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.noteeditordata,
        getReferencedColumn: (t) => t.noteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NoteeditordataTableAnnotationComposer(
              $db: $db,
              $table: $db.noteeditordata,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$NoteTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NoteTable,
    NoteData,
    $$NoteTableFilterComposer,
    $$NoteTableOrderingComposer,
    $$NoteTableAnnotationComposer,
    $$NoteTableCreateCompanionBuilder,
    $$NoteTableUpdateCompanionBuilder,
    (NoteData, $$NoteTableReferences),
    NoteData,
    PrefetchHooks Function({bool categoryId, bool noteeditordataRefs})> {
  $$NoteTableTableManager(_$AppDatabase db, $NoteTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NoteTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NoteTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NoteTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<NoteType> noteType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> instanceId = const Value.absent(),
            Value<bool> isRemote = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteCompanion(
            id: id,
            content: content,
            categoryId: categoryId,
            noteType: noteType,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            instanceId: instanceId,
            isRemote: isRemote,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String content,
            required String categoryId,
            required NoteType noteType,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> instanceId = const Value.absent(),
            Value<bool> isRemote = const Value.absent(),
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteCompanion.insert(
            id: id,
            content: content,
            categoryId: categoryId,
            noteType: noteType,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            instanceId: instanceId,
            isRemote: isRemote,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$NoteTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {categoryId = false, noteeditordataRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (noteeditordataRefs) db.noteeditordata
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable: $$NoteTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$NoteTableReferences._categoryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (noteeditordataRefs)
                    await $_getPrefetchedData<NoteData, $NoteTable,
                            NoteeditordataData>(
                        currentTable: table,
                        referencedTable:
                            $$NoteTableReferences._noteeditordataRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$NoteTableReferences(db, table, p0)
                                .noteeditordataRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.noteId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$NoteTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NoteTable,
    NoteData,
    $$NoteTableFilterComposer,
    $$NoteTableOrderingComposer,
    $$NoteTableAnnotationComposer,
    $$NoteTableCreateCompanionBuilder,
    $$NoteTableUpdateCompanionBuilder,
    (NoteData, $$NoteTableReferences),
    NoteData,
    PrefetchHooks Function({bool categoryId, bool noteeditordataRefs})>;
typedef $$NoteeditordataTableCreateCompanionBuilder = NoteeditordataCompanion
    Function({
  Value<String> id,
  required String noteId,
  required String dataB64,
  Value<String?> deviceId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> instanceId,
  Value<bool> isRemote,
  required String userId,
  Value<int> rowid,
});
typedef $$NoteeditordataTableUpdateCompanionBuilder = NoteeditordataCompanion
    Function({
  Value<String> id,
  Value<String> noteId,
  Value<String> dataB64,
  Value<String?> deviceId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> instanceId,
  Value<bool> isRemote,
  Value<String> userId,
  Value<int> rowid,
});

final class $$NoteeditordataTableReferences extends BaseReferences<
    _$AppDatabase, $NoteeditordataTable, NoteeditordataData> {
  $$NoteeditordataTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $NoteTable _noteIdTable(_$AppDatabase db) => db.note
      .createAlias($_aliasNameGenerator(db.noteeditordata.noteId, db.note.id));

  $$NoteTableProcessedTableManager get noteId {
    final $_column = $_itemColumn<String>('note_id')!;

    final manager = $$NoteTableTableManager($_db, $_db.note)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_noteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$NoteeditordataTableFilterComposer
    extends Composer<_$AppDatabase, $NoteeditordataTable> {
  $$NoteeditordataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dataB64 => $composableBuilder(
      column: $table.dataB64, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRemote => $composableBuilder(
      column: $table.isRemote, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  $$NoteTableFilterComposer get noteId {
    final $$NoteTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.noteId,
        referencedTable: $db.note,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NoteTableFilterComposer(
              $db: $db,
              $table: $db.note,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NoteeditordataTableOrderingComposer
    extends Composer<_$AppDatabase, $NoteeditordataTable> {
  $$NoteeditordataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataB64 => $composableBuilder(
      column: $table.dataB64, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRemote => $composableBuilder(
      column: $table.isRemote, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  $$NoteTableOrderingComposer get noteId {
    final $$NoteTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.noteId,
        referencedTable: $db.note,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NoteTableOrderingComposer(
              $db: $db,
              $table: $db.note,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NoteeditordataTableAnnotationComposer
    extends Composer<_$AppDatabase, $NoteeditordataTable> {
  $$NoteeditordataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dataB64 =>
      $composableBuilder(column: $table.dataB64, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get instanceId => $composableBuilder(
      column: $table.instanceId, builder: (column) => column);

  GeneratedColumn<bool> get isRemote =>
      $composableBuilder(column: $table.isRemote, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  $$NoteTableAnnotationComposer get noteId {
    final $$NoteTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.noteId,
        referencedTable: $db.note,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NoteTableAnnotationComposer(
              $db: $db,
              $table: $db.note,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NoteeditordataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NoteeditordataTable,
    NoteeditordataData,
    $$NoteeditordataTableFilterComposer,
    $$NoteeditordataTableOrderingComposer,
    $$NoteeditordataTableAnnotationComposer,
    $$NoteeditordataTableCreateCompanionBuilder,
    $$NoteeditordataTableUpdateCompanionBuilder,
    (NoteeditordataData, $$NoteeditordataTableReferences),
    NoteeditordataData,
    PrefetchHooks Function({bool noteId})> {
  $$NoteeditordataTableTableManager(
      _$AppDatabase db, $NoteeditordataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NoteeditordataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NoteeditordataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NoteeditordataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> noteId = const Value.absent(),
            Value<String> dataB64 = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> instanceId = const Value.absent(),
            Value<bool> isRemote = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteeditordataCompanion(
            id: id,
            noteId: noteId,
            dataB64: dataB64,
            deviceId: deviceId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            instanceId: instanceId,
            isRemote: isRemote,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String noteId,
            required String dataB64,
            Value<String?> deviceId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> instanceId = const Value.absent(),
            Value<bool> isRemote = const Value.absent(),
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteeditordataCompanion.insert(
            id: id,
            noteId: noteId,
            dataB64: dataB64,
            deviceId: deviceId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            instanceId: instanceId,
            isRemote: isRemote,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$NoteeditordataTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({noteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (noteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.noteId,
                    referencedTable:
                        $$NoteeditordataTableReferences._noteIdTable(db),
                    referencedColumn:
                        $$NoteeditordataTableReferences._noteIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$NoteeditordataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NoteeditordataTable,
    NoteeditordataData,
    $$NoteeditordataTableFilterComposer,
    $$NoteeditordataTableOrderingComposer,
    $$NoteeditordataTableAnnotationComposer,
    $$NoteeditordataTableCreateCompanionBuilder,
    $$NoteeditordataTableUpdateCompanionBuilder,
    (NoteeditordataData, $$NoteeditordataTableReferences),
    NoteeditordataData,
    PrefetchHooks Function({bool noteId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoryTableTableManager get category =>
      $$CategoryTableTableManager(_db, _db.category);
  $$NoteTableTableManager get note => $$NoteTableTableManager(_db, _db.note);
  $$NoteeditordataTableTableManager get noteeditordata =>
      $$NoteeditordataTableTableManager(_db, _db.noteeditordata);
}
