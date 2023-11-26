import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_task1/features/home/controllers/home_controller.dart';
import 'package:training_task1/features/home/screens/empty_home_screen.dart';
import 'package:training_task1/features/home/screens/loading_state.dart';
import 'package:training_task1/features/home/widgets/drop_down_menu.dart';
import 'package:training_task1/features/home/widgets/done_list.dart';
import 'package:training_task1/features/home/widgets/tasks_list.dart';
import 'package:training_task1/features/home/widgets/tasks_list_view.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key}) : controller = Get.put(HomeController());

  HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Column(children: [
                SizedBox(
                  child: Align(
                      alignment: Alignment.centerLeft, child: DropDownMenu()),
                ),
                Expanded(
                    child: Obx(() => controller.isLoading.value
                        ? LoadingStateScreen()
                        : (controller.taskList.isEmpty
                            ? EmptyHomeScreen()
                            : TaskListView(controller.filterTasks(
                                controller.selectedValue.value))))),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF8687E7),
                    onPressed: controller.onAddNewTaskPressed,
                    tooltip: 'Add Task',
                    child: const Icon(Icons.add),
                  ),
                )
              ]),
            )));
  }
}
