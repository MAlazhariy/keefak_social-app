
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/publish_post_screen/publish_post_screen.dart';
import 'package:shop_app/shared/components/components/posts/post_widget.dart';
import 'package:shop_app/shared/components/components/push/push.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components/user_image/user_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        // todo: handle this error screen
        if (state is SocialGetPostsErrorState) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(
                fontSize: 23,
              ),
            ),
          );
        }

        if (cubit.userModel != null && cubit.posts.isNotEmpty) {
          return SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  // add a new post
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 5,
                      bottom: 3,
                      start: 10,
                      end: 10,
                    ),
                    child: Row(
                      children: [
                        // user image
                        UserImage(
                          userImage: SocialCubit.get(context).userModel!.image,
                          size: 45,
                        ),
                        const SizedBox(width: 10),

                        // add post
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              push(
                                context,
                                const NewPostScreen(),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 1,
                              ),
                              width: double.maxFinite,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey[400]!,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1.5),
                                  ),
                                ],
                              ),
                              alignment: AlignmentDirectional.centerStart,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 20,
                                ),
                                child: Text(
                                  'What\'s in your mind?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // posts
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return PostWidget(postModel: cubit.posts[index]);
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 8),
                    itemCount: cubit.posts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}