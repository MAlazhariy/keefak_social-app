import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/chatting_screen/chatting_screen.dart';
import 'package:shop_app/modules/publish_post_screen/publish_post_screen.dart';
import 'package:shop_app/shared/components/components/post_widget/post_widget.dart';
import 'package:shop_app/shared/components/components/push/push.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components/user_image/user_image.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    final cubit = SocialCubit.get(context);

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final userExists = userId == uId ||
            cubit.users.where((user) => user.uId == userId).isNotEmpty;

        if (userExists) {
          final user = userId == uId
              ? cubit.userModel
              : cubit.users.singleWhere((user) => user.uId == userId);

          final userPosts = cubit.posts.where((post) => post.uId == userId).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text(user!.name),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            // cover & profile pic
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                // cover
                                Container(
                                  width: double.maxFinite,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        user.cover,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // profile picture
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 100,
                                  ),
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: UserImage(
                                      userImage: user.image,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 11),
                            // name
                            Container(
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                user.name,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            // bio
                            Container(
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                user.bio,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (user.uId != uId)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              child: Column(
                                children: const [
                                  Icon(IconBroken.Chat),
                                  Text('chat'),
                                ],
                              ),
                              onPressed: () {
                                push(
                                  context,
                                  ChattingScreen(user: user),
                                );
                              },
                            ),
                          ],
                        ),

                      const Divider(),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        padding: const EdgeInsetsDirectional.all(15),
                        child: const Text(
                          'posts',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // user posts
                      ListView.separated(
                        itemBuilder: (context, index) {
                          return PostWidget(
                            postModel: userPosts[index],
                            userImageClickable: false,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: userPosts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        cubit.getAllUsers();
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
