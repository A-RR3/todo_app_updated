import 'package:flutter/material.dart';
import 'package:todo_app_updated/core/values/constants.dart';
import 'package:todo_app_updated/domain/entities/categories.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isCompleted;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * .3,
          color: category.color.withOpacity(.3),
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category.icon,
                color: category.color,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                category.name,
                style: textTheme(12, null, null),
              )
            ],
          ),
        );
      }),
    );
  }
}
