import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/data/data.dart';
import 'package:todo_app_updated/features/categories/screens/choose_category_screen.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';
import 'package:todo_app_updated/features/tasks/controllers/task_form_controller.dart';
import 'package:todo_app_updated/features/tasks/screens/edit_title_screen.dart';
import 'package:todo_app_updated/utils/helpers.dart';

class EditTaskController extends TaskFormController {
  EditTaskController({required this.task});

  final Task task;

  RxBool dateIsUpdated = false.obs;

  bool categoryIsUpdated = false;

  late Category newCategory;

  @override
  void onInit() {
    titleController.text = task.title!;
    descriptionController.text = task.description!;
    categoryId = task.categoryId;
    selectedDate = Helpers.stringToDateTime(task.date!);
    newCategory = Get.find<HomeController>()
        .categoriesList
        .firstWhere((element) => element.id == task.categoryId);

    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
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
    if (task.isCompleted == false) {
      task.isCompleted = true;
      await serviceTask.updateTask(task);
      await Get.find<HomeController>().getTasks();
    } else {
      Helpers.showSnackBar(
        message: TranslationKeys.taskIsAlreadyDone,
      );
    }
  }

  String formatUpdatedDate() {
    String day = Helpers.formatDayFromDateTime(selectedDate);
    String time = Helpers.formatTimeFromDateTime(selectedDate);
    return '$day At $time';
  }

  @override
  void onCategoryTypePressed(int value) {
    categoryId = value;
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
      ..title = titleController.text
      ..description = descriptionController.text
      ..categoryId = categoryId ?? task.categoryId
      ..date = dateFormat
      ..time = timeFormat
      ..isCompleted = false;

    serviceTask.updateTask(task);
    Get.find<HomeController>().getTasks();
  }

  Future<void> sharePressed(Task task) async {
    await Share.share(_sharedMessage(task), subject: TranslationKeys.subject);
  }

  String _sharedMessage(Task task) {
    return '''Title: ${task.title}\n
    Description: ${task.description}\n
    DueDate: ${task.date}\n
    Category: ${newCategory.name}''';
  }

  void showDeleteConfirmationDialog() {
    Get.defaultDialog(
      title: TranslationKeys.confirmDeleteTitle,
      middleText: TranslationKeys.confirmDelete,
      textConfirm: TranslationKeys.delete,
      textCancel: TranslationKeys.cancel,
      confirmTextColor: Colors.white,
      buttonColor: pinkClr,
      onConfirm: () {
        Get.find<HomeController>().deleteTask(task);
        Get.back();
        Helpers.showSnackBar(
            message: TranslationKeys.taskIsDeleted,
            color: Colors.green.withOpacity(.3));
      },
    );
  }

  @override
  void onSubmitForm() {
    if (!isValidForm) return;
    Get.back();
  }
}
