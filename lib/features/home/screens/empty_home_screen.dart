import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/constants.dart';
import 'package:todo_app_updated/core/values/icons.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';

class EmptyHomeScreen extends StatelessWidget {
  const EmptyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: Get.height * .2),
          child: Column(
            children: [
              SizedBox(
                width: Get.width * .4,
                child: Image.asset(
                  IconKeys.background,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${TranslationKeys.whatDoYouWantToDo}\n",
                            style: textTheme(18, null, null),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            TranslationKeys.subHomeText,
                            style: textTheme(16, FontWeight.normal, null),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
