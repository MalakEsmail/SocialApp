class UserModel {
  String name;
  String email;
  String uId;
  String image;
  String bio;
  String cover;
  String phone;
  bool isEmailVerified;
  UserModel({this.name, this.email, this.phone, this.uId,this.isEmailVerified,this.image,this.bio,this.cover});
  UserModel.fromJAson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    bio=json['bio'];
    cover=json['cover'];
    image=json['image'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'cover':cover,
      'bio':bio,
      'image':image,
      'isEmailVerified': isEmailVerified,
    };
  }
}
