

abstract class SocialRegisterStates {}

class SocialRegisterInitialiteState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {
  }

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates {}