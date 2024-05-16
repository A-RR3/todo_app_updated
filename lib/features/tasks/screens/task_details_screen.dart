import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/core/values/icons.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/domain/entities/task.dart';
import 'package:todo_app_updated/features/calendar/screens/calendar_screen.dart';
import 'package:todo_app_updated/features/categories/widgets/material_botton.dart';
import 'package:todo_app_updated/features/tasks/controllers/edit_task_controller.dart';
import 'package:todo_app_updated/features/tasks/widgets/edit_category_widget.dart';
import 'package:todo_app_updated/features/tasks/widgets/edit_time_widget.dart';
import 'package:todo_app_updated/features/tasks/widgets/labeled_icon_widget.dart';
import 'package:todo_app_updated/features/tasks/widgets/mark_as_complete_widget.dart';
import 'package:todo_app_updated/features/tasks/widgets/share_task_widget.dart';
import 'package:todo_app_updated/features/tasks/widgets/title_description_widget.dart';

class TaskDetailsScreen extends StatelessWidget {
  TaskDetailsScreen({super.key, required this.task})
      : _editController = Get.put(EditTaskController(task: task));
  final Task task;
  final EditTaskController _editController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    MarkAsComplete(
                      onPressed: () => _editController.markAsCompleted(task),
                    ),
                    EditTitleSection(
                        task: task,
                        onPress: () => _editController.onEditIconPressed(task)),
                    EditTimeWidget(
                        pathSvg: IconKeys.timerIcon,
                        task: task,
                        onPressed: () =>
                            _editController.selectDateTime(context)),
                    EditCategoryWidget(
                      pathSvg: IconKeys.tagIcon,
                      text: TranslationKeys.taskCategory,
                      task: task,
                      onPressed: _editController.onCategoryIconPressed,
                    ),
                    Divider(
                      height: Get.height * .1,
                      color: Colors.white,
                    ),
                    ShareTaskWidget(
                      pathSvg: IconKeys.shareIcon,
                      text: TranslationKeys.shareTask,
                      press: () => _editController.sharePressed(task),
                    ),
                    LabeledIconWidget(
                        pathSvg: IconKeys.calendarIcon,
                        text: TranslationKeys.calendar,
                        press: () {
                          Get.to(() => MyCalendarScreen());
                        }),
                    LabeledIconWidget(
                        pathSvg: IconKeys.trashIcon,
                        text: TranslationKeys.deleteTask,
                        color: redColor,
                        press: _editController.showDeleteConfirmationDialog),
                    SizedBox(
                      height: Get.height * .08,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: MyMaterialBotton(
                          onPress: () {
                            _editController.onEditBottonPressed(task);
                            Get.back();
                          },
                          text: TranslationKeys.edit,
                          textColor: Colors.white,
                          bottonColor: primaryColor,
                        ))
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}
