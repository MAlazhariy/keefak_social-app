import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_app/helpers/get_image_name.dart';
import 'package:shop_app/layout/social_layout.dart';
import 'package:shop_app/models/comment_model/comment_model.dart';
import 'package:shop_app/models/message_model/message_model.dart';
import 'package:shop_app/models/post_model/post_model.dart';
import 'package:shop_app/models/post_model/publish_post_model.dart';
import 'package:shop_app/models/user_model/user_model.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/chats_screen/chats_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/modules/settings/update_cover_screen.dart';
import 'package:shop_app/modules/settings/update_profile_image_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components/push/push_and_finish.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/components/components/push/push.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  PublishPostModel? postModel;
  int currentIndex = 0;

  final ImagePicker _picker = ImagePicker();

  File? coverImage;
  File? profileImage;
  File? postImage;

  List<PostModel> posts = [];
  List<UserModel> users = [];
  Map<String, List<MessageModel>?> chats = {};

  bool showSendButton = false;

  List<Widget> screens = [
    const HomeScreen(),
    const ChatsScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Settings',
  ];

  void changeSendButtonVisibility(String text) {
    showSendButton = text.isNotEmpty;
    emit(SocialChangeSendButtonVisibilityState());
  }

  void changeNavBar(int index) {
    if (index == 1 && users.isEmpty) {
      getAllUsers();
    }
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  void navigateToChatsScreen(BuildContext context) {
    currentIndex = 1;
    pushAndFinish(
      context,
      const SocialLayout(),
    );
  }

  Future<void> getCoverImage(BuildContext context) async {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      coverImage = File(value!.path);
      emit(SocialUpdateCoverSuccessState());
      push(
        context,
        const UpdateCoverScreen(),
      );
    }).catchError((error) {
      log('error when updateCoverImage: ${error.toString()}');
      emit(SocialUpdateCoverErrorState(error.toString()));
    });
  }

  Future<void> uploadCoverImage() async {
    if (coverImage != null) {
      emit(SocialUploadCoverLoadingState());

      // upload coverImage to Firestore Storage
      FirebaseStorage.instance
          .ref('users/$uId/coverImage')
          .putFile(coverImage!)
          .then((value) {
        // get cover url
        value.ref.getDownloadURL().then((coverUrl) {
          // update in model
          userModel!.cover = coverUrl;

          // update in Firebase user data
          // emit(SocialUpdateFireStoreCoverLoadingState());

          FirebaseFirestore.instance
              .collection('users')
              .doc(uId)
              .update(userModel!.toMap())
              .then((_) {
            emit(SocialUpdateFireStoreCoverSuccessState());
          }).catchError((error) {
            log('error when uploadCoverImage: ${error.toString()}');
            emit(SocialUpdateFireStoreCoverErrorState(error.toString()));
          });
        }).catchError((error) {
          log('error when getDownloadURL inside uploadCoverImage: ${error.toString()}');
        });
      }).catchError((error) {
        log('error when uploadCoverImage: ${error.toString()}');
        emit(SocialUploadCoverErrorState(error.toString()));
      });
    } else {
      log('coverImage is NULL !');
    }
  }

  Future<void> getProfileImage(BuildContext context) async {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      profileImage = File(value!.path);
      emit(SocialUpdateProfileImageSuccessState());
      push(
        context,
        const UpdateProfileImageScreen(),
      );
    }).catchError((error) {
      log('error when updateProfileImage: ${error.toString()}');
      emit(SocialUpdateProfileImageErrorState(error.toString()));
    });
  }

  Future<void> uploadProfileImage() async {
    if (profileImage != null) {
      emit(SocialUploadProfileImageLoadingState());

      // upload profileImage to Firestore Storage
      FirebaseStorage.instance
          .ref('users/$uId/profileImage')
          .putFile(profileImage!)
          .then((value) {
        // get cover url
        value.ref.getDownloadURL().then((profileUrl) {
          // update in model
          userModel!.image = profileUrl;

          // update in Firebase user data
          // emit(SocialUpdateFireStoreProfileImageLoadingState());

          FirebaseFirestore.instance
              .collection('users')
              .doc(uId)
              .update(userModel!.toMap())
              .then((_) {
            emit(SocialUpdateFireStoreProfileImageSuccessState());
          }).catchError((error) {
            log('error when uploadProfileImage: ${error.toString()}');
            emit(SocialUpdateFireStoreProfileImageErrorState(error.toString()));
          });
        }).catchError((error) {
          log('error when getDownloadURL inside uploadProfileImage: ${error.toString()}');
        });
      }).catchError((error) {
        log('error when uploadProfileImageImage: ${error.toString()}');
        emit(SocialUploadProfileImageErrorState(error.toString()));
      });
    } else {
      log('profileImage is NULL !');
    }
  }

  Future<void> updateBio(String bio) async {
    emit(SocialUpdateBioLoadingState());

    final String _oldBio = userModel!.bio;

    // update bio in userModel
    userModel!.bio = bio;

    // update bio in Firebase
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(userModel!.toMap())
        .then((value) {
      emit(SocialUpdateBioSuccessState());
    }).catchError((error) {
      log('error when updateBio: ${error.toString()}');
      userModel!.bio = _oldBio;
      emit(SocialUpdateBioErrorState(error.toString()));
    });
  }

  /// create a new post methods
  Future<void> getPostImage() async {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      postImage = File(value!.path);
      emit(SocialGetPostImageSuccessState());
    }).catchError((error) {
      log('error when getPostImage: ${error.toString()}');
      emit(SocialGetPostImageErrorState(error.toString()));
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessState());
  }

  Future<void> createPostWithImage({
    required String text,
  }) async {
    emit(SocialCreatePostWithImageLoadingState());

    // upload profileImage to Firestore Storage
    FirebaseStorage.instance
        .ref('users/$uId/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      // get image url
      value.ref.getDownloadURL().then((url) {
        createNewPost(
          text: text,
          postImage: url,
        );
      }).catchError((error) {
        emit(SocialCreatePostWithImageErrorState(error.toString()));
        log('error when getDownloadURL inside createPostWithImage: ${error.toString()}');
      });
    }).catchError((error) {
      emit(SocialCreatePostWithImageErrorState(error.toString()));
      log('error when createPostWithImage: ${error.toString()}');
    });
  }

  void typingPost() {
    emit(SocialTypingPostState());
  }

  Future<void> createNewPost({
    required String text,
    String postImage = '',
  }) async {
    if (postImage.isEmpty) emit(SocialCreatePostLoadingState());

    var now = DateTime.now();

    // create postModel
    postModel = PublishPostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      userImage: userModel!.image,
      text: text,
      postImage: postImage,
      // january 21, 2021 at 11:00 pm
      dateTime: DateFormat('MMMM dd, yyyy - hh:mm aa')
          .format(now)
          .replaceAll('-', 'at'),
      milSecEpoch: now.millisecondsSinceEpoch,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel!.toMap())
        .then((value) {
      log('post id = ${value.id}');
      // add post
      posts.insert(
        0,
        PostModel.fromJson(
          json: postModel!.toMap(),
          postId: value.id,
          likes: [],
          comments: [],
        ),
      );
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      log('error when createNewPost: ${error.toString()}');
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  /// edit post methods
  Future<void> editPostWithImage({
    required String text,
    required String postId,
    required PostModel postModel,
  }) async {
    emit(SocialEditPostWithImageLoadingState());

    log('edit with image');

    final imageName = postModel.postImage.isNotEmpty
        ? getImageName(postModel.postImage)
        : Uri.file(postImage!.path).pathSegments.last;

    // upload profileImage to Firestore Storage
    FirebaseStorage.instance
        .ref('users/$uId/$imageName')
        .putFile(postImage!)
        .then((value) {
      // get image url
      value.ref.getDownloadURL().then((url) {
        editPost(
          text: text,
          postImage: url,
          postId: postId,
          postModel: postModel,
        );
      }).catchError((error) {
        emit(SocialEditPostWithImageErrorState(error.toString()));
        log('error when getDownloadURL inside EditPostWithImage: ${error.toString()}');
      });
    }).catchError((error) {
      emit(SocialCreatePostWithImageErrorState(error.toString()));
      log('error when editPostWithImage: ${error.toString()}');
    });
  }

  Future<void> editPost({
    required String text,
    String postImage = '',
    required String postId,
    required PostModel postModel,
  }) async {
    if (postImage.isEmpty) {
      emit(SocialEditPostLoadingState());
      log('post image is empty');
    }

    log('edit post');

    FirebaseFirestore.instance.collection('posts').doc(postId).update({
      'text': text,
      'postImage': postImage,
    }).then((value) {
      // update changes on post model (copy by reference)
      postModel.text = text;
      postModel.postImage = postImage;

      emit(SocialEditPostSuccessState());
    }).catchError((error) {
      log('error when editPost: ${error.toString()}');
      emit(SocialEditPostErrorState(error.toString()));
    });
  }

  /// delete post
  Future<void> deletePost({
    required PostModel postModel,
  }) async {
    emit(SocialDeletePostLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .delete()
        .then((value) {
      // update changes on post model
      // todo: check this method is it works good?
      posts.remove(postModel);

      emit(SocialDeletePostSuccessState());
    }).catchError((error) {
      log('error when deletePost: ${error.toString()}');
      emit(SocialDeletePostErrorState(error.toString()));
    });
  }

  void getPosts() {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('milSecEpoch', descending: true)
        .get()
        .then((value) async {
          posts = [];

      for (int i = 0; i < value.docs.length; i++) {
        var postDoc = value.docs[i];

        log(postDoc.data()['text']);

        // get likes
        await postDoc.reference
            .collection('likes')
            .where('like', isEqualTo: true)
            .get()
            .then((likeValue) {
          posts.add(
            PostModel.fromJson(
              json: postDoc.data(),
              postId: postDoc.id,
              likes: likeValue.docs.map((e) => e.id).toList(),
            ),
          );
        }).catchError((error) {
          log('error when get post likes: ${error.toString()}');
        });

        // get comments
        await postDoc.reference
            .collection('comments')
            .orderBy('milSecEpoch', descending: false)
            .get()
            .then((commentValue) {
          posts[i].comments = [];

          for (var commentDoc in commentValue.docs) {
            posts[i].comments!.add(
                  CommentModel(
                    comment: commentDoc.data()['comment'],
                    uId: commentDoc.data()['uId'],
                    name: commentDoc.data()['name'],
                    userImage: commentDoc.data()['userImage'],
                    milSecEpoch: commentDoc.data()['milSecEpoch'],
                  ),
                );
          }
        }).catchError((error) {
          log('error when get post comments: ${error.toString()}');
        });

        emit(SocialGetSinglePostSuccessState());
      }
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      log('error when getPosts: ${error.toString()}');
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  Future<PostModel?> getPost(String postId) async {
    // return post if it exists
    final index = posts.indexWhere((post) => post.postId == postId);
    if (index != -1) {
      return posts[index];
    }

    // get post from Firebase if not exists
    PostModel? model;

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((postDoc) async {
      // get likes
      await postDoc.reference
          .collection('likes')
          .where('like', isEqualTo: true)
          .get()
          .then((likeValue) {
        model = PostModel.fromJson(
          json: postDoc.data()!,
          postId: postDoc.id,
          likes: likeValue.docs.map((e) => e.id).toList(),
        );
      }).catchError((error) {
        log('error when get post likes: ${error.toString()}');
      });

      // get comments
      await postDoc.reference
          .collection('comments')
          .orderBy('milSecEpoch', descending: false)
          .get()
          .then((commentValue) {
        model!.comments = [];

        for (var commentDoc in commentValue.docs) {
          model!.comments!.add(
            CommentModel(
              comment: commentDoc.data()['comment'],
              uId: commentDoc.data()['uId'],
              name: commentDoc.data()['name'],
              userImage: commentDoc.data()['userImage'],
              milSecEpoch: commentDoc.data()['milSecEpoch'],
            ),
          );
        }
      }).catchError((error) {
        log('error when get post comments: ${error.toString()}');
      });

      emit(SocialGetSinglePostSuccessState());

      return model;
    });

    return null;
  }

  Future<void> likePost({
    required PostModel postModel,
  }) async {
    String postId = postModel.postId;
    bool isLiked = postModel.likes.contains(userModel!.uId);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': !isLiked,
    }).then((_) {
      if (isLiked) {
        postModel.likes.remove(userModel!.uId);
      } else {
        postModel.likes.add(userModel!.uId);
      }

      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      log('error when likePost: ${error.toString()}');
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  Future<void> commentOnPost({
    required String comment,
    required PostModel postModel,
  }) async {
    var commentModel = CommentModel(
      comment: comment,
      uId: userModel!.uId,
      name: userModel!.name,
      userImage: userModel!.image,
      milSecEpoch: DateTime.now().millisecondsSinceEpoch,
    );

    // upload comment in Firebase
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .collection('comments')
        .doc()
        .set(commentModel.toMap())
        .then((_) {
      // add comment to post model
      postModel.comments!.add(commentModel);
      showSendButton = false;
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      log('error when commentPost: ${error.toString()}');
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  void logout(BuildContext context) {
    CacheHelper.removeSocialUId();
    uId = '';
    pushAndFinish(
      context,
      SocialLoginScreen(),
    );
    emit(SocialLogoutState());
  }

  Future<void> getAllUsers() async {
    emit(SocialGetAllUsersLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) async {
      for (var user in value.docs) {
        if (user.id != uId) {
          users.add(
            UserModel.fromJson(
              user.data(),
            ),
          );
        }
      }
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      log('error when getAllUsers: ${error.toString()}');
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  Future<void> getCurrentUserData() async {
    emit(SocialGetCurrentUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      // log(userModel.toMap().toString());
      emit(SocialGetCurrentUserSuccessState());
    }).catchError((error) {
      log('error when getUserData: ${error.toString()}');
      emit(SocialGetCurrentUserErrorState(error.toString()));
    });
  }

  bool userExists(String uId) {
    return users.where((user) => user.uId == uId).isNotEmpty;
  }

  Future<void> getUser({
    required String userId,
  }) async {
    emit(SocialGetUserLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((user) {
      log(user.data().toString());

      users.add(
        UserModel.fromJson(
          user.data()!,
        ),
      );
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      log('error when getUser: ${error.toString()}');
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  Future<void> getUserIfNotExists(String uId) async {
    if (!userExists(uId)) {
      getUser(userId: uId);
    } else {
      emit(SocialGetUserSuccessState());
    }
  }

  void sendMessage(MessageModel messageModel) {
    // add to my collection
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(messageModel.receiverId)
        .collection('messages')
        .doc()
        .set(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    // add to receiver collection
    FirebaseFirestore.instance
        .collection('users')
        .doc(messageModel.receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .doc()
        .set(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  void getMessages(String receiverId) {
    // get from my collection
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('milSecEpoch')
        .snapshots()
        .listen((event) {
      chats[receiverId] = [];
      for (var doc in event.docs) {
        var model = MessageModel.fromJson(doc.data());

        chats.update(
          receiverId, // message id
          (value) {
            if (value != null) {
              value.add(model);
              return value;
            } else {
              return [model];
            }
          },
          ifAbsent: () => [model],
        );
      }
      emit(SocialGetMessagesSuccessState());
    });
  }
}
