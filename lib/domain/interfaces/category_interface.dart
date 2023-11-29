import 'package:todo_app_updated/domain/entities/categories.dart';

abstract interface class CategoriesInterface {
  Future<List<Category>> getCategories();
  Future<Category> findCategory(int categoryId);
  Future<int> createCategory(Category category);
  Future<int> deleteCategory(Category category);
}
