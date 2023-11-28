import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_task1/core/values/colors.dart';
import 'package:training_task1/core/values/icons.dart';
import 'package:training_task1/core/values/translations_keys.dart';
import 'package:training_task1/features/categories/widgets/material_botton.dart';
import 'package:training_task1/features/login/login_controller.dart';
import 'package:training_task1/core/widgets/icon_widget.dart';

class LoginScreen extends StatelessWidget{
  LoginScreen({super.key}):_controller =Get.put(LoginController());

  final LoginController _controller ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            IconWidget(path: IconKeys.vectorIcon),
            const Spacer(
              flex: 1,
            ),
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
