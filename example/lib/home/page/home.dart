import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/main_common.dart';
import 'package:lz_flutter_app/security/page/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (_scaffoldKey.currentContext != null) {
      Config.getInstance().debuggerConfig.showDebuggerFloatingButton(
          _scaffoldKey.currentContext!); //防止热更新后context销毁 因此需要用GlobalKey
    }
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(onPressed: (){
          routeTo(MaterialPageRoute(builder: (ct) => getIt<LoginPage>()));
        }),
        body: Container(
          alignment: Alignment.center,
          child: InkWell(
              onTap: () {
                Log.e('Exception');
                throw Exception('Test msg');
              },
              child: const Text('Hello World!!!')),
        ));
  }
}
