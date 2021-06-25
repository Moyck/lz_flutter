import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

import 'debugger_main_view.dart';

class DebuggerMainPresenter {
  late DebuggerMainView _view;
  late PackageInfo packageInfo;

  void bind(DebuggerMainView view){
    _view = view;

  }

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _view.model = iosInfo.systemName + '  ' + iosInfo.systemVersion;
    }else if(Platform.isAndroid){
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _view.model = 'Android' + androidInfo.version.sdkInt.toString() + '  ' + androidInfo.model;
    } // e.g. "iPod7,1"
    _view.appName = packageInfo.appName;
    _view.buildNumber = packageInfo.buildNumber;
    _view.version = packageInfo.version;
    _view.packageName = packageInfo.packageName;
    _view.refresh();
  }


}
