import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_task1/domain/entities/categories.dart';
import 'package:training_task1/domain/implementation/category_interactor.dart';
import 'package:training_task1/features/categories/screens/choose_icon_screen.dart';

class CreateCategoryController extends GetxController {
  TextEditingController? categoryNameController;
  int? selectedCategoryColor;
  IconData? selectedCategoryIcon;

  @override
  void onInit() {
    categoryNameController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    categoryNameController!.dispose();
    super.onClose();
  }

  void onChooseIconBottonPressed() async {
    var result = await Get.dialog(ChooseIconScreen());
    if (result != null) {
      selectedCategoryIcon = result;
      update();
    }
  }

  void setCategoryColor(int hexColor) {
    selectedCategoryColor = Color(hexColor).value;
    update();
  }

  void createCategory() async {
    CategoriesInteractor service = CategoriesInteractor();
    Category category = Category.create(
        name: categoryNameController!.text,
        icon: selectedCategoryIcon!,
        color: Color(selectedCategoryColor!));
    await service.createCategory(category);
  }
}
