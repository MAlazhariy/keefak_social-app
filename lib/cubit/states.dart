abstract class SocialStates{}

class SocialInitState extends SocialStates {}

class SocialChangeSendButtonVisibilityState extends SocialStates {}
class SocialChangeBottomNavState extends SocialStates {}

/// get user data
class SocialGetCurrentUserLoadingState extends SocialStates {}
class SocialGetCurrentUserSuccessState extends SocialStates {}
class SocialGetCurrentUserErrorState extends SocialStates {
  final String error;

  SocialGetCurrentUserErrorState(this.error);
}

/// get posts
class SocialGetSinglePostSuccessState extends SocialStates {}
class SocialGetPostsLoadingState extends SocialStates {}
class SocialGetPostsSuccessState extends SocialStates {}
class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}


/// update cover image states
class SocialUpdateCoverSuccessState extends SocialStates {}
class SocialUpdateCoverErrorState extends SocialStates {
  final String error;

  SocialUpdateCoverErrorState(this.error);
}

class SocialUploadCoverLoadingState extends SocialStates {}
class SocialUploadCoverSuccessState extends SocialStates {}
class SocialUploadCoverErrorState extends SocialStates {
  final String error;

  SocialUploadCoverErrorState(this.error);
}

class SocialUpdateFireStoreCoverLoadingState extends SocialStates {}
class SocialUpdateFireStoreCoverSuccessState extends SocialStates {}
class SocialUpdateFireStoreCoverErrorState extends SocialStates {
  final String error;

  SocialUpdateFireStoreCoverErrorState(this.error);
}


/// update profile image states
class SocialUpdateProfileImageSuccessState extends SocialStates {}
class SocialUpdateProfileImageErrorState extends SocialStates {
  final String error;

  SocialUpdateProfileImageErrorState(this.error);
}

class SocialUploadProfileImageLoadingState extends SocialStates {}
class SocialUploadProfileImageSuccessState extends SocialStates {}
class SocialUploadProfileImageErrorState extends SocialStates {
  final String error;

  SocialUploadProfileImageErrorState(this.error);
}

class SocialUpdateFireStoreProfileImageLoadingState extends SocialStates {}
class SocialUpdateFireStoreProfileImageSuccessState extends SocialStates {}
class SocialUpdateFireStoreProfileImageErrorState extends SocialStates {
  final String error;

  SocialUpdateFireStoreProfileImageErrorState(this.error);
}

/// update bio
class SocialUpdateBioLoadingState extends SocialStates {}
class SocialUpdateBioSuccessState extends SocialStates {}
class SocialUpdateBioErrorState extends SocialStates {
  final String error;

  SocialUpdateBioErrorState(this.error);
}

/// create a new post
class SocialTypingPostState extends SocialStates {}

class SocialRemovePostImageSuccessState extends SocialStates {}

class SocialGetPostImageLoadingState extends SocialStates {}
class SocialGetPostImageSuccessState extends SocialStates {}
class SocialGetPostImageErrorState extends SocialStates {
  final String error;

  SocialGetPostImageErrorState(this.error);
}

class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostSuccessState extends SocialStates {}
class SocialCreatePostErrorState extends SocialStates {
  final String error;

  SocialCreatePostErrorState(this.error);
}

class SocialCreatePostWithImageLoadingState extends SocialStates {}
class SocialCreatePostWithImageErrorState extends SocialStates {
  final String error;

  SocialCreatePostWithImageErrorState(this.error);
}

/// edit post
class SocialEditPostLoadingState extends SocialStates {}
class SocialEditPostSuccessState extends SocialStates {}
class SocialEditPostErrorState extends SocialStates {
  final String error;

  SocialEditPostErrorState(this.error);
}

class SocialEditPostWithImageLoadingState extends SocialStates {}
class SocialEditPostWithImageErrorState extends SocialStates {
  final String error;

  SocialEditPostWithImageErrorState(this.error);
}

/// delete post
class SocialDeletePostLoadingState extends SocialStates {}
class SocialDeletePostSuccessState extends SocialStates {}
class SocialDeletePostErrorState extends SocialStates {
  final String error;
  SocialDeletePostErrorState(this.error);
}

/// like post
class SocialLikePostSuccessState extends SocialStates {}
class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

/// comment on a post
class SocialCommentPostSuccessState extends SocialStates {}
class SocialCommentPostErrorState extends SocialStates {
  final String error;

  SocialCommentPostErrorState(this.error);
}

/// logout
class SocialLogoutState extends SocialStates {}

/// get all users
class SocialGetAllUsersLoadingState extends SocialStates {}
class SocialGetAllUsersSuccessState extends SocialStates {}
class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

/// get user
class SocialGetUserLoadingState extends SocialStates {}
class SocialGetUserSuccessState extends SocialStates {}
class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

/// chats
class SocialSendMessageSuccessState extends SocialStates {}
class SocialGetMessagesSuccessState extends SocialStates {}
class SocialSendMessageErrorState extends SocialStates {
  SocialSendMessageErrorState(this.error);
  final String error;
}
