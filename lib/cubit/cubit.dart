import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  String profileImageURL = '';

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.length}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        print(value);
        profileImageURL = value;
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String coverImageURL = '';

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileCover.path).pathSegments.length}')
        .putFile(profileCover)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        print(value);
        coverImageURL = value;
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUserData(
    @required String name,
    @required String phone,
    @required String bio,
  ) {
    UserModel model = UserModel(
        name: name,
        bio: bio,
        phone: phone,
        isEmailVerified: false,
        image: profileImageURL,
        cover: coverImageURL);

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
}
