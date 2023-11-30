import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/core/values/constants.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/domain/entities/categories.dart';
import 'package:todo_app_updated/features/categories/controllers/delete_category_controller.dart';
import 'package:todo_app_updated/features/categories/screens/create_category_screen.dart';
import 'package:todo_app_updated/features/categories/widgets/delete_category.circle.dart';
import 'package:todo_app_updated/features/categories/widgets/material_botton.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';
import 'package:todo_app_updated/features/tasks/controllers/task_form_controller.dart';
import '../widgets/category_item.dart';

class ChooseCategoryScreen extends StatelessWidget {
  ChooseCategoryScreen({super.key, required this.controller})
      : _homeController = Get.find<HomeController>(),
        _deleteController = Get.put(DeleteCategoryController());

  final HomeController _homeController;
  final TaskFormController controller;
  final DeleteCategoryController _deleteController;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: greyShadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: SizedBox(
          height: Get.height * 0.65,
          width: Get.width * .75,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  TranslationKeys.chooseCategory,
                  style: textTheme(18, null, null),
                ),
              ),
              const Divider(
                thickness: 2,
                height: 40,
              ),
              GetBuilder<HomeController>(
                id: 'categories list',
                builder: (_) => Expanded(
                  child: GridView.builder(
                    itemCount: _homeController.categoriesList.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      List<Category> categories =
                          _homeController.categoriesList.toList();

                      if (index < categories.length) {
                        return LongPressDraggable(
                          data: categories[index],
                          onDragStarted: () =>
                              _deleteController.changeDeleting(true),
                          onDraggableCanceled: (_, __) =>
                              _deleteController.changeDeleting(false),
                          onDragEnd: (_) =>
                              _deleteController.changeDeleting(false),
                          feedback: Opacity(
                            opacity: .8,
                            child: CategoryItem(
                              icon: categories[index].icon,
                              name: categories[index].name,
                              color: categories[index].color,
                            ),
                          ),
                          child: CategoryItem(
                            icon: categories[index].icon,
                            name: categories[index].name,
                            color: categories[index].color,
                            onTap: () {
                              controller.onCategoryTypePressed(index + 1);
                            },
                          ),
                        );
                      } else {
                        return CategoryItem(
                          icon: Icons.add,
                          name: TranslationKeys.createNew,
                          color: greyShadow.withGreen(105),
                          onTap: () => Get.to(() => CreateCategoryScreen()),
                        );
                      }
                    },
                  ),
                ),
              ),
              DeleteCategory(),
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
                      onPress: () => Get.back(),
                      text: TranslationKeys.chooseCategory,
                      textColor: Colors.white,
                      bottonColor: primaryColor,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
