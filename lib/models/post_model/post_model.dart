import 'package:shop_app/models/comment_model/comment_model.dart';
import 'package:shop_app/models/post_model/publish_post_model.dart';

class PostModel extends PublishPostModel {
  final String postId;

  /// uIds of users who liked the post
  List<String> likes = [];

  List<CommentModel>? comments;


  PostModel({
    required String name,
    required String uId,
    required String userImage,
    required String text,
    required String postImage,
    required String dateTime,
    required int milSecEpoch,
    required this.postId,
    required this.likes,
    this.comments,
  }): super(
    name: name,
    uId: uId,
    userImage: userImage,
    text: text,
    postImage: postImage,
    dateTime: dateTime,
    milSecEpoch: milSecEpoch,
  );

  PostModel.fromJson({
    required Map<String, dynamic> json,
    required this.postId,
    required this.likes,
    this.comments,
  }) : super.fromJson(json);

}