import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:training_task1/core/values/constants.dart';
import 'package:training_task1/domain/entities/task.dart';
import 'package:training_task1/features/home/controllers/home_controller.dart';
import 'package:training_task1/features/home/widgets/task_item.dart';
import 'package:training_task1/features/tasks/screens/task_details_screen.dart';

class TaskListView extends StatelessWidget {
  TaskListView(this.tasks) : _controller = Get.find<HomeController>();

  final List<Task>? tasks;
  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks!.length,
        itemBuilder: (context, index) {
          Task task = tasks![index];
          return Dismissible(
              key: Key(index.toString()),
              onDismissed: (direction) => _controller.deleteTask(task),
              child: TaskItem(
                  marginTop: kDefaultPadding,
                  task: task,
                  onChackBoxChange: () => _controller.toggleTaskCompletion(task),
                  onPressed: () => Get.to(() => TaskDetailsScreen(
                        task: task,
                      ))));
        });
  }
}
