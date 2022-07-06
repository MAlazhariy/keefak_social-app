import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/post_model/post_model.dart';
import 'package:shop_app/shared/components/components/snack_bar.dart';
import 'package:shop_app/shared/components/components/user_image/user_image.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    var postController = TextEditingController();
    postController.text = postModel.text;
    String image = postModel.postImage;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        var cubit = SocialCubit.get(context);

        if (state is SocialEditPostSuccessState) {
          cubit.postImage = null;
          snkBar(
            context: context,
            title: 'Post edited successfully',
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Edit post',
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
                    // todo: test update functions
                    if (cubit.postImage != null) {
                      cubit.editPostWithImage(
                        text: postController.text,
                        postModel: postModel,
                        postId: postModel.postId,
                      );
                    } else {
                      cubit.editPost(
                        text: postController.text.trim(),
                        postImage: image,
                        postId: postModel.postId,
                        postModel: postModel,
                      );
                    }
                  },
                  child: Text('Edit'.toUpperCase()),
                ),
              const SizedBox(width: 5),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (state is SocialEditPostLoadingState ||
                    state is SocialEditPostWithImageLoadingState)
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
                    // name and audience
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
                if (cubit.postImage != null
                    || image.isNotEmpty)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: cubit.postImage != null
                                ? FileImage(cubit.postImage!)
                                : Image.network(image).image,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // close button
                      MaterialButton(
                        onPressed: () {
                          if(image.isNotEmpty){
                            image = '';
                          }
                          // keep it without [else] to emit a new state
                          // and refresh the screen with the new data
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
                          if(image.isNotEmpty){
                            image = '';
                          }
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
