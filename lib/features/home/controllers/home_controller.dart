import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:training_task1/data/data.dart';
import 'package:training_task1/domain/implementation/task_interactor.dart';
import 'package:training_task1/domain/interfaces/task_interface.dart';
import 'package:training_task1/utils/helpers.dart';
import 'package:training_task1/domain/implementation/category_interactor.dart';
import 'package:training_task1/features/tasks/screens/add_new_task_screen.dart';
import 'package:training_task1/utils/task_status.dart';

class HomeController extends GetxController {
  Rx<TaskStatus> filter = TaskStatus.all.obs;

  RxBool isLoading = true.obs;

  DateFormat format = DateFormat('MM/dd/yyyy');

  RxList<Task> taskList = <Task>[].obs;

  RxList<Category> categoriesList = <Category>[].obs;

  RxInt get tasksCount => taskList.length.obs;

  TasksInterface service = TasksInteractor();

  @override
  void onInit() async {
    await getCategories();
    await getTasks();
    super.onInit();
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

//TODO: 2
  List<Task> filterTasks(TaskStatus value) {
    switch (value) {
      case 'All':
        return taskList;
      case 'Completed':
        return taskList.where((item) => item.isCompleted).toList();
      case 'Today':
        return taskList
            .where((item) => Helpers.isEqualToday(format.parse(item.date!)))
            .toList();
      default:
        // Get.snackbar('error', 'not included');
        return taskList;
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
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onAddNewTaskPressed() {
    Get.bottomSheet(AddNewTaskScreen());
  }
}
