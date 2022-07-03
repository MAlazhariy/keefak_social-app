import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    Key? key,
    required this.userImage,
    this.size,
  }) : super(key: key);

  final String userImage;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            userImage,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
