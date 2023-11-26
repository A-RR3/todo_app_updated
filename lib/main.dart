import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_task1/features/home/screens/home_screen.dart';
import 'package:training_task1/features/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo App',
      theme: ThemeData.dark(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      // home: LoginScreen(),
      home: MyHomePage(),
    );
  }
}
