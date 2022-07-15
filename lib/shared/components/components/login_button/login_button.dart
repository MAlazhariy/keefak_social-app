import 'package:flutter/material.dart';

class LoginWithButton extends StatelessWidget {
  const LoginWithButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.logo,
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final String title;
  final String logo;
  final void Function()? onPressed;
  final Color color;
  final Color textColor;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 6,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/${logo}_logo.png',
              fit: BoxFit.cover,
              height: 33,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
