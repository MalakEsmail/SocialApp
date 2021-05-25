class UserModel {
  String name;
  String email;
  String uId;
  String phone;
  UserModel(this.name, this.email, this.phone, this.uId);
  UserModel.fromJAson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
    };
  }
}
