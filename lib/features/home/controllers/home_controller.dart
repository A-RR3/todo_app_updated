
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_updated/data/data.dart';
import 'package:todo_app_updated/domain/implementation/task_interactor.dart';
import 'package:todo_app_updated/domain/interfaces/task_interface.dart';
import 'package:todo_app_updated/utils/helpers.dart';
import 'package:todo_app_updated/domain/implementation/category_interactor.dart';
import 'package:todo_app_updated/features/tasks/screens/add_new_task_screen.dart';
import 'package:todo_app_updated/utils/task_status.dart';

class HomeController extends GetxController {
  Rx<TaskStatus> filter = TaskStatus.all.obs;

  RxBool isLoading = true.obs;

  DateFormat format = DateFormat('MM/dd/yyyy');

  RxList<Task> taskList = <Task>[].obs;

  List<Category> categoriesList = <Category>[];

  RxInt get tasksCount => taskList.length.obs;

  TasksInterface service = TasksInteractor();

  @override
  void onInit() async {
    await getCategories();
    await getTasks();
    super.onInit();
  }

  void onSelectStatus(TaskStatus? value) {
    filter.value = value!;
  }

  String formatDay(Task task) {
    String dueDate = task.date!; // mm/dd/yyyy
    DateTime date = format.parse(dueDate); // yyyy-mm-dd 00:00:00
    bool isToday = Helpers.isEqualToday(date);

    if (isToday) {
      return 'Today';
    }
    return Helpers.formatDayFromDateTime(date);
  }

  Future<void> getTasks() async {
    taskList.value = await service.readAll();
    isLoading.value = false;
  }

  List<Task> filterTasks(TaskStatus value) {
    switch (value) {
      case TaskStatus.all:
        return taskList;
      case TaskStatus.completed:
        return taskList.where((item) => item.isCompleted).toList();
      case TaskStatus.today:
        return taskList
            .where((item) => Helpers.isEqualToday(format.parse(item.date!)))
            .toList();
      default:
        return [];
    }
  }

  // Category getTaskCategory(int categoryId) {
  //   return categoriesList.singleWhere((element) => element.id == categoryId);
  // }
  Future<Category> getTaskCategory(int categoryId) async {
    CategoriesInteractor service = CategoriesInteractor();
    Category category = await service.getOneCategory(categoryId);
    return category;
  }

  Future<void> getCategories() async {
    CategoriesInteractor service = CategoriesInteractor();
    categoriesList = await service.getCategories();
    for (var element in categoriesList) {
      print({element.id, element.name});
    }

    update(['categories list']);
  }

  Future<int?> getFirstCategory() async {
    CategoriesInteractor service = CategoriesInteractor();
    List<Category> category = await service.getCategories();
    return category.first.id;
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
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onAddNewTaskPressed() {
    Get.bottomSheet(AddNewTaskScreen());
  }
}
