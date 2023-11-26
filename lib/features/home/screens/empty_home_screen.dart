import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_task1/core/values/constants.dart';

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
                  'assets/images/bg.png',
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
                            "What do you want to do today?\n",
                            style: textTheme(18, null, null),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Tap + to add your tasks",
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
