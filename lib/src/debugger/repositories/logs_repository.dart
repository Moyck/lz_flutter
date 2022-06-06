import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter/src/debugger/domain/error_log.dart';
import 'package:lz_flutter/src/debugger/domain/request_log.dart';
import 'package:lz_flutter/src/debugger/domain/visitor_log.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class LogsRepository {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Dio dio = Dio(BaseOptions(
      baseUrl: '',
      headers: {"Content-Type": "application/json"}));


  LogsRepository(){
    if (Config.getInstance().netWorkConfig.getProxy() != null && Config.getInstance().netWorkConfig.getProxy()!.isNotEmpty){
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.findProxy = (uri) {
          return Config.getInstance().netWorkConfig.getProxy()!;
        };
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  Future sendVisitorLog() async {
    if(!Config.getInstance().debuggerConfig.needSendToServer()){
      return;
    }
    String osVersion = '';
    String device = '';
    var packageInfo = await PackageInfo.fromPlatform();
    if(Platform.isIOS){
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      osVersion = iosInfo.systemName;
      device = iosInfo.systemVersion;
    }else if(Platform.isAndroid){
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      osVersion = 'Android' + androidInfo.version.sdkInt.toString();
      device = androidInfo.model;
    } //
    var log =  VisitorLog(Config.getInstance().debuggerConfig.getAppID(),'home',0,DateTime.now().millisecondsSinceEpoch,packageInfo.version,osVersion,device,Config.getInstance().debuggerConfig.getId(),'');
    log.signature = generateMd5(log.appKey + log.url + log.timestamp.toString());
    dio.post('/visitor_logs',data: log.toJson());
  }

  Future sendErrorLog(String type,String stack,String content) async {
    if(!Config.getInstance().debuggerConfig.needSendToServer()){
      return;
    }
    String osVersion = '';
    String device = '';
    var packageInfo = await PackageInfo.fromPlatform();
    if(Platform.isIOS){
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      osVersion = iosInfo.systemName;
      device = iosInfo.systemVersion;
    }else if(Platform.isAndroid){
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      osVersion = 'Android' + androidInfo.version.sdkInt.toString();
      device = androidInfo.model;
    } //
    var log =  ErrorLog(Config.getInstance().debuggerConfig.getAppID(),'home',type,content,'','',stack,DateTime.now().millisecondsSinceEpoch,packageInfo.version,osVersion,device,Config.getInstance().debuggerConfig.getId(),'');
    log.signature = generateMd5(log.appKey + log.url + log.timestamp.toString());
    dio.post('/error_logs',data: log.toJson());
  }

  Future sendRequestLog(String url,int code) async {
    if(!Config.getInstance().debuggerConfig.needSendToServer()){
      return;
    }
    String osVersion = '';
    String device = '';
    var packageInfo = await PackageInfo.fromPlatform();
    if(Platform.isIOS){
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      osVersion = iosInfo.systemName;
      device = iosInfo.systemVersion;
    }else if(Platform.isAndroid){
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      osVersion = 'Android' + androidInfo.version.sdkInt.toString();
      device = androidInfo.model;
    } //
    var log =  RequestLog(Config.getInstance().debuggerConfig.getAppID(),url,code,0,DateTime.now().millisecondsSinceEpoch,packageInfo.version,osVersion,device,Config.getInstance().debuggerConfig.getId(),'');
    log.signature = generateMd5(log.appKey + log.url + log.timestamp.toString());
    dio.post('/request_logs',data: log.toJson());
  }

  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data + Config.getInstance().debuggerConfig.getAppSecret());
    var digest = md5.convert(content);
    return digest.toString().toUpperCase();
  }

}
