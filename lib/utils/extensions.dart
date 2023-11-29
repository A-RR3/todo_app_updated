import 'package:flutter/material.dart';
import 'package:todo_app_updated/utils/task_status.dart';

extension BuildContextExtensions on BuildContext {
  Size get deviceSize => MediaQuery.sizeOf(this);
}

extension HexColor on Color {
  static Color fromHex(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('0xFF');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ThreeStringEnumExtension on TaskStatus {
  String get taskStatus {
    switch (this) {
      case TaskStatus.all:
        return "All";
      case TaskStatus.completed:
        return "Completed";
      case TaskStatus.today:
        return "Today";
    }
  }
}
