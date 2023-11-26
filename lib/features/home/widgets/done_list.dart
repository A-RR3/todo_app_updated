import 'package:flutter/material.dart';
import 'package:training_task1/core/values/values.dart';

class DoneTasksList extends StatelessWidget {
  const DoneTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Nothing done yet",
      style: textTheme(20, null, null),
    ));
  }
}
