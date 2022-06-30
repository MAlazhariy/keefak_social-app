
import 'package:shop_app/modules/comments_screen/comments_screen.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/new_post/new_post_screen.dart';
import 'package:shop_app/shared/components/push.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        if(state is SocialGetPostsErrorState) {
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
          return Column(
            children: [

              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return itemBuilder(context, index-1);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemCount: cubit.posts.length +1,
                ),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget itemBuilder(BuildContext context, int index){
    if(index == -1) {
      return addPostBuilder(context);
    }

    return postBuilder(context, index);
  }

  Widget addPostBuilder(BuildContext context){
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 5,
        bottom: 3,
        start: 10,
        end: 10,
      ),
      child: Row(
        children: [
          // user image
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  SocialCubit.get(context).userModel!.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // add post
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewPostScreen(),
                  ),
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
    );
  }

  Widget postBuilder(BuildContext context, int index) {
    var userModel = SocialCubit.get(context).userModel!;
    var postModel = SocialCubit.get(context).posts[index];

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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      postModel.userImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
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
                        if(postModel.name == 'Mostafa Alazhariy')
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
          // // hashes
          // Wrap(
          //   // crossAxisAlignment: WrapCrossAlignment.start,
          //   alignment: WrapAlignment.start,
          //   direction: Axis.horizontal,
          //   spacing: 5,
          //   children: [
          //     SizedBox(
          //       height: 21.5,
          //       child: MaterialButton(
          //         child: const Text(
          //           '#MAlazhariy',
          //           style: TextStyle(
          //             color: Colors.blueAccent,
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             height: 1.2,
          //           ),
          //         ),
          //         onPressed: () {},
          //         padding: EdgeInsets.zero,
          //         minWidth: 0,
          //         elevation: 0,
          //       ),
          //     ),
          //     SizedBox(
          //       height: 21.5,
          //       child: MaterialButton(
          //         child: const Text(
          //           '#software',
          //           style: TextStyle(
          //             color: Colors.blueAccent,
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             height: 1.2,
          //           ),
          //         ),
          //         onPressed: () {},
          //         padding: EdgeInsets.zero,
          //         minWidth: 0,
          //         elevation: 0,
          //       ),
          //     ),
          //     SizedBox(
          //       height: 21.5,
          //       child: MaterialButton(
          //         child: const Text(
          //           '#flutter',
          //           style: TextStyle(
          //             color: Colors.blueAccent,
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             height: 1.2,
          //           ),
          //         ),
          //         onPressed: () {},
          //         padding: EdgeInsets.zero,
          //         minWidth: 0,
          //         elevation: 0,
          //       ),
          //     ),
          //     SizedBox(
          //       height: 21.5,
          //       child: MaterialButton(
          //         child: const Text(
          //           '#software_developer',
          //           style: TextStyle(
          //             color: Colors.blueAccent,
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             height: 1.2,
          //           ),
          //         ),
          //         onPressed: () {},
          //         padding: EdgeInsets.zero,
          //         minWidth: 0,
          //         elevation: 0,
          //       ),
          //     ),
          //     SizedBox(
          //       height: 21.5,
          //       child: MaterialButton(
          //         child: const Text(
          //           '#flutter_developer',
          //           style: TextStyle(
          //             color: Colors.blueAccent,
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             height: 1.2,
          //           ),
          //         ),
          //         onPressed: () {},
          //         padding: EdgeInsets.zero,
          //         minWidth: 0,
          //         elevation: 0,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 8),
          // post image

          if (postModel.postImage.isNotEmpty)
            Container(
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
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      userModel.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 11),
              // write a comment
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    push(
                      context,
                      CommentsScreen(postIndex: index),
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
                  SocialCubit.get(context).likePost(postIndex: index);
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
