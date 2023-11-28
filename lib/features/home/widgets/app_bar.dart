import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_task1/core/values/translations_keys.dart';
import 'package:training_task1/features/calendar/screens/calendar_screen.dart';
import 'package:training_task1/features/home/controllers/home_controller.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key, this.value})
      : _homeController = Get.find<HomeController>();
  final int? value;
  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  "${TranslationKeys.tasks} ${_homeController.tasksCount}",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const Text(
                TranslationKeys.home,
                style: TextStyle(fontSize: 20),
              ),
              Center(
                child: IconButton(
                  onPressed: () {
                    Get.to(() => MyCalendarScreen());
                  },
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    size: 25,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
