import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/core/values/values.dart';
import 'package:todo_app_updated/features/tasks/controllers/add_new_task_controller.dart';
import 'package:todo_app_updated/core/widgets/common_text_field.dart';
import 'package:todo_app_updated/core/widgets/icon_widget.dart';

class AddNewTaskScreen extends StatelessWidget {
  AddNewTaskScreen({super.key})
      : _addTaskController = Get.put(AddNewTaskController());

  final AddNewTaskController _addTaskController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewTaskController>(builder: (_) {
      return BottomSheet(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: greyShadow,
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _addTaskController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      TranslationKeys.addTask,
                      style: textTheme(20, null, null),
                    ),
                    const SizedBox(height: 12),
                    CommonTextField(
                        hintText: TranslationKeys.taskTitlehint,
                        controller: _addTaskController.titleController,
                        validator: (value) =>
                            _addTaskController.validateTitleInput(value)),
                    const SizedBox(height: 12),
                    CommonTextField(
                      hintText: TranslationKeys.taskDescription,
                      controller: _addTaskController.descriptionController,
                      validator: (value) =>
                          _addTaskController.validateDescription(value),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                IconWidget(
                                  path: IconKeys.timerIcon,
                                  press: () => _addTaskController
                                      .selectDateTime(Get.context!),
                                  size: 25,
                                ),
                                IconWidget(
                                  path: IconKeys.tagIcon,
                                  press: () => _addTaskController
                                      .onCategoryIconPressed(),
                                  size: 30,
                                )
                              ],
                            )),
                        IconWidget(
                          path: IconKeys.sendIcon,
                          press: _addTaskController.onSubmitForm,
                          size: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
