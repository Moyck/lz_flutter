import 'package:lz_flutter_app/security/types/domain_primitive/username.dart';
import 'package:lz_flutter_app/security/remote_persistencce/dto/login_request.dart';

import '../../types/domain_primitive/password.dart';

class LoginCommand{

  Password _password;
  Username _username;

  LoginCommand(this._username,this._password);

  void checkValid(){
    _username.valid();
    _password.check();
  }

  LoginRequest toDto() => LoginRequest(_username.username,_password.password);

}