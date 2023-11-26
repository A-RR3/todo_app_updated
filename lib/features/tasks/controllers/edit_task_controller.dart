import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:training_task1/data/data.dart';
import 'package:training_task1/domain/implementation/task_interactor.dart';
import 'package:training_task1/domain/interfaces/task_interface.dart';
import 'package:training_task1/features/categories/controllers/task_controller.dart';
import 'package:training_task1/features/categories/screens/choose_category_screen.dart';
import 'package:training_task1/features/home/controllers/home_controller.dart';
import 'package:training_task1/features/tasks/screens/edit_title_screen.dart';
import 'package:training_task1/utils/helpers.dart';

class EditTaskController extends TaskController {
  int categoryId = 0;
  DateTime? selectedDate = DateTime.now();
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  var dateIsUpdated = false.obs;
  bool categoryIsUpdated = false;
  late Category newCategory;

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    titleController!.dispose();
    descriptionController!.dispose();
    super.onClose();
  }

  void onCategoryIconPressed() {
    Get.dialog(ChooseCategoryScreen(
      controller: Get.find<EditTaskController>(),
    ));
  }

  Future<void> selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await Helpers.selectDate(context);
    TimeOfDay? pickedTime = TimeOfDay.now();
    if (pickedDate != null) {
      pickedTime = await Helpers.selectTime(pickedDate);
      if (pickedTime != null) {
        selectedDate = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, pickedTime.hour, pickedTime.minute);
        dateIsUpdated.value = true;
      }
    }
  }

  void markAsCompleted(Task task) async {
    TasksInterface service = TasksInteractor();
    if (task.isCompleted == false) {
      task.isCompleted = true;
      await service.updateTask(task);
      await Get.find<HomeController>().getTasks();

      // Get.find<HomeController>().getDoneTasks();
    } else {
      Get.showSnackbar(GetSnackBar(
        messageText: const Text('task is already done'),
        backgroundColor: const Color(0xFF303030).withOpacity(.3),
      ));
    }
  }

  String formatUpdatedDate() {
    String day = Helpers.formatDayFromDateTime(selectedDate!);
    String time = Helpers.formatTimeFromDateTime(selectedDate);
    return '$day At $time';
  }

  void onChangeCategory() {
    Get.dialog(ChooseCategoryScreen(
      controller: Get.find<EditTaskController>(),
    ));
  }

  @override
  void onCategoryTypePressed(int value) {
    categoryId = value;
    print(categoryId);
    categoryIsUpdated = true;
    final homeController = Get.find<HomeController>();
    newCategory = homeController.categoriesList
        .firstWhere((element) => element.id == value);
    update(['category']);
  }

  void onEditIconPressed(Task task) async {
    await Get.dialog(EditTaskTitle(task: task));
  }

  void onEditBottonPressed(Task task) {
    String timeFormat = Helpers.formatTimeFromDateTime(selectedDate);
    String dateFormat = Helpers.formatDateFromDateTime(selectedDate);

    task
      ..title = titleController!.text
      ..description = descriptionController!.text
      ..categoryId = categoryId
      ..date = dateFormat
      ..time = timeFormat
      ..isCompleted = false;

    TasksInteractor service = TasksInteractor();
    service.updateTask(task);
    Get.find<HomeController>().getTasks();
  }

  Future<void> sharePressed(Task task) async {
    await Share.share(_sharedMessage(task),
        subject: "I've shared this ToDo with you!");
  }

  String _sharedMessage(Task task) {
    return '''Title: ${task.title}\n
    Description: ${task.description}\n
    DueDate: ${task.date}\n
    Category: ${newCategory.name}''';
  }
}
