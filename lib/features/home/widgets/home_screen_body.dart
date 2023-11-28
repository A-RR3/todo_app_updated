import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_task1/core/values/translations_keys.dart';
import 'package:training_task1/features/home/controllers/home_controller.dart';
import 'package:training_task1/features/home/screens/empty_home_screen.dart';
import 'package:training_task1/features/home/screens/loading_state.dart';
import 'package:training_task1/features/home/widgets/drop_down_menu.dart';
import 'package:training_task1/features/home/widgets/tasks_list_view.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key}) : _controller = Get.find<HomeController>();

  final HomeController _controller;

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
                    child: Obx(() => _controller.isLoading.value
                        ? const LoadingStateScreen()
                        : (_controller.taskList.isEmpty
                            ? const EmptyHomeScreen()
                            : TaskListView(_controller
                                .filterTasks(_controller.filter.value))))),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xFF8687E7),
                    onPressed: _controller.onAddNewTaskPressed,
                    tooltip: TranslationKeys.addTask,
                    child: const Icon(Icons.add),
                  ),
                )
              ]),
            )));
  }
}
