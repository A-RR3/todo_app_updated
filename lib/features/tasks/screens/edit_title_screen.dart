import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/core/values/constants.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/domain/entities/task.dart';
import 'package:todo_app_updated/features/categories/widgets/material_botton.dart';
import 'package:todo_app_updated/features/tasks/controllers/edit_task_controller.dart';
import 'package:todo_app_updated/core/widgets/common_text_field.dart';

class EditTaskTitle extends StatelessWidget {
  EditTaskTitle({super.key, required this.task})
      : _editController = Get.find<EditTaskController>();
  final Task task;
  final EditTaskController _editController;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      title: const Text(TranslationKeys.editTitle),
      titleTextStyle: textTheme(20, null, null),
      children: [
        SizedBox(
          width: Get.width * .78,
          height: Get.height * .3,
          child: Form(
            key: _editController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CommonTextField(
                  hintText: task.title!,
                  controller: _editController.titleController,
                  validator: (value) =>
                      _editController.validateTitleInput(value),
                ),
                CommonTextField(
                  hintText: task.description!,
                  controller: _editController.descriptionController,
                  validator: (value) =>
                      _editController.validateDescription(value),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyMaterialBotton(
                          onPress: () => Get.back(),
                          text: TranslationKeys.cancel,
                          textColor: primaryColor),
                    ),
                    Expanded(
                      child: MyMaterialBotton(
                        onPress: _editController.onSubmitForm,
                        text: TranslationKeys.edit,
                        textColor: Colors.white,
                        bottonColor: primaryColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
