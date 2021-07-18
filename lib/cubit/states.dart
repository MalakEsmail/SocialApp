abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingStateState extends SocialStates {}

class SocialGetUserSuccessStateState extends SocialStates {}

class SocialGetUserErrorStateState extends SocialStates {
  final String error;

  SocialGetUserErrorStateState(this.error);
}

class SocialChangeButtomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

// to pick profile image from gallery
class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

// to pick cover image from gallery

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

// to upload profile image to firebase

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}
// to upload profile cover to firebase

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

// create post
class SocialUserCreatePostLoadingState extends SocialStates {}

class SocialUserCreatePostSuccessState extends SocialStates {}

class SocialUserCreatePostErrorState extends SocialStates {}

// post Iamge
class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

// like post
class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}
