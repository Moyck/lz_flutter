import 'package:lz_flutter_app/security/types/exception/username_exception.dart';

class Username {

  String username;

  Username(this.username);

  void valid(){
    if(username.length < 8){
      throw UsernameException(UsernameExceptionCode.usernameLengthLess,'username length less than 8');
    }else if(username.length >14 ){
      throw UsernameException(UsernameExceptionCode.usernameLengthMore,'username length more than 14');
    }else if(isNumber(username)){
      throw UsernameException(UsernameExceptionCode.usernameNotValid,'username not valid');
    }
  }

  bool isNumber(String str) {
    final reg = RegExp(r'^-?[0-9]+');
    return reg.hasMatch(str);
  }

}