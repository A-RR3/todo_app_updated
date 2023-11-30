import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_updated/core/values/translations_keys.dart';
import 'package:todo_app_updated/features/home/controllers/home_controller.dart';
import 'package:todo_app_updated/features/home/screens/home_screen.dart';
import 'package:todo_app_updated/features/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetMaterialApp(
      title: TranslationKeys.appName,
      theme: ThemeData.dark(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
