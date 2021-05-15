import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    /* DioHelper.postData(
        url: REGISTER,
        data: {'name': name,'email': email, 'password': password,'phone': phone,}).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(SocialRegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });*/
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
