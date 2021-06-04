class UserModel {
  String name;
  String email;
  String uId;
  String image;
  String bio;
  String phone;
  bool isEmailVerified;
  UserModel({this.name, this.email, this.phone, this.uId,this.isEmailVerified,this.image,this.bio});
  UserModel.fromJAson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    bio=json['bio'];
    image=json['image'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'bio':bio,
      'image':image,
      'isEmailVerified': isEmailVerified,
    };
  }
}
