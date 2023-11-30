import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/colors.dart';
import 'package:todo_app_updated/core/values/icons.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/features/categories/widgets/material_botton.dart';
import 'package:todo_app_updated/features/login/login_controller.dart';
import 'package:todo_app_updated/core/widgets/icon_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key}) : _controller = Get.put(LoginController());

  final LoginController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const Spacer(),
            IconWidget(path: IconKeys.vectorIcon),
            const Spacer(),
            Align(
                heightFactor: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: MyMaterialBotton(
                        onPress: () => _controller.authenticateUser(),
                        text: TranslationKeys.unlockApp,
                        textColor: Colors.white,
                        bottonColor: primaryColor,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
