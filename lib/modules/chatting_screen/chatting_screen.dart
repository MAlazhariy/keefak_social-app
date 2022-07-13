import 'dart:developer';

import 'package:shop_app/helpers/get_formatted_date.dart';
import 'package:shop_app/models/message_model/message_model.dart';
import 'package:shop_app/models/notifications/notification_message_model/notification_message_model.dart';
import 'package:shop_app/models/user_model/user_model.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components/message/message_builder.dart';
import 'package:shop_app/shared/components/components/user_image/user_image.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();

    if (!SocialCubit.get(context).chats.containsKey(user.uId)) {
      SocialCubit.get(context).chats.putIfAbsent(user.uId, () => []);
    }

    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(user.uId);

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  // user image
                  UserImage(
                    userImage: user.image,
                    size: 43,
                  ),
                  const SizedBox(width: 11),
                  // name and bio
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name
                        Row(
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 3),
                            if (user.name == 'Mostafa Alazhariy')
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blueAccent,
                                size: 14.5,
                              ),
                          ],
                        ),
                        // bio
                        Text(
                          user.bio,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 11),
                ],
              ),
              leading: IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                  cubit.navigateToChatsScreen(context);
                },
                icon: const Icon(
                  IconBroken.Arrow___Left,
                ),
              ),
              elevation: 2,
              shadowColor: Colors.grey[200],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // messages ui
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            if (cubit.chats.containsKey(user.uId)) {
                              return MessageBuilder(
                                messageModel: cubit.chats[user.uId]![index],
                              );
                            }
                            return const SizedBox();
                          },
                          itemCount: cubit.chats[user.uId]?.length ?? 0,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          reverse: false,
                        ),
                        const SizedBox(height: 5),
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
                    vertical: 5,
                  ),
                ),

                // send message field
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          minLines: 1,
                          maxLines: 4,
                          onChanged: (value) {
                            cubit.changeSendButtonVisibility(value.trim());
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a message ..',
                          ),
                        ),
                      ),
                      // send button
                      if (cubit.showSendButton)
                        MaterialButton(
                          onPressed: () {
                            // todo: handle send message method
                            var now = DateTime.now();
                            var dateTime = getFormattedDate(now: now);

                            // set message model
                            final _messageModel = MessageModel(
                              dateTime: dateTime,
                              receiverId: user.uId,
                              senderId: uId,
                              message: messageController.text.trim(),
                              milSecEpoch: now.millisecondsSinceEpoch,
                            );

                            // send message via Firebase
                            cubit.sendMessage(_messageModel);

                            // send FCM
                            final _nModel = NotificationMessageModel(
                              senderName: cubit.userModel!.name,
                              senderMessage: messageController.text.trim(),
                              senderUId: cubit.userModel!.uId,
                            );

                            DioHelper.pushFCM(
                              to: user.token,
                              title: _nModel.senderName,
                              body: _nModel.senderMessage,
                              data: _nModel.toMap(),
                            ).then((value) {
                              log('notification sent to ${user.name}');
                            });

                            // reset text field
                            messageController.text = '';
                            cubit.showSendButton = false;
                          },
                          padding: const EdgeInsets.all(8),
                          minWidth: 0,
                          color: Colors.blueAccent,
                          shape: const CircleBorder(),
                          child: const Icon(
                            IconBroken.Send,
                            color: Colors.white,
                            size: 23,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
