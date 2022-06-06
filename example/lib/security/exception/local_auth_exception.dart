enum LocalAuthExceptionCode {
  cantSupportBiometrics,
  noAvailableBiometrics,
}

class LocalAuthException implements Exception {
  LocalAuthExceptionCode code;
  String message;

  LocalAuthException(this.code, this.message);
}
