// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/core/values/constants.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';
import 'package:todo_app_updated/domain/entities/task.dart';
import 'category_card.dart';

class TaskItem extends StatelessWidget {
  // const TaskItem({super.key});

  final Task task;
  final VoidCallback? onPressed;
  final VoidCallback? onChackBoxChange;
  final double marginTop;

  const TaskItem({
    super.key,
    required this.task,
    this.onPressed,
    this.onChackBoxChange,
    required this.marginTop,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    Color checkCircleColor() {
      return task.isCompleted ? Colors.blue : Colors.transparent;
    }

    Color checkCircleBorderColor() {
      return task.isCompleted ? Colors.blue : Colors.white;
    }

    IconData? getTheRightIcon() {
      return task.isCompleted ? Icons.check : null;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 90,
          margin: EdgeInsets.only(top: marginTop),
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: greyShadow,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Row(
                        children: [
                          InkWell(
                            onTap: onChackBoxChange,
                            child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: checkCircleColor(),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: checkCircleBorderColor(),
                                    )),
                                child: Icon(getTheRightIcon(), size: 16)),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      )),
                      Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  "${task.title}",
                                  style: textTheme(16, null, null),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Text(
                              "${Get.find<HomeController>().formatDay(task)} ${task.time}",
                              style: textTheme(14, null, null),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FutureBuilder(
                future: controller.getTaskCategory(task.categoryId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CategoryCard(
                        category: snapshot.data!,
                        isCompleted: task.isCompleted);
                  } else {
                    return const Text('no data');
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
