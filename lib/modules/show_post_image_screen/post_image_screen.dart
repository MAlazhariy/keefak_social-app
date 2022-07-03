
import 'package:flutter/material.dart';

class ShowPostImageScreen extends StatelessWidget {
  const ShowPostImageScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Center(
              child: Image.network(
                image,
                width: double.maxFinite,
                fit: BoxFit.contain,
              ),
            ),
            // close button
            Tooltip(
              message: 'Back',
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                minWidth: 0,
                color: Colors.black45,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                child: const Icon(
                  Icons.close,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
