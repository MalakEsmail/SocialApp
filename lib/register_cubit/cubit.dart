import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/register_cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialiteState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(name: name, email: email, uId: value.user.uid, phone: phone);
      //  emit(SocialRegisterSuccessState());
    }).catchError((error) {
      return emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    @required String name,
    @required String email,
    @required String uId,
    @required String phone,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        image:
            'https://image.freepik.com/free-photo/cheerful-bearded-caucasian-male-with-gentle-smile-dressed-casual-outfit-shows-you-direction-nice-place-indicates-with-thumb-aside_273609-16251.jpg',
        bio: 'write your bio',
        cover: 'https://image.freepik.com/free-vector/engraving-hand-drawn-tropical-leaves-background_23-2148961423.jpg');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePassWordVisibilaty() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
