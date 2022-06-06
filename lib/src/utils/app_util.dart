import 'package:package_info/package_info.dart';
import 'package:version/version.dart';
import 'package:launch_review/launch_review.dart';

class AppUtil {

  Future<bool> compareVersion(String version) async {
    var packageInfo = await PackageInfo.fromPlatform();
    Version currentVersion = Version.parse(packageInfo.version);
    Version latestVersion = Version.parse(version);
    return latestVersion > currentVersion;
  }

  Future toAppStore({String iOSAppId = ''}) async {
    var packageInfo = await PackageInfo.fromPlatform();
    LaunchReview.launch(
        androidAppId: packageInfo.packageName, iOSAppId: iOSAppId);
  }

}
