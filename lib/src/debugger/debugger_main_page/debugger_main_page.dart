import 'package:flutter/material.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter/src/debugger/debugger_exceptions_page/debugger_exceptions_page.dart';
import 'package:lz_flutter/src/debugger/debugger_network_page/debugger_network_page.dart';
import 'debugger_main_presenter.dart';
import 'debugger_main_view.dart';

class DebuggerMainPage extends StatefulWidget {
  @override
  DebuggerMainPageState createState() => DebuggerMainPageState();
}

class DebuggerMainPageState extends BaseState<DebuggerMainPage>
    implements DebuggerMainView {
  DebuggerMainPresenter _presenter = DebuggerMainPresenter();
  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;
  String? system;
  String? model;

  @override
  void initState() {
    super.initState();
    _presenter.bind(this);
    _presenter.init();
  }

  @override
  Widget build(BuildContext context) => packageName == null
      ? Container()
      : Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: double.infinity),
              const Text(
                'LZ Debugger',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const Text('version: 1.2.0'),
              Container(height: 18),
              Card(
                  margin: const EdgeInsets.all(15),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0))),
                  color: Colors.white,
                  elevation: 15,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: const [
                              CircleAvatar(
                                  radius: 6, backgroundColor: Colors.green),
                              Text(' Information',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ],
                          ),
                          Container(height: 10, width: double.infinity),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('App Name:'),
                                  Text('Package Name:'),
                                  Text('Build Number:'),
                                  Text('Build Version:'),
                                  Text('Model:'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(appName ?? ""),
                                  Text(packageName ?? ""),
                                  Text(buildNumber ?? ""),
                                  Text(version ?? ""),
                                  Text(model ?? ""),
                                ],
                              ),
                            ],
                          ),
                          Container(width: double.infinity, height: 5),
                        ],
                      ))),
              Card(
                  margin: const EdgeInsets.all(15),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0))),
                  color: Colors.white,
                  elevation: 15,
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DebuggerExceptionsPage()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Hero(
                                        tag: 'bug_icon',
                                        child: Icon(
                                          Icons.bug_report,
                                          color: Colors.redAccent,
                                        )),
                                    Text(
                                      'Exception',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                            Container(
                                height: 50,
                                width: 1,
                                color: Colors.black.withAlpha(50)),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DebuggerNetworkPage()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Hero(
                                        tag: 'network_icon',
                                        child: Icon(
                                          Icons.network_check,
                                          color: Colors.blueAccent,
                                        )),
                                    Text('Network',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                )),
                          ],
                        )),
                  ))
            ],
          ),
        );
}
