class RequestResult{

  int stateCode;
  String method;
  String methodName;
  DateTime time;
  RequestData? request;
  RequestData? response;

  RequestResult(this.stateCode,this.method,this.methodName,this.time,{this.request,this.response});

}

class RequestData{
  Map<String,dynamic> header;
  String body;

  RequestData(this.header,this.body);

}
