import 'package:lz_flutter_app/security/types/exception/password_exception.dart';

class Password {
  String password;

  Password(this.password);

  void check() {
    if(password == null){
      throw PasswordException(PasswordExceptionCode.passwordNull,'password is null');
    }else if(password.length < 8){
      throw PasswordException(PasswordExceptionCode.passwordLengthLess,'password length less than 8');
    }else if(password.length >14 ){
      throw PasswordException(PasswordExceptionCode.passwordLengthMore,'password length more than 14');
    }
  }

}
