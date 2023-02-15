import 'package:flutter/material.dart';

Future<void> push(
  BuildContext context,
  Widget screen,
) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return screen;
    }),
  );
}
