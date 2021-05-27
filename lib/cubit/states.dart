abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingStateState extends SocialStates {}

class SocialGetUserSuccessStateState extends SocialStates {}

class SocialGetUserErrorStateState extends SocialStates {
  final String error;

  SocialGetUserErrorStateState(this.error);
}

class SocialChangeButtomNavState extends SocialStates {}
