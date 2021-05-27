import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/screens/chats_screen.dart';
import 'package:socialapp/screens/feeds_screen.dart';
import 'package:socialapp/screens/setting_screen.dart';
import 'package:socialapp/screens/users_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel model;
  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJAson(value.data());
      emit(SocialGetUserSuccessStateState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStateState(error.toString()));
    });
  }

  List<Widget> pages = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = ['Home', 'Chats', 'Users', 'Settings'];
  int currentIndex = 0;
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(SocialChangeButtomNavState());
  }
}
