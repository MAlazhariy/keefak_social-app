
import 'package:flutter/material.dart';
import 'package:shop_app/models/comment_model/comment_model.dart';
import 'package:shop_app/shared/components/components/user_image/user_image.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
    required this.commentModel,
  }) : super(key: key);

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // user image
        Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 8,
          ),
          child: UserImage(
            userImage: commentModel.userImage,
            size: 35,
          ),
        ),
        const SizedBox(width: 11),

        // comment
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[400]!,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            // margin: const EdgeInsets.symmetric(
            //   horizontal: 10,
            //   vertical: 10,
            // ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // name
                Text(
                  commentModel.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                // comment
                Text(
                  commentModel.comment,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 2),
      ],
    );
  }
}
