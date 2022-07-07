import 'package:flutter/material.dart';
import 'package:shop_app/modules/user_profile_page/user_profile_page.dart';
import 'package:shop_app/shared/components/components/push/push.dart';

class UserImageTap extends StatelessWidget {
  const UserImageTap({
    Key? key,
    required this.child,
    required this.userId,
    this.enabled = true
  }) : super(key: key);

  final Widget child;
  final String userId;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () {
        push(
          context,
          UserProfileScreen(
            userId: userId,
          ),
        );
      } : null,
      child: child,
    );
  }
}
