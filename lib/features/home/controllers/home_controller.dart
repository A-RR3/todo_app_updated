import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_task1/data/data.dart';
import 'package:training_task1/data/datasource/data_base.dart';
import 'package:training_task1/domain/implementation/task_interactor.dart';
import 'package:training_task1/domain/interfaces/task_interface.dart';
import 'package:training_task1/utils/helpers.dart';
import 'package:training_task1/domain/implementation/category_interactor.dart';
import 'package:training_task1/features/tasks/screens/add_new_task_screen.dart';
import 'package:training_task1/utils/task_status.dart';

class HomeController extends GetxController {
  //variables
  RxString selectedValue = TaskStatus.all.value.obs;
  RxBool isLoading = true.obs;
  RxList<Task> taskList = <Task>[].obs;
  RxList<Category> categoriesList = <Category>[].obs;
  // var doneTodos = <Task>[].obs;
  // RxString dayFormat = 'Today'.obs;

  //getters
  RxInt get tasksCount => taskList.length.obs;

  //database
  TasksInterface service = TasksInteractor();

  @override
  void onInit() async {
    //insert some categories in the DB when it is first initialized
    await getCategories();
    await getTasks();
    super.onInit();
  }

  String formatDay(Task task) {
    String dueDate = task.date!;
    bool isToday = isEqualToday(dueDate);

    if (isToday) {
      return 'Today';
    }
    return Helpers.formatDayFromDateTime(DateTime.parse(dueDate));
    // return dayFormat.value = 'Today';
  }

  bool isEqualToday(String date) {
    return date.split(' ')[0] == DateTime.now().toString().split(' ')[0];
  }

  Future<void> getTasks() async {
    taskList.value = await service.readAll();
    isLoading.value = false;
  }

  List<Task> filterTasks(String value) {
    switch (value) {
      case 'All':
        return taskList;
      case 'Completed':
        return taskList.where((item) => item.isCompleted).toList();
      case 'Today':
        return taskList.where((item) => isEqualToday(item.date!)).toList();
      default:
        Get.snackbar('error', 'not included');
        return [];
    }
  }

  Category getTaskCategory(int categoryId) {
    return categoriesList.singleWhere((element) => element.id == categoryId);
  }

  Future<void> getCategories() async {
    CategoriesInteractor service = CategoriesInteractor();
    categoriesList.value = await service.getCategories();
  }

  void toggleTaskCompletion(Task task) async {
    bool completed = !(task.isCompleted);
    task.isCompleted = completed;
    await service.updateTask(task);
    await getTasks();
  }

  Future<void> deleteTask(Task task) async {
    try {
      await service.deleteTask(task);
      taskList.remove(task);
      if (task.isCompleted == true) {
      }
      taskList.refresh();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onAddNewTaskPressed() {
    Get.bottomSheet(AddNewTaskScreen());
  }
}




  // Future<void> createCategoriesList() async {
  //   StorageService dbHelper = StorageService();
  //   List<Category> categories = [
  //     Category.create(
  //         name: 'education',
  //         icon: Icons.school,
  //         color: Color.fromARGB(255, 99, 200, 250)),
  //     Category.create(
  //         name: 'food', icon: Icons.food_bank, color: Colors.orange),
  //     Category.create(name: 'home', icon: Icons.home, color: Colors.green),
  //     Category.create(
  //         name: 'personal', icon: Icons.person, color: Colors.lightBlue),
  //   ];

  //   await dbHelper.createCategories(categories);
  // }
