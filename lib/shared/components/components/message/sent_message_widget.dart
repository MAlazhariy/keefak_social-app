import 'package:flutter/material.dart';
import 'package:shop_app/models/message_model/message_model.dart';

class SentMessageWidget extends StatelessWidget {
  const SentMessageWidget(
    this.model, {
    Key? key,
  }) : super(key: key);

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade200,
          borderRadius: const BorderRadiusDirectional.only(
            // bottomEnd: Radius.circular(8),
            bottomStart: Radius.circular(11),
            topEnd: Radius.circular(11),
            topStart: Radius.circular(11),
          ),
        ),
        margin: const EdgeInsetsDirectional.only(
          top: 5,
          bottom: 5,
          start: 55,
          end: 10,
        ),
        padding: const EdgeInsetsDirectional.only(
          top: 11,
          bottom: 5,
          start: 15,
          end: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // message
            Text(
              model.message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            // time
            Text(
              model.dateTime,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
