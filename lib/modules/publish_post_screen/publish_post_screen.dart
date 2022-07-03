import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components/snack_bar.dart';
import 'package:shop_app/shared/components/components/user_image/user_image.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postController = TextEditingController();

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        var cubit = SocialCubit.get(context);

        if (state is SocialCreatePostSuccessState) {
          cubit.postImage = null;
          snkBar(
            context: context,
            title: 'Post added successfully',
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add post',
            ),

            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left,
              ),
            ),

            actions: [
              if (postController.text.trim().isNotEmpty || cubit.postImage != null)
                TextButton(
                  onPressed: () {
                    if (cubit.postImage != null) {
                      cubit.createPostWithImage(
                        text: postController.text,
                      );
                    } else {
                      cubit.createNewPost(
                        text: postController.text.trim(),
                      );
                    }
                  },
                  child: Text('post'.toUpperCase()),
                ),
              const SizedBox(width: 5),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState ||
                    state is SocialCreatePostWithImageLoadingState)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    child: LinearProgressIndicator(),
                  ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // user image
                    UserImage(
                      userImage: cubit.userModel!.image,
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
                                cubit.userModel!.name,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 3),
                              if(cubit.userModel!.name == 'Mostafa Alazhariy')
                                const Icon(
                                Icons.check_circle,
                                color: Colors.blueAccent,
                                size: 14.5,
                              ),
                            ],
                          ),
                          const Text(
                            'public',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 3),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value){
                      cubit.typingPost();
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What\'s in your mind?',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // post image
                if (cubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                              cubit.postImage!,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // close button
                      MaterialButton(
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        minWidth: 0,
                        color: Colors.black45,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    // add a photo
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        textColor: Colors.blueAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5),
                            Text('Add a photo'),
                          ],
                        ),
                      ),
                    ),
                    // add hash
                    // Expanded(
                    //   child: MaterialButton(
                    //     onPressed: () {},
                    //     textColor: Colors.blueAccent,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: const [
                    //         Text('#'),
                    //         SizedBox(width: 5),
                    //         Text('Hash'),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
