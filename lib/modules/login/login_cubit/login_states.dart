
abstract class SocialLoginStates {}

class SocialLoginInitState extends SocialLoginStates{}
class SocialLoginChangePasswordVisibility extends SocialLoginStates{}
class SocialLoginChangeCounter extends SocialLoginStates{}
class SocialLoginChangeColor extends SocialLoginStates{}
class SocialLoginChangeKeyboardType extends SocialLoginStates{}

class SocialLoginLoading extends SocialLoginStates{}
class SocialLoginError extends SocialLoginStates{
  late final String error;
  SocialLoginError(this.error);
}
class SocialLoginSuccessful extends SocialLoginStates {
  final String uId;

  SocialLoginSuccessful(this.uId);
}

// login with google
class SocialLoginWithGoogleLoading extends SocialLoginStates{}
class SocialLoginWithGoogleError extends SocialLoginStates{
  late final String error;
  SocialLoginWithGoogleError(this.error);
}
class SocialLoginWithGoogleSuccessful extends SocialLoginStates {
  final String uId;

  SocialLoginWithGoogleSuccessful(this.uId);
}

// login with Facebook
class SocialLoginWithFacebookLoading extends SocialLoginStates{}
class SocialLoginWithFacebookError extends SocialLoginStates{
  late final String error;
  SocialLoginWithFacebookError(this.error);
}
class SocialLoginWithFacebookSuccessful extends SocialLoginStates {
  final String uId;

  SocialLoginWithFacebookSuccessful(this.uId);
}