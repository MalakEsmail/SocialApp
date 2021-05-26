import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/component.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel model;
  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model=UserModel.fromJAson(value.data());
      emit(SocialGetUserSuccessStateState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStateState(error.toString()));
    });
  }
}
