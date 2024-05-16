import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/constants.dart';

class ChooseIconScreen extends StatelessWidget {
  const ChooseIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: SizedBox(
          width: Get.width * .4,
          height: Get.height * .4,
          child: Column(children: [
            GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                children: List.generate(
                    icons.length,
                    (index) => IconButton(
                          onPressed: () => Get.back(result: icons[index]),
                          icon: Icon(icons[index]),
                        ))),
          ]),
        ));
  }
}
