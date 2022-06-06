enum UsernameExceptionCode {
  usernameNull,
  usernameLengthLess,
  usernameLengthMore,
  usernameNotValid
}

class UsernameException implements Exception {
  UsernameExceptionCode code;
  String message;

  UsernameException(this.code, this.message);
}