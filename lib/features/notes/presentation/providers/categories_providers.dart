import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../../data/repositories/categories_repository_impl.dart';
import '../../data/datasources/categories_local_datasource.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/constants/k.dart';

part 'categories_providers.g.dart';

/// Categories data source provider
@riverpod
CategoriesLocalDataSource categoriesLocalDataSource(Ref ref) {
  final database = ref.watch(databaseProvider);
  return CategoriesLocalDataSource(database);
}

/// Categories repository provider
@riverpod
CategoriesRepository categoriesRepository(Ref ref) {
  final dataSource = ref.watch(categoriesLocalDataSourceProvider);
  final userId = ref.watch(currentUserIdProvider);

  // Use offline mode when no user ID (not authenticated)
  final effectiveUserId = userId ?? K.offlineUserId;

  return CategoriesRepositoryImpl(dataSource, effectiveUserId);
}

/// Categories notifier for state management
@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  Stream<List<CategoryEntity>> build() {
    final repository = ref.watch(categoriesRepositoryProvider);
    return repository.getAllCategories();
  }

  /// Create new category
  Future<CategoryEntity> createCategory(String name) async {
    final repository = ref.read(categoriesRepositoryProvider);
    return await repository.createCategory(name);
  }

  /// Update existing category
  Future<CategoryEntity> updateCategory(CategoryEntity category) async {
    final repository = ref.read(categoriesRepositoryProvider);
    return await repository.updateCategory(category);
  }

  /// Delete category
  Future<void> deleteCategory(String id) async {
    final repository = ref.read(categoriesRepositoryProvider);
    await repository.deleteCategory(id);
  }

  /// Get category by ID
  Future<CategoryEntity?> getCategoryById(String id) async {
    final repository = ref.read(categoriesRepositoryProvider);
    return await repository.getCategoryById(id);
  }
}

/// Provider for searching categories
@riverpod
Stream<List<CategoryEntity>> searchCategories(Ref ref, String query) {
  final repository = ref.watch(categoriesRepositoryProvider);
  return repository.searchCategories(query);
}