import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/security/domain/entity/login_command.dart';
import 'package:lz_flutter_app/security/domain/entity/register_command.dart';
import 'package:lz_flutter_app/security/types/domain_primitive/session.dart';
import 'package:lz_flutter_app/security/remote_persistencce/dto/login_response.dart';
import 'package:lz_flutter_app/security/remote_persistencce/security_retrofit.dart';

@injectable
class SecurityRepository{

  Future<LoginResponse> login(LoginCommand loginData) async => Api.getService<SecurityRetrofit>().login(loginData.toDto());

  Future<LoginResponse> register(RegisterCommand registerData) async => Api.getService<SecurityRetrofit>().register(registerData.toDto());

  Future<LoginResponse> googleSignIn(String uid) async => Api.getService<SecurityRetrofit>().googleSignIn(uid);

  Future<void> bindGoogleAccount(String uid) async => Api.getService<SecurityRetrofit>().bindGoogleAccount(uid);

  Future<void> refreshAccessToken(Session session) async {
    final res = await Api.getService<SecurityRetrofit>().refreshAccessToken(session.accessToken!,session.refreshToken!);
    session.accessToken = res.token;
    session.refreshToken = res.refreshToken;
    session.save();
  }

}