class NotificationCommentModel {
  late final String senderName;
  late final String senderUId;
  late final String senderComment;
  late final String postId;

  NotificationCommentModel({
    required this.senderName,
    required this.senderUId,
    required this.senderComment,
    required this.postId,
  });

  NotificationCommentModel.fromJson(Map<String,dynamic> json){
    senderName = json['senderName'];
    senderUId = json['senderUId'];
    senderComment = json['senderComment'];
    postId = json['postId'];
  }

  Map<String, String> toMap(){
    return {
      'type': 'comment',
      'senderUId': senderUId,
      'senderName': senderName,
      'senderComment': senderComment,
      'postId': postId,
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    };
  }
}
