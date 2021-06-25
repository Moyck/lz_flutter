import 'package:lz_flutter/flutter_base.dart';

abstract class DebuggerMainView implements View{

  set appName(String value);
  set packageName(String value);
  set version(String value);
  set buildNumber(String value);

  set system(String value);
  set model(String value);

}