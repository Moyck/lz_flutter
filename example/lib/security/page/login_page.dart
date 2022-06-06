import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'login_presenter.dart';
import 'login_view.dart';

@injectable
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends BaseMVPState<LoginPage, LoginPresenter>
    implements LoginView {

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
        alignment: Alignment.center,
          child: InkWell(onTap: presenter.login, child: const Text('login'))));

  @override
  void active() {
    super.active();
    print('activate');
  }

  @override
  void inactive() {
    super.inactive();
    print('inactive');
  }

  @override
  void invisible() {
    super.invisible();
    print('invisible');
  }

  @override
  void willPop() {
    super.willPop();
    print('willPop');
  }

  @override
  void push() {
    super.push();
    print('push');
  }

}
