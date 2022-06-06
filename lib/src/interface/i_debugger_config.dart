import 'dart:io';
import 'package:flutter/cupertino.dart';

abstract class IDebuggerConfig {

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showDebuggerFloatingButton(BuildContext buildContext);

  void start(String appID,String appSecret,{bool sendToServer = false});

  void setId(String id);

  String getId();

  String getAppID();

  void setAppID(String id);

  String getAppSecret();

  bool needSendToServer();

}
