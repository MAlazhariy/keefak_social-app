import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/social_layout.dart';
import 'package:shop_app/models/notifications/notification_comment_model/notification_comment_model.dart';
import 'package:shop_app/models/notifications/notification_message_model/notification_message_model.dart';
import 'package:shop_app/models/post_model/post_model.dart';
import 'package:shop_app/models/user_model/user_model.dart';
import 'package:shop_app/modules/chatting_screen/chatting_screen.dart';
import 'package:shop_app/modules/comments_screen/comments_screen.dart';
import 'package:shop_app/shared/components/components/push/push.dart';
import 'package:shop_app/shared/components/components/push/push_and_finish.dart';

/// notifications will navigate to this screen
class PreparingToPostScreen extends StatefulWidget {
  const PreparingToPostScreen({
    required this.nModel,
    Key? key,
  }) : super(key: key);

  final NotificationCommentModel nModel;

  @override
  State<PreparingToPostScreen> createState() => _PreparingToPostScreenState();
}

class _PreparingToPostScreenState extends State<PreparingToPostScreen> {
  late final PostModel? post;

  @override
  void initState() {
    super.initState();

    SocialCubit.get(context).getPost(widget.nModel.postId).then((value) {
      // if(value != null){
      //   push(
      //     context,
      //     CommentsScreen(postModel: value),
      //   );
      // }

      setState(() {
        post = value;
        log('post model get');
      });
    }).catchError((error) {
      pushAndFinish(
        context,
        const SocialLayout(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (post != null) {
        return CommentsScreen(postModel: post!);
      }
    } catch (e) {}

    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
