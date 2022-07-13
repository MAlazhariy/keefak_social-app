class NotificationMessageModel {
  late final String senderName;
  late final String senderUId;
  late final String senderMessage;

  NotificationMessageModel({
    required this.senderName,
    required this.senderUId,
    required this.senderMessage,
  });

  NotificationMessageModel.fromJson(Map<String,dynamic> json){
    senderName = json['senderName'];
    senderUId = json['senderUId'];
    senderMessage = json['senderMessage'];
  }

  Map<String, String> toMap(){
    return {
      'type': 'message',
      'senderUId': senderUId,
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'senderName': senderName,
      'senderMessage': senderMessage,
    };
  }
}
