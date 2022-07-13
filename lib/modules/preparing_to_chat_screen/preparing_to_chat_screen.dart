import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/models/notifications/notification_message_model/notification_message_model.dart';
import 'package:shop_app/models/user_model/user_model.dart';
import 'package:shop_app/modules/chatting_screen/chatting_screen.dart';

/// notifications will navigate to this screen
class PreparingToChatScreen extends StatefulWidget {
  const PreparingToChatScreen({
    required this.nModel,
    Key? key,
  }) : super(key: key);

  final NotificationMessageModel nModel;

  @override
  State<PreparingToChatScreen> createState() => _PreparingToChatScreenState();
}

class _PreparingToChatScreenState extends State<PreparingToChatScreen> {
  @override
  void initState() {
    super.initState();

    SocialCubit.get(context)
        .getUserIfNotExists(widget.nModel.senderUId)
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = SocialCubit.get(context);

    if (cubit.userExists(widget.nModel.senderUId)) {
      final UserModel user = cubit.users.firstWhere(
        (user) => user.uId == widget.nModel.senderUId,
      );

      log(user.toMap().toString());

      return ChattingScreen(user: user);
    } else {
      cubit.getUserIfNotExists(widget.nModel.senderUId).then((_) {
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
