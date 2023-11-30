import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/domain/implementation/task_interactor.dart';
import 'package:todo_app_updated/features/categories/controllers/change_category_mixin.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';
import 'package:todo_app_updated/utils/helpers.dart';

abstract class TaskFormController extends GetxController with onChangeCategory {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  bool get isCategoryListEmpty => _isCategoryListEmpty();

  int? categoryId;

  TasksInteractor serviceTask = TasksInteractor();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool get isValidForm => formKey.currentState?.validate() ?? false;

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  @override
  void onCategoryTypePressed(int value);

  String? validateTitleInput(String? value) {
    if (value == null || value.trim().isEmpty) return TranslationKeys.required;

    if (value.isNotEmpty && value.length > 25) {
      return TranslationKeys.taskFieldLength;
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) return TranslationKeys.required;
    if (value.isNotEmpty && value.length > 225) {
      return TranslationKeys.descriptionFieldLength;
    }
    return null;
  }

  bool _isCategoryListEmpty() {
    bool isCategoriesListEmpty =
        Get.find<HomeController>().categoriesList.isEmpty;
    if (isCategoriesListEmpty) {
      Helpers.showSnackBar(
          message: "Create at least one category",
          color: redColor,
          position: SnackPosition.TOP);
      return true;
    }
    return false;
  }

  void onSubmitForm();
}
