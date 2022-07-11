class NotificationMessageModel {
  late final String senderName;
  late final String senderUid;
  late final String senderMessage;

  NotificationMessageModel({
    required this.senderName,
    required this.senderUid,
    required this.senderMessage,
  });

  NotificationMessageModel.fromJson(Map<String,dynamic> json){
    senderName = json['senderName'];
    senderUid = json['senderUid'];
    senderMessage = json['senderMessage'];
  }

  Map<String, String> toMap(){
    return {
      'type': 'message',
      'senderUid': senderUid,
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'senderName': senderName,
      'senderMessage': senderMessage,
    };
  }
}
