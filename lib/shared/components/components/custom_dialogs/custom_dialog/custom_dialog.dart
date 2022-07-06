import 'package:flutter/material.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  List <Widget> buttons = const <Widget>[],
}){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14.5,
          ),
        ),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              content,
            ],
          ),
        ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Wrap(
                  spacing: 4,
                  children: buttons,
                ),
              ),
            ),

          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        );
    },
  );
}