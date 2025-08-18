import '../entities/category_entity.dart';

abstract class CategoriesRepository {
  Stream<List<CategoryEntity>> getAllCategories();
  Future<CategoryEntity?> getCategoryById(String id);
  Future<CategoryEntity> createCategory(String name);
  Future<CategoryEntity> updateCategory(CategoryEntity category);
  Future<void> deleteCategory(String id);
  Stream<List<CategoryEntity>> searchCategories(String query);
}