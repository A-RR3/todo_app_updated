import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/domain/entities/categories.dart';
import 'package:todo_app_updated/features/categories/controllers/delete_category_controller.dart';

class DeleteCategory extends StatelessWidget {
  DeleteCategory({super.key})
      : _deleteController = Get.find<DeleteCategoryController>();
  final DeleteCategoryController _deleteController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: _deleteController.deleting.value,
        child: DragTarget(
          builder: (_, __, ___) {
            return Align(
              alignment: Alignment.center,
              child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                    iconSize: 30,
                    color: redColor,
                  )),
            );
          },
          // ignore: deprecated_member_use
          onAccept: (Category category) {
            _deleteController.deleteCategory(category);
          },
        ),
      ),
    );
  }
}
