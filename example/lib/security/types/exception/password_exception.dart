enum PasswordExceptionCode {
  passwordNull,
  passwordLengthLess,
  passwordLengthMore
}

class PasswordException implements Exception {
  PasswordExceptionCode code;
  String message;

  PasswordException(this.code, this.message);
}
