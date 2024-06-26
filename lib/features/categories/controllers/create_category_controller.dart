import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/constants.dart';
import 'package:todo_app_updated/domain/entities/categories.dart';
import 'package:todo_app_updated/domain/implementation/category_interactor.dart';
import 'package:todo_app_updated/features/categories/screens/choose_icon_screen.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';

class CreateCategoryController extends GetxController {
  TextEditingController categoryNameController = TextEditingController();
  int? selectedCategoryColor;
  IconData? selectedCategoryIcon;
  final GlobalKey<FormState> formKey = GlobalKey();

  bool get isValidForm => formKey.currentState?.validate() ?? false;

  @override
  void onClose() {
    categoryNameController.dispose();
    super.onClose();
  }

  void onChooseIconBottonPressed() async {
    IconData? result = await Get.dialog(const ChooseIconScreen());
    if (result != null) {
      selectedCategoryIcon = result;
      update(['icon']);
    } else {
      Get.back();
    }
  }

  void setCategoryColor(int hexColor) {
    selectedCategoryColor = Color(hexColor).value;
    update(['category color']);
  }

  void createCategory() async {
    if (!isValidForm) return;
    CategoriesInteractor service = CategoriesInteractor();
    Category category = Category.create(
        name: categoryNameController.text,
        icon: selectedCategoryIcon ?? icons[0],
        color: Color(selectedCategoryColor ?? colorsList[0]));
    await service.createCategory(category);
    Get.find<HomeController>().getCategories();
    Get.back();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required Field';
    return null;
  }
}
