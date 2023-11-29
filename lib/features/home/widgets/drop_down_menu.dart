import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';
import 'package:todo_app_updated/utils/task_status.dart';

class DropDownMenu extends StatelessWidget {
  DropDownMenu({super.key}) : homeController = Get.find<HomeController>();
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        decoration: BoxDecoration(
            color: greyShadow, borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(
          () => DropdownButton<TaskStatus>(
            value: homeController.filter.value,
            onChanged: homeController.onSelectStatus,
            items: TaskStatus.values.map((TaskStatus status) {
              return DropdownMenuItem<TaskStatus>(
                value: status,
                child: Text(status.name),
              );
            }).toList(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 32,
              color: Colors.grey,
            ),
            elevation: 3,
            underline: Container(height: 0),
            borderRadius: BorderRadius.circular(15),
          ),
        ));
  }
}
