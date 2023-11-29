import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/constants.dart';
import 'package:todo_app_updated/features/categories/controllers/create_category_controller.dart';

class ChooseColorScreen extends StatelessWidget {
  ChooseColorScreen({super.key})
      : _controller = Get.put(CreateCategoryController());
  final CreateCategoryController _controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              colorsList.length,
              (index) => InkWell(
                    onTap: () {
                      _controller.setCategoryColor(colorsList[index]);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(colorsList[index])),
                        child: GetBuilder<CreateCategoryController>(
                          id: 'category color',
                          builder: (_) {
                            return _controller.selectedCategoryColor ==
                                    colorsList[index]
                                ? const Icon(
                                    Icons.check,
                                    size: 20,
                                  )
                                : const Text('');
                          },
                        )),
                  ))),
    );
  }
}
