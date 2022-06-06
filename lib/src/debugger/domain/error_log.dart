class ErrorLog{

  String appKey;
  String url;
  String type;
  String content;
  String fileName;
  String selector;
  String stack;
  int timestamp;
  String appVersion;
  String osVersion;
  String device;
  String uid;
  String signature;

  ErrorLog(this.appKey,this.url,this.type,this.content,this.fileName,this.selector,this.stack,this.timestamp,this.appVersion,this.osVersion,this.device,this.uid,this.signature);

  Map<String, dynamic> toJson() => {
    'app_key': appKey,
    'url': url,
    'type':type,
    'content':content,
    'filename':fileName,
    'selector':selector,
    'stack':stack,
    'timestamp': timestamp,
    'app_version': appVersion,
    'os_version': osVersion,
    'device': device,
    'uid': uid,
    'signature': signature
  };


}