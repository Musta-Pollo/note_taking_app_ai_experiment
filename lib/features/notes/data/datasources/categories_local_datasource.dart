import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/category_entity.dart';

class CategoriesLocalDataSource {
  final AppDatabase _database;

  CategoriesLocalDataSource(this._database);

  Stream<List<CategoryEntity>> getAllCategories(String userId) {
    return _database.getAllCategories(userId)
        .map((categories) => categories.map((cat) => CategoryEntity.fromDatabase(cat)).toList());
  }

  Future<CategoryEntity?> getCategoryById(String id) async {
    final category = await (_database.select(_database.category)
          ..where((c) => c.id.equals(id) & c.deletedAt.isNull()))
        .getSingleOrNull();
    
    return category != null ? CategoryEntity.fromDatabase(category) : null;
  }

  Future<CategoryEntity> createCategory(CategoryEntity category) async {
    await _database.into(_database.category).insert(category.toCompanion());
    
    final created = await getCategoryById(category.id);
    return created!;
  }

  Future<CategoryEntity> updateCategory(CategoryEntity category) async {
    await (_database.update(_database.category)
          ..where((c) => c.id.equals(category.id)))
        .write(category.toCompanion(isUpdate: true));
    
    final updated = await getCategoryById(category.id);
    return updated!;
  }

  Future<void> deleteCategory(String id) async {
    // Soft delete with sync fields
    await (_database.update(_database.category)
          ..where((c) => c.id.equals(id)))
        .write(CategoryCompanion(
          deletedAt: Value(DateTime.now().toUtc()),
          updatedAt: Value(DateTime.now().toUtc()),
          isRemote: const Value(false), // Mark as local change for sync
        ));
  }

  Stream<List<CategoryEntity>> searchCategories(String query, String userId) {
    return (_database.select(_database.category)
          ..where((c) => c.userId.equals(userId) 
              & c.deletedAt.isNull() 
              & c.name.contains(query))
          ..orderBy([(c) => OrderingTerm.asc(c.name)]))
        .watch()
        .map((categories) => categories.map((cat) => CategoryEntity.fromDatabase(cat)).toList());
  }
}