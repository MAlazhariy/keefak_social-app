import 'package:flutter/material.dart';
import 'package:shop_app/models/message_model/message_model.dart';

class ReceivedMessageWidget extends StatelessWidget {
  const ReceivedMessageWidget(
    this.model, {
    Key? key,
  }) : super(key: key);

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(11),
            // bottomStart: Radius.circular(11),
            topEnd: Radius.circular(11),
            topStart: Radius.circular(11),
          ),
        ),
        margin: const EdgeInsetsDirectional.only(
          top: 5,
          bottom: 5,
          start: 10,
          end: 55,
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
            ),
            const SizedBox(height: 5),
            Text(
              model.dateTime,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
