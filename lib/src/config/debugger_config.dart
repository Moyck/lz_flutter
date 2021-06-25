import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lz_flutter/src/debugger/debugger_main_page/debugger_main_page.dart';
import 'package:lz_flutter/src/debugger/domain/lz_flutter_error_detail.dart';
import 'package:lz_flutter/src/interface/i_debugger_config.dart';

List<LZFlutterErrorDetail> flutterErrorDetails = [];

class DebuggerConfig extends IDebuggerConfig {
  OverlayEntry? overlayEntry;
  bool isShow = false;

  @override
  void showDebuggerFloatingButton(BuildContext context) {
    if(!isShow){
      isShow = true;
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        addOverlayEntry(context, MediaQuery.of(context).size.width - 80,
            MediaQuery.of(context).size.height - 80);
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
        builder: (BuildContext buildContext) => Positioned(
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
                            details.offset.dy < 0 ) {
                          addOverlayEntry(
                              context, 80,  80);
                        }else if(  details.offset.dx >
                            MediaQuery.of(context).size.width - 40 ||
                            details.offset.dy >
                                MediaQuery.of(context).size.height - 40){
                          addOverlayEntry(
                              context,  MediaQuery.of(context).size.width - 40,  MediaQuery.of(context).size.height - 40);
                        }else{
                          ///拖动结束
                          addOverlayEntry(
                              context, details.offset.dx, details.offset.dy);
                        }
                      },

                      ///feedback是拖动时跟随手指滑动的Widget。
                      feedback: icon,

                      ///child是静止时显示的Widget，
                      child: showIcon ? icon : Container())),
            ));
    navigatorKey.currentState?.overlay?.insert(overlayEntry!);
  }

  @override
  void startCatchAllException() {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (details) {
      flutterErrorDetails.add(LZFlutterErrorDetail(DateTime.now(),details));
      print(details);
    };
  }

}
