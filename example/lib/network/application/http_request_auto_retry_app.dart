import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/network/domains/simple_http_request.dart';
import 'package:lz_flutter_app/network/repositories/simple_http_request_repository.dart';

@injectable
class HttpRequestAutoRetryApplication {

  SimpleHttpRequestRepository _simpleHttpRequestRepository;
  late Timer? _timer;

  HttpRequestAutoRetryApplication(this._simpleHttpRequestRepository);

  void saveNetworkRecord(SimpleHttpRequest netWorkRecord) => _simpleHttpRequestRepository.save(netWorkRecord);

  void startRetry(int milliSecond){
    assert(milliSecond > 5000,'调用时间不能过短');
    _timer =  Timer.periodic(Duration(milliseconds: milliSecond), (timer) async {
        final httpRequests = await _simpleHttpRequestRepository.getAllRequest();
        for(SimpleHttpRequest httpRequest in httpRequests){
          await Api.getClient().request(  Config.getInstance().netWorkConfig.getDomain() + httpRequest.url!,options: Options(method: httpRequest.method,));
          await _simpleHttpRequestRepository.delete(httpRequest);
        }
    });
  }

  void stopRetry(){
    _timer?.cancel();
  }

}