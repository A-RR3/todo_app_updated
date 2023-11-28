import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_task1/core/values/colors.dart';

const double kDefaultPadding = 20.0;

TextStyle textTheme(double size, FontWeight? weight, Color? color) {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: size,
          fontWeight: weight ?? FontWeight.w400,
          color: color ?? Colors.white));
}

  const List<int> colorsList = [
    category1,
    category2,
    category3,
    category4,
    category5,
    category6,
    category7,
    category8,
    redAccent,
    orangeAccent,
    hotPink,
    lightYellow,
    yellowAccent,
    purple
  ];

    const List<IconData> icons = [
    Icons.work,
    Icons.flight,
    Icons.people,
    Icons.shopping_bag,
    Icons.medical_services,
    Icons.favorite,
    Icons.person,
    Icons.home,
    Icons.food_bank
  ];

