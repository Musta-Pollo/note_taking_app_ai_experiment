import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_local_datasource.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesLocalDataSource _localDataSource;
  final String _userId;

  CategoriesRepositoryImpl(this._localDataSource, this._userId);

  @override
  Stream<List<CategoryEntity>> getAllCategories() {
    return _localDataSource.getAllCategories(_userId);
  }

  @override
  Future<CategoryEntity?> getCategoryById(String id) {
    return _localDataSource.getCategoryById(id);
  }

  @override
  Future<CategoryEntity> createCategory(String name) {
    final category = CategoryEntity.create(
      name: name,
      userId: _userId,
    );
    return _localDataSource.createCategory(category);
  }

  @override
  Future<CategoryEntity> updateCategory(CategoryEntity category) {
    return _localDataSource.updateCategory(category);
  }

  @override
  Future<void> deleteCategory(String id) {
    return _localDataSource.deleteCategory(id);
  }

  @override
  Stream<List<CategoryEntity>> searchCategories(String query) {
    return _localDataSource.searchCategories(query, _userId);
  }
}