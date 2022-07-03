class PublishPostModel {

  late String uId;
  late String name;
  late String userImage;

  // post attributes
  late String text;
  late String postImage;
  late String dateTime;
  late int milSecEpoch;

  PublishPostModel({
    required this.name,
    required this.uId,
    required this.userImage,
    required this.text,
    required this.postImage,
    required this.dateTime,
    required this.milSecEpoch,
  });

  PublishPostModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    uId = json['uId'];
    userImage = json['userImage'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    milSecEpoch = json['milSecEpoch'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'userImage': userImage,
      'text': text,
      'postImage': postImage,
      'dateTime': dateTime,
      'milSecEpoch': milSecEpoch,
    };
  }

}