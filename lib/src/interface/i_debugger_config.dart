import 'dart:io';
import 'package:flutter/cupertino.dart';

abstract class IDebuggerConfig {

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showDebuggerFloatingButton(BuildContext buildContext);

  void startCatchAllException();

}
