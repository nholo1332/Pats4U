import 'package:flutter/material.dart';

/// Creates a Widget to represent the months.
class MonthItem extends StatelessWidget {
  final String name;
  final Function onTap;
  final bool isSelected;
  final Color? color;

  const MonthItem({
    required this.name,
    required this.onTap,
    this.isSelected = false,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Text(
        name.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          color: color ?? Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w300,
        ),
      ),
    );
  }
}