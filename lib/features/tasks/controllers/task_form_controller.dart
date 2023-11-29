import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/domain/implementation/task_interactor.dart';
import 'package:todo_app_updated/features/categories/controllers/change_category_mixin.dart';

abstract class TaskFormController extends GetxController with onChangeCategory {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  int? categoryId;

  TasksInteractor serviceTask = TasksInteractor();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool get isValidForm => formKey.currentState?.validate() ?? false;

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

  void onSubmitForm();

  @override
  void onCategoryTypePressed(int value);
}
