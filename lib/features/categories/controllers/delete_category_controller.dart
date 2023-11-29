import 'package:get/get.dart';
import 'package:todo_app_updated/domain/entities/categories.dart';
import 'package:todo_app_updated/domain/implementation/category_interactor.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';

class DeleteCategoryController extends GetxController {
  RxBool deleting = false.obs;

  void changeDeleting(bool val) {
    deleting.value = val;
  }

  void deleteCategory(Category category) async {
    CategoriesInteractor service = CategoriesInteractor();
    await service.deleteCategory(category);
    Get.find<HomeController>().getCategories();
  }
}
