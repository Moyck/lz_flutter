import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lz_flutter/src/network/network_interceptor.dart';


abstract class INetWorkConfig {

  /**
   * 设置代理 如 'PROXY 192.168.31.136:8888'
   */
  INetWorkConfig setProxy(String? proxy);

  /**
   * 设置Domain地址
   */
  INetWorkConfig setApiDomain(String domain);

  /**
   * 添加网络拦截
   */
  INetWorkConfig addNetWorkInterceptor(List<NetWorkInterceptor> iNetWorkInterceptor);

  String? getProxy();

  String getDomain();

  List<NetWorkInterceptor> getNetWorkInterceptor();

  INetWorkConfig setConnectionTimeout(int timeOut);

  int getConnectionTimeout();

  INetWorkConfig setRepository(List<dynamic> repository);

  List<dynamic> getRepositories();


}
