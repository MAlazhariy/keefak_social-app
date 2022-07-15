class UserModel {
  late String name;
  late String email;
  late String uId;
  late String phone;
  late String image;
  late String cover;
  late String bio;
  late bool isEmailVerified;
  late String token;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
    token = json['token'];
  }

  // pass by value
  UserModel.cloneFromModel(UserModel model) {
    email = model.email;
    name = model.name;
    phone = model.phone;
    uId = model.uId;
    image = model.image;
    cover = model.cover;
    bio = model.bio;
    isEmailVerified = model.isEmailVerified;
    token = model.token;
  }


  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'uId': uId,
      'phone': phone,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
      'token': token,
    };
  }
}
