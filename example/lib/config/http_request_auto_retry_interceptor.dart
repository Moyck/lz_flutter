import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/network/application/http_request_auto_retry_app.dart';
import 'package:lz_flutter_app/network/domains/simple_http_request.dart';


@injectable
class HttpRequestAutoRetryInterceptor extends NetWorkInterceptor{

  HttpRequestAutoRetryApplication _retryNetworkApp;

  HttpRequestAutoRetryInterceptor(this._retryNetworkApp);

 @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    final request = err.requestOptions;
    SimpleHttpRequest record;
    if(err.response == null){   ///没网路的情况下 request不为null
      record =  SimpleHttpRequest(method: request.method,url: request.uri.path,body:  request.data is String ?  request.data : jsonEncode(request.data));
    }else{  ///服务器返回错误
      if(err.response!.statusCode != null && err.response!.statusCode! < 500) {
        return;
      }
      record =  SimpleHttpRequest(method: request.method,url: request.uri.path,body:   jsonEncode(request.data));
    }
    _retryNetworkApp.saveNetworkRecord(record);
  }


}