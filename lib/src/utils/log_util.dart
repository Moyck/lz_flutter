import 'dart:developer';
import 'package:stack_trace/stack_trace.dart';


/// Log Util.
class Log {
  static int _maxLen = 128;

  static void d(Object? object, {bool sendToServer = false,int stackFrame = 2}) {
    _printLog(' 🟢 Debug ', object,stackFrame: stackFrame,sendToServer: sendToServer);
  }

  static void e(Object? object, {bool sendToServer = false,int stackFrame = 2}) {
    _printLog(' 🔴 Error ', object,stackFrame: stackFrame,sendToServer: sendToServer);
  }

  static void v(Object? object, {bool sendToServer = false,int stackFrame = 2}) {
    _printLog(' ⚪ Verbose ', object,stackFrame: stackFrame,sendToServer: sendToServer);
  }

  static void w(Object? object, {bool sendToServer = false,int stackFrame = 2}) {
    _printLog(' 🟡 Warn ', object,stackFrame: stackFrame,sendToServer: sendToServer);
  }

  static void _printLog(String stag, Object? object,{bool sendToServer = false,int stackFrame = 2}) {
    final chain = Chain.forTrace(StackTrace.current);
    final frames = chain.toTrace().frames;
    final frame = frames[stackFrame];
    String da = object?.toString() ?? 'null';
    while (da.isNotEmpty) {
      if (da.length > _maxLen) {
        print(' ${da.substring(0, _maxLen)}');
        da = da.substring(_maxLen, da.length);
      } else {
        print('$stag| ${frame.uri}:${frame.line}:${frame.column} | $da');
        da = '';
      }
    }
  }
}