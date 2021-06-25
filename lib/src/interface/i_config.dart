import 'dart:io';

import 'package:lz_flutter/src/interface/i_debugger_config.dart';

import 'i_network_config.dart';
import 'i_resource_config.dart';

abstract class IConfig {

  late IResourceConfig resourceConfig;

  late INetWorkConfig netWorkConfig;

  late IDebuggerConfig debuggerConfig;

}
