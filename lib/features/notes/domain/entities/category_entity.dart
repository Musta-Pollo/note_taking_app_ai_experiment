import 'package:drift/drift.dart' hide JsonKey;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';

part 'category_entity.freezed.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  const CategoryEntity._();
  const factory CategoryEntity({
    required String id,
    required String name,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    String? instanceId,
    required bool isRemote,
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
  factory CategoryEntity.fromDatabase(CategoryData category) {
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
  CategoryCompanion toCompanion({bool isUpdate = false}) {
    return CategoryCompanion(
      id: Value(id),
      name: Value(name),
      userId: Value(userId),
      createdAt: isUpdate ? const Value.absent() : Value(createdAt),
      updatedAt: Value(DateTime.now().toUtc()),
      deletedAt: Value(deletedAt),
      instanceId: Value(instanceId),
      isRemote: const Value(false), // Always false for local changes
    );
  }
}
