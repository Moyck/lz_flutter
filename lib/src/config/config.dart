import 'package:lz_flutter/src/config/debugger_config.dart';

import '../interface/i_config.dart';
import 'network_config.dart';
import 'resource_config.dart';


class Config extends IConfig {
  static IConfig? _instance;

  Config(){
    netWorkConfig = NetWorkConfig();
    resourceConfig = ResourceConfig();
    debuggerConfig = DebuggerConfig();
  }

  static IConfig getInstance() {
    if (_instance == null){
      _instance = Config();
    }
    return _instance!;
  }


}
