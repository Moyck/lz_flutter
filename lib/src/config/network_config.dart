import 'dart:io';
import 'package:dio/src/dio.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter/src/network/debugger_interceptor.dart';
import '../interface/i_network_config.dart';


class NetWorkConfig extends INetWorkConfig {
  List<NetWorkInterceptor> _netWorkInterceptor = [];
  String _domain = '';
  String? _proxy = '';
  int _connectionTimeout = 30 * 1000;
  List<dynamic> _repositories = [];

  @override
  INetWorkConfig addNetWorkInterceptor(List<NetWorkInterceptor> netWorkInterceptors) {
    _netWorkInterceptor.addAll(netWorkInterceptors);
    return this;
  }

  @override
  String getDomain() => _domain;

  @override
  List<NetWorkInterceptor> getNetWorkInterceptor() => _netWorkInterceptor;

  @override
  String? getProxy() => _proxy;

  @override
  INetWorkConfig setApiDomain(String domain) {
    _domain = domain;
    return this;
  }

  @override
  INetWorkConfig setProxy(String? proxy) {
    _proxy = proxy;
    return this;
  }


  @override
  int getConnectionTimeout() => _connectionTimeout;

  @override
  INetWorkConfig setConnectionTimeout(int connectionTimeout) {
    _connectionTimeout = connectionTimeout;
    return this;
  }

  @override
  List getRepositories() => _repositories;

  @override
  INetWorkConfig setRepository(List<dynamic> repositories) {
    _repositories = repositories;
    return this;
  }


}
