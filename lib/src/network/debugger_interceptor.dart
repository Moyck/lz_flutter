import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lz_flutter/src/debugger/domain/request_result.dart';
import 'package:lz_flutter/src/network/network_interceptor.dart';
import '../../flutter_base.dart';

List<RequestResult> networkResults = [];

class DebuggerInterceptor extends NetWorkInterceptor {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
      final request = response.requestOptions;
      final requestData = RequestData(request.headers,jsonEncode(request.data));
      final responseData = RequestData(response.headers.map, jsonEncode(response.data));
      networkResults.add(    RequestResult(
          response.statusCode ?? 0, request.method, request.path, DateTime.now(),
          request: requestData, response: responseData));
  }

}