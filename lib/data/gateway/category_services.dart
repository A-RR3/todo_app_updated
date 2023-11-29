import 'package:todo_app_updated/data/datasource/database_services.dart';
import 'package:todo_app_updated/domain/entities/categories.dart';
import 'package:todo_app_updated/domain/interfaces/category_interface.dart';
import 'package:todo_app_updated/utils/data_base_config.dart';

class CategoriesServices extends DataBaseServices<Category>
    implements CategoriesInterface {
  String get table => AppKeys.categoryTable;

  @override
  Future<int> createCategory(Category model) async {
    return await create(model);
  }

  @override
  Future<Category> findCategory(int categoryId) async {
    return retrieveOne(table, Category.fromMap, categoryId);
  }

  @override
  Future<List<Category>> getCategories() async {
    return retrieveAll(table, Category.fromMap);
  }

  @override
  Future<int> deleteCategory(Category model) async {
    return await delete(model);
  }
}
