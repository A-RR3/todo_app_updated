import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:training_task1/data/data.dart';
import 'package:training_task1/features/categories/controllers/change_category_mixin.dart';
import 'package:training_task1/features/categories/screens/choose_category_screen.dart';
import 'package:training_task1/features/home/controllers/home_controller.dart';
import 'package:training_task1/features/tasks/controllers/task_form_controller.dart';
import 'package:training_task1/utils/helpers.dart';

class AddNewTaskController extends TaskFormController with onChangeCategory {
  
 @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  @override
  void onCategoryTypePressed(int value) {
    categoryId = value;
  }

  @override
  void onSubmitForm() {
    if (!isValidForm) return;
    addNewTask();
    Get.back();
  }

  Future<Task> getTaskById(int id) async {
    return await serviceTask.getSingleTask(id);
  }

  void addNewTask() async {
    HomeController homeController = Get.find<HomeController>();
    String timeFormat = DateFormat("hh:mm a").format(selectedDate).toString();
    String dateFormat = DateFormat.yMd('en_US').format(selectedDate);
    Task task = Task.create(
        title: titleController.text,
        date: dateFormat,
        time: timeFormat,
        categoryId: categoryId ?? 1,
        description: descriptionController.text);
    await serviceTask.addTask(task);
    homeController.getTasks();
  }

  void selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await Helpers.selectDate(context);
    TimeOfDay? pickedTime = TimeOfDay.now(); //DateTime.now()
    if (pickedDate != null) {
      pickedTime = await Helpers.selectTime(pickedDate);
      if (pickedTime != null) {
        selectedDate = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, pickedTime.hour, pickedTime.minute);
      }
    }
  }

  void onCategoryIconPressed() {
    Get.dialog(ChooseCategoryScreen(
      controller: Get.find<AddNewTaskController>(),
    ));
  }
}
