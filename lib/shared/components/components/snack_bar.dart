import 'package:flutter/material.dart';

void snkBar({
  required BuildContext context,
  required String title,
  Color? snackColor,
  Color? titleColor,
  int seconds = 3,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      title,
      style: TextStyle(
        color: titleColor,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: snackColor,
    duration: Duration(seconds: seconds),
  ));
}
