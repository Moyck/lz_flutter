import 'package:dio/dio.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/security/remote_persistencce/dto/register_request.dart';
import 'package:retrofit/http.dart';
import 'dto/login_request.dart';
import 'dto/login_response.dart';

part 'security_retrofit.g.dart';

@RestApi()
abstract class SecurityRetrofit{

  factory SecurityRetrofit(Dio dio, {String baseUrl}) = _SecurityRetrofit;

  @POST('login')
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @POST('register')
  Future<LoginResponse> register(@Body() RegisterRequest loginRequest);

  @POST('google_sign_in')
  Future<LoginResponse> googleSignIn(@Field() String uid);

  @POST('bind_google_account')
  Future<void> bindGoogleAccount(@Field() String uid);

  @GET('access_token')
  Future<LoginResponse> refreshAccessToken(@Query('token') String token,@Query('refresh_token ') String refreshToken);

}