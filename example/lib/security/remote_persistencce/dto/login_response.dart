
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/security/types/domain_primitive/session.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse{

  int id;
  String token;
  String refreshToken;

  LoginResponse(this.id,this.token,this.refreshToken);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  Session toSession() => Session(id: id,accessToken: token,refreshToken: refreshToken);

}