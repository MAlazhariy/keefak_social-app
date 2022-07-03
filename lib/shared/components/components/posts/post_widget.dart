import 'package:flutter/material.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/models/post_model/post_model.dart';
import 'package:shop_app/modules/comments_screen/comments_screen.dart';
import 'package:shop_app/modules/show_post_image_screen/post_image_screen.dart';
import 'package:shop_app/shared/components/components/push/push.dart';
import 'package:shop_app/shared/components/components/user_image/user_image.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final userModel = SocialCubit.get(context).userModel!;

    return Container(
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
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // user details
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // user image
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
          // content
          Text(
            postModel.text,
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),

          // post image
          if (postModel.postImage.isNotEmpty)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowPostImageScreen(
                      image: postModel.postImage,
                    ),
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

          const SizedBox(height: 6),
          // comments and likes details
          Row(
            children: [
              Icon(
                postModel.likes.contains(userModel.uId)
                    ? Icons.favorite
                    : IconBroken.Heart,
                size: 20,
                color: Colors.pink,
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

          // write a comment & like
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // user image
              UserImage(
                userImage: userModel.image,
                size: 35,
              ),
              const SizedBox(width: 11),
              // write a comment
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    push(
                      context,
                      CommentsScreen(postModel: postModel),
                    );
                  },
                  padding: EdgeInsets.zero,
                  minWidth: 0,
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'write a comment ...',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 3),
              // like button
              MaterialButton(
                onPressed: () {
                  SocialCubit.get(context).likePost(postModel: postModel);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // like button
                    Icon(
                      postModel.likes.contains(userModel.uId)
                          ? Icons.favorite
                          : IconBroken.Heart,
                      color: Colors.pink,
                      size: 19,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      postModel.likes.contains(userModel.uId)
                          ? 'liked'
                          : 'like',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
