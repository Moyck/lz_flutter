enum SocialLoginExceptionCode {
  loginCancelByUser,
  unknownWrong,
  passwordLengthMore,
  loginWithGoogleError
}

class SocialLoginException implements Exception{
  SocialLoginExceptionCode code;
  String message;

  SocialLoginException(this.code, this.message);

}