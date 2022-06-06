import 'package:lz_flutter/flutter_base.dart';

class VisitorLog {
  String appKey;
  String url;
  int duration;
  int timestamp;
  String appVersion;
  String osVersion;
  String device;
  String uid;
  String signature;

  VisitorLog(this.appKey, this.url, this.duration, this.timestamp,
      this.appVersion, this.osVersion, this.device, this.uid, this.signature);

  Map<String, dynamic> toJson() => {
        'app_key': appKey,
        'url': url,
        'duration': duration,
        'timestamp': timestamp,
        'app_version': appVersion,
        'os_version': osVersion,
        'device': device,
        'uid': uid,
        'signature': signature
      };
}
