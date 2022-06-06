import 'package:dio/dio.dart';
import 'package:lz_flutter/flutter_base.dart';

class NetWorkInterceptor  extends InterceptorsWrapper{

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    if (err.response?.statusCode == 403 ||
        err.response?.statusCode == 401) {
      await onTokenError(err);
      return;
    }
  }

  Future onTokenError(DioError err) async {
    // retry(err.requestOptions);
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return Api.getClient().request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

}