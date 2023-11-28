import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_task1/core/values/constants.dart';
import 'package:training_task1/features/categories/controllers/create_category_controller.dart';

class ChooseColorScreen extends StatelessWidget {
  ChooseColorScreen({super.key});
  final controller = Get.put(CreateCategoryController());


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              colorsList.length,
              (index) => InkWell(
                    onTap: () {
                      controller.setCategoryColor(colorsList[index]);
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
                            return controller.selectedCategoryColor ==
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


 



        //       ListView.separated(
        //   itemCount: colorsList.length,
        //   itemBuilder: (context, index) {
        //     return InkWell(
        //         onTap: () {},
        //         child: Container(
        //           height: 50,
        //           width: 50,
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: Color(colorsList[index]),
        //           ),
        //         ));
        //   },
        //   separatorBuilder: (context, index) => const Gap(8),
        // ),