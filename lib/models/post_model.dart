class PostModel {
  String name;
  String uId;
  String image;
  String postImage;
  String dateTime;
  String text;
  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.postImage,
    this.dateTime,
  });
  PostModel.fromJAson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
