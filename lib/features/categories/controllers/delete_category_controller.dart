import 'package:get/get.dart';
import 'package:todo_app_updated/data/data.dart';
import 'package:todo_app_updated/domain/implementation/category_interactor.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';

class DeleteCategoryController extends GetxController {
  RxBool deleting = false.obs;
  HomeController controller = Get.find<HomeController>();

  void changeDeleting(bool val) {
    deleting.value = val;
  }

  void deleteCategory(Category category) async {
    CategoriesInteractor service = CategoriesInteractor();
    int id = await service.deleteCategory(category);
    taskHasCategory(id);
    controller.getTasks();
    controller.getCategories();
  }

  void taskHasCategory(int id) {
    for (Task task in controller.taskList) {
      if (task.categoryId == id) {
        controller.deleteTask(task);
      }
    }
  }
}
