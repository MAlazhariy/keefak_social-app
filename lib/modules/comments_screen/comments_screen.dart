import 'dart:developer';

import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/helpers/dismiss_keyboard.dart';
import 'package:shop_app/models/notifications/notification_comment_model/notification_comment_model.dart';
import 'package:shop_app/models/post_model/post_model.dart';
import 'package:shop_app/models/user_model/user_model.dart';
import 'package:shop_app/modules/show_post_image_screen/post_image_screen.dart';
import 'package:shop_app/shared/components/components/comment/comment_widget.dart';
import 'package:shop_app/shared/components/components/push/push.dart';
import 'package:shop_app/shared/components/components/user_image/user_image.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({
    required this.postModel,
    Key? key,
  }) : super(key: key);

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = cubit.userModel!;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Comments',
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left,
              ),
            ),
          ),

          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[400]!,
                  blurRadius: 3,
                  offset: const Offset(0, 1.5),
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsetsDirectional.only(
              top: 10,
              start: 15,
              end: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // post & comments
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // user details
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UserImage(
                              userImage: postModel.userImage,
                              size: 50,
                            ),
                            const SizedBox(width: 11),
                            // name and date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // name
                                  Row(
                                    children: [
                                      Text(
                                        postModel.name,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      if (postModel.name == 'Mostafa Alazhariy')
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.blueAccent,
                                          size: 14.5,
                                        ),
                                    ],
                                  ),
                                  Text(
                                    postModel.dateTime,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 3),
                            // icon more
                            Icon(
                              Icons.more_horiz,
                              color: Colors.grey[600],
                              size: 19,
                            ),
                          ],
                        ),
                        const SizedBox(height: 11),
                        // post content
                        Text(
                          postModel.text,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // post image
                        if (postModel.postImage.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              push(
                                context,
                                ShowPostImageScreen(
                                  image: postModel.postImage,
                                ),
                              );
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    postModel.postImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                        const SizedBox(height: 2),

                        // comments and likes number
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.likePost(postModel: postModel);
                              },
                              // padding: EdgeInsets.zero,
                              // minWidth: 0,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              child: Row(
                                children: [
                                  Icon(
                                    postModel.likes.contains(userModel.uId)
                                        ? Icons.favorite
                                        : IconBroken.Heart,
                                    color: Colors.pink,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 3.5),
                                  Text(
                                    postModel.likes.length.toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              IconBroken.Chat,
                              size: 20,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 3.5),
                            Text(
                              '${postModel.comments?.length ?? ''} comments',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        // Divider
                        Container(
                          height: 0.8,
                          width: double.maxFinite,
                          color: Colors.grey[300],
                          margin: const EdgeInsets.symmetric(
                            vertical: 9,
                          ),
                        ),

                        const SizedBox(height: 6),
                        // comments
                        ListView.separated(
                          itemBuilder: (context, index) {
                            return CommentWidget(
                              commentModel: postModel.comments![index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 15);
                          },
                          itemCount: postModel.comments?.length ?? 0,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                        ),

                        const SizedBox(height: 9),
                      ],
                    ),
                  ),
                ),

                // Divider
                Container(
                  height: 0.8,
                  width: double.maxFinite,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(
                    vertical: 1,
                  ),
                ),

                // Send a comment
                Row(
                  children: [
                    UserImage(
                      userImage: userModel.image,
                      size: 35,
                    ),
                    const SizedBox(width: 11),
                    // write a comment
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        minLines: 1,
                        maxLines: 3,
                        onChanged: (value) {
                          cubit.changeSendButtonVisibility(value.trim());
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a comment..',
                        ),
                      ),
                    ),
                    if (cubit.showSendButton)
                      MaterialButton(
                        onPressed: () async {
                          dismissKeyboard(context);
                          // comment
                          cubit.commentOnPost(
                            comment: commentController.text.trim(),
                            postModel: postModel,
                          ).then((value) {
                            commentController.text = '';
                          });

                          /// push FCM to post publisher
                          // check if post publisher is not the current user
                          if(postModel.uId != uId){

                            final _nModel = NotificationCommentModel(
                              senderName: cubit.userModel!.name,
                              senderComment: commentController.text.trim(),
                              senderUId: cubit.userModel!.uId,
                              postId: postModel.postId,
                            );

                            // get user from Firebase if not exists in [users]
                            cubit.getUserIfNotExists(postModel.uId);

                            // push FCM
                            final _user = cubit.users
                                .firstWhere(
                                    (user) => user.uId == postModel.uId);

                            if(token != _user.token && _user.token.isNotEmpty){
                              DioHelper.pushFCM(
                                to: _user.token,
                                title:
                                    '${_nModel.senderName} commented on your post: (${postModel.text.padRight(12, '')}..)',
                                body: 'comment: ${_nModel.senderComment}',
                                data: _nModel.toMap(),
                              ).then((value) {
                                log('notification sent to ${postModel.name}');
                              });
                            }
                          }
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minWidth: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          IconBroken.Send,
                          color: Colors.blueAccent,
                          size: 23,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
