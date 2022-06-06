import 'package:injectable/injectable.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/security/page/login_view.dart';

@injectable
class LoginPresenter extends BaseMvpPresenter<LoginView>{

  Future login() async {
    view.showMsgByToast('login');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


}