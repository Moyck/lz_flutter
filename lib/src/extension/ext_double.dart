import '../utils/screen_util.dart';

extension ExtDouble on  double {

  double toAdapterSize() => ScreenUtil.getInstance().getAdapterSize(this);

}