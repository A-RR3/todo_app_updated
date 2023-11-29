import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/core/values/values.dart';
import 'package:todo_app_updated/features/categories/controllers/create_category_controller.dart';
import 'package:todo_app_updated/features/categories/screens/choose_color_screen.dart';
import 'package:todo_app_updated/features/categories/widgets/labeled_text_field.dart';
import 'package:todo_app_updated/features/categories/widgets/material_botton.dart';
import 'package:todo_app_updated/core/widgets/common_text_field.dart';

class CreateCategoryScreen extends StatelessWidget {
  CreateCategoryScreen({super.key})
      : _controller = Get.put(CreateCategoryController());
  final CreateCategoryController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: Get.height * .87,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TranslationKeys.createCategory,
                          style: textTheme(20, null, null),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabeledWidget(
                          label: TranslationKeys.categoryNameLbl,
                          widget: Form(
                            key: _controller.formKey,
                            child: CommonTextField(
                              hintText: TranslationKeys.categoryNameHint,
                              controller: _controller.categoryNameController,
                              validator: (value) =>
                                  _controller.validateName(value),
                            ),
                          ),
                        ),
                        LabeledWidget(
                          label: TranslationKeys.categoryIcon,
                          widget: InkWell(
                            onTap: _controller.onChooseIconBottonPressed,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: greyShadow,
                                  border: Border.all(
                                      color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: GetBuilder<CreateCategoryController>(
                                    id: 'icon',
                                    builder: (_) {
                                      IconData? icon =
                                          _controller.selectedCategoryIcon;
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
                        ),
                        Text(
                          TranslationKeys.categoryClr,
                          style: textTheme(20, null, null),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ChooseColorScreen(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MyMaterialBotton(
                            onPress: () => Get.back(),
                            text: TranslationKeys.cancel,
                            textColor: primaryColor),
                      ),
                      Expanded(
                        child: MyMaterialBotton(
                          onPress: _controller.createCategory,
                          text: TranslationKeys.createCategory,
                          textColor: Colors.white,
                          bottonColor: primaryColor,
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
