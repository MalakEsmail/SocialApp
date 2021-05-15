import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/login_cubit/states.dart';
class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialiteState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  

  void userLogin({@required String email, @required String password}) {
   /* emit(SocialLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
     
      loginModel = LoginModel.fromJson(value.data);
      emit(SocialLoginSuccessState(loginModel));
    }).catchError((error) {
      
      emit(SocialLoginErrorState(error.toString()));
    });*/
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePassWordVisibilaty() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityState());
  }
}