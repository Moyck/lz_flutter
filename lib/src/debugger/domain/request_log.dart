class RequestLog{

  String appKey;
  String url;
  int duration;
  int code;
  int timestamp;
  String appVersion;
  String osVersion;
  String device;
  String uid;
  String signature;

  RequestLog(this.appKey, this.url,this.code, this.duration, this.timestamp,
      this.appVersion, this.osVersion, this.device, this.uid, this.signature);

  Map<String, dynamic> toJson() => {
    'app_key': appKey,
    'url': url,
    'duration': duration,
    'code': code,
    'timestamp': timestamp,
    'app_version': appVersion,
    'os_version': osVersion,
    'device': device,
    'uid': uid,
    'signature': signature
  };

}