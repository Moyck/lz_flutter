import '../utils/screen_util.dart';

extension ExtInt on  int {

  double toAdapterSize() => ScreenUtil.getInstance().getAdapterSize(toDouble());

}