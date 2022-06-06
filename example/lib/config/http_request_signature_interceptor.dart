import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/security/application/secutity_application.dart';


@injectable
class HttpRequestSignatureInterceptor extends NetWorkInterceptor{

  SecurityApplication _securityApplication;

  HttpRequestSignatureInterceptor(this._securityApplication);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    options.headers['X-OPENINVITE-SIGNATURE'] = '';
    options.headers['X-OPENINVITE-TIMESTAMP'] = '';
    options.headers['X-OPENINVITE-NONCE'] = '';
    options.headers['X-OPENINVITE-DEVICE-ID'] = '';
  }

  @override
  Future onTokenError(DioError err) => _securityApplication.refreshToken();

}