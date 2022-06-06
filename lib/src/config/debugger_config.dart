import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter/src/debugger/debugger_main_page/debugger_main_page.dart';
import 'package:lz_flutter/src/debugger/domain/lz_flutter_error_detail.dart';
import 'package:lz_flutter/src/interface/i_debugger_config.dart';
import 'package:lz_flutter/src/network/debugger_interceptor.dart';

List<LZFlutterErrorDetail> flutterErrorDetails = [];

class DebuggerConfig extends IDebuggerConfig {
  OverlayEntry? overlayEntry;
  bool isShow = false;
  String? id;
  late String appKey;
  late String appSecret;
  late bool sendToServer;

  @override
  void showDebuggerFloatingButton(BuildContext context) {
    if (!isShow) {
      isShow = true;
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        addOverlayEntry(context, MediaQuery
            .of(context)
            .size
            .width - 80,
            MediaQuery
                .of(context)
                .size
                .height - 80);
      });
    }
  }

  Future addOverlayEntry(BuildContext context, double left, double top) async {
    var showIcon = true;
    overlayEntry?.remove();
    var icon = FloatingActionButton(
        heroTag: null,
        mini: true,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DebuggerMainPage();
          }));
        },
        child: Icon(Icons.bug_report, color: Colors.blueAccent),
        backgroundColor: Colors.white);
    overlayEntry = OverlayEntry(
        builder: (BuildContext buildContext) =>
            Positioned(
              top: top,
              left: left,
              child: GestureDetector(
                  onTap: () async {},
                  child: Draggable(
                      onDragStarted: () {
                        showIcon = false;
                      },
                      onDragEnd: (DraggableDetails details) {
                        if (details.offset.dx < 0 ||
                            details.offset.dy < 0) {
                          addOverlayEntry(
                              context, 80, 80);
                        } else if (details.offset.dx >
                            MediaQuery
                                .of(context)
                                .size
                                .width - 40 ||
                            details.offset.dy >
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height - 40) {
                          addOverlayEntry(
                              context, MediaQuery
                              .of(context)
                              .size
                              .width - 40, MediaQuery
                              .of(context)
                              .size
                              .height - 40);
                        } else {
                          addOverlayEntry(
                              context, details.offset.dx, details.offset.dy);
                        }
                      },
                      feedback: icon,
                      child: showIcon ? icon : Container())),
            ));
    navigatorKey.currentState?.overlay?.insert(overlayEntry!);
  }

  @override
  void start(String appID, String appSecret, {bool sendToServer = false}) {
    WidgetsFlutterBinding.ensureInitialized();
    this.sendToServer = sendToServer;
    this.appKey = appID;
    this.appSecret = appSecret;
    Config.getInstance().netWorkConfig.addNetWorkInterceptor([DebuggerInterceptor()]);
    FlutterError.onError = (details) {
      flutterErrorDetails.add(LZFlutterErrorDetail(DateTime.now(), details));
      print(details);
    };
  }

  @override
  void setId(String id) {
    this.id = id;
  }

  @override
  String getId() {
    return id ?? '';
  }

  @override
  String getAppID() {
    return appKey;
  }

  @override
  void setAppID(String id) {
    appKey = id;
  }

  @override
  String getAppSecret() {
    return appSecret;
  }

  @override
  bool needSendToServer() {
    return sendToServer;
  }

}
