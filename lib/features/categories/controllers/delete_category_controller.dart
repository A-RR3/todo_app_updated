import 'package:get/get.dart';
import 'package:todo_app_updated/data/data.dart';
import 'package:todo_app_updated/domain/implementation/category_interactor.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';

class DeleteCategoryController extends GetxController {
  RxBool deleting = false.obs;
  HomeController controller = Get.find<HomeController>();
  CategoriesInteractor service = CategoriesInteractor();

  void changeDeleting(bool val) {
    deleting.value = val;
  }

  void deleteCategory(Category category) async {
    await service.deleteCategory(category);
    await deleteTasksOfCategory(category.id!);
    controller.getCategories();
  }

  Future<void> deleteTasksOfCategory(int id) async {
    for (Task task in controller.taskList) {
      if (task.categoryId == id) {
        await controller.deleteTask(task);
      }
    }
    controller.getTasks();
  }
}
