// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:training_task1/features/home/widgets/app_bar.dart';
import 'package:training_task1/features/home/widgets/home_screen_body.dart';
import '../../../core/values/colors.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: MyAppBar(),
      body: HomeBody(),
    );
  }
}
