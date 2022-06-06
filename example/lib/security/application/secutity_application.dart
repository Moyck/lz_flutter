import 'package:injectable/injectable.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/security/domain/entity/login_command.dart';
import 'package:lz_flutter_app/security/domain/entity/register_command.dart';
import 'package:lz_flutter_app/security/types/domain_primitive/session.dart';
import 'package:lz_flutter_app/security/repositories/security_repository.dart';

@injectable
class SecurityApplication {

  SecurityRepository _securityRepository;

  SecurityApplication(this._securityRepository);

  //账号密码登录
  Future<void> login(LoginCommand loginCommand) async {
    loginCommand.checkValid();
    final loginResponse = await _securityRepository.login(loginCommand);
    loginResponse.toSession().save();
  }

  //注册
  Future<void> register(RegisterCommand registerCommand) async {
    registerCommand.checkValid();
    final loginResponse = await _securityRepository.register(registerCommand);
    loginResponse.toSession().save();
  }

  //登出
  Future<void> logout() async {
    await SpUtil.putObject('user','');
  }

  //刷新token
  Future refreshToken() async {
    final Session session = Session.fromJson(SpUtil.getObject('user') as Map<String, dynamic> );
    await _securityRepository.refreshAccessToken(session);
  }

  Session? getSession(){
    if(SpUtil.getObject('user') == null){
      return null;
    }
    final Session session = Session.fromJson(SpUtil.getObject('user') as Map<String, dynamic> );
    return session;
  }

}
