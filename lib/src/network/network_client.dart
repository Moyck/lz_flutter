import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../config/config.dart';

class Api {
  static Dio? _dio;

  static Dio getClient() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(baseUrl: Config.getInstance().netWorkConfig.getDomain(),connectTimeout: Config.getInstance().netWorkConfig.getConnectionTimeout()));
      if (Config.getInstance().netWorkConfig.getProxy() != null && Config.getInstance().netWorkConfig.getProxy()!.isNotEmpty){
        (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
          client.findProxy = (uri) {
            return Config.getInstance().netWorkConfig.getProxy()!;
          };
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        };
      }
      _dio!.interceptors.addAll( Config.getInstance().netWorkConfig.getNetWorkInterceptor());
    }
    return _dio!;
  }

  static T getService<T>() => Config.getInstance().netWorkConfig.getRepositories().firstWhere((e) =>  e.runtimeType.toString().replaceAll('_', '') == T.toString());

}
