import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/features/categories/controllers/create_category_controller.dart';
import 'package:todo_app_updated/features/categories/widgets/labeled_text_field.dart';

class ChooseIcon extends StatelessWidget {
  ChooseIcon({super.key}) : _controller = Get.find<CreateCategoryController>();
  final CreateCategoryController _controller;

  @override
  Widget build(BuildContext context) {
    return LabeledWidget(
      label: TranslationKeys.categoryIcon,
      widget: InkWell(
        onTap: _controller.onChooseIconBottonPressed,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: greyShadow,
              border: Border.all(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: GetBuilder<CreateCategoryController>(
                id: 'icon',
                builder: (_) {
                  IconData? icon = _controller.selectedCategoryIcon;
                  return icon != null
                      ? Icon(icon)
                      : const Text(
                          TranslationKeys.chooseFromLibrary,
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        );
                })),
      ),
    );
  }
}
