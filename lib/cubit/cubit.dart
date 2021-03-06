import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/screens/chats_screen.dart';
import 'package:socialapp/screens/feeds_screen.dart';
import 'package:socialapp/screens/new_post_screen.dart';
import 'package:socialapp/screens/setting_screen.dart';
import 'package:socialapp/screens/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel userModel;
  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJAson(value.data());
      emit(SocialGetUserSuccessStateState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStateState(error.toString()));
    });
  }

  List<Widget> pages = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = ['Home', 'Chats', 'Post', 'Users', 'Settings'];
  int currentIndex = 0;
  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeButtomNavState());
    }
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File profileCover;

  Future<void> getProfileCover() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileCover = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage(
    @required String name,
    @required String phone,
    @required String bio,
  ) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.length}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
            name: name, phone: phone, bio: bio, image: value, cover: null);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage(
    @required String name,
    @required String phone,
    @required String bio,
  ) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileCover.path).pathSegments.length}')
        .putFile(profileCover)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
            name: name, phone: phone, bio: bio, image: null, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  /* void updateUserImages(  @required String name,
    @required String phone,
    @required String bio,
  ) {
    emit(SocialUserUpdateLoadingState());
    if (profileCover != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else if (profileImage != null && profileCover != null) {
    } else {
      updateUser(name, phone, bio);
    }
  }*/

  void updateUser(
      {@required String name,
      @required String phone,
      @required String bio,
      String image,
      String cover}) {
    UserModel model = UserModel(
        name: name,
        bio: bio,
        phone: phone,
        isEmailVerified: false,
        email: userModel.email,
        uId: userModel.uId,
        image: image ?? userModel.image,
        cover: cover ?? userModel.cover);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File postImage;

  Future<void> getPostImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  }) {
    emit(SocialUserCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialUserCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialUserCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    emit(SocialUserCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      image: userModel.image,
      uId: userModel.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialUserCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialUserCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJAson(element.data()));
        }).catchError((error) {});
      });

      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      SocialLikePostErrorState(error.toString());
    });
  }

  List<UserModel> users = [];
  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel.uId)
            users.add(UserModel.fromJAson(element.data()));
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({String receiverId, String dateTime, String text}) {
    MessageModel messageModel = MessageModel(
        text: text,
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: userModel.uId);
    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      SocialSendMessageSuccessState();
    }).catchError((error) {
      SocialSendMessageErrorState();
    });
    // set reveiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      SocialSendMessageSuccessState();
    }).catchError((error) {
      SocialSendMessageErrorState();
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        print(element
        .data().length);
        messages.add(MessageModel.fromJAson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
