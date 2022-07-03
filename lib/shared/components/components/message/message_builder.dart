import 'package:flutter/material.dart';
import 'package:shop_app/models/message_model.dart';
import 'package:shop_app/shared/components/components/message/received_message_widget.dart';
import 'package:shop_app/shared/components/components/message/sent_message_widget.dart';
import 'package:shop_app/shared/components/constants.dart';

/// This widget filters each message and then
/// returns the appropriate widget for the message,
/// either sent or received.

class MessageBuilder extends StatelessWidget {
  const MessageBuilder({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    if (messageModel.senderId == uId) {
      return SentMessageWidget(messageModel);
    }
    return ReceivedMessageWidget(messageModel);
  }
}
