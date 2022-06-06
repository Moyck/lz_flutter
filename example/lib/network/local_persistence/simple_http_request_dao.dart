import 'package:floor/floor.dart' as floor;
import 'package:lz_flutter/flutter_base.dart';
import 'package:lz_flutter_app/network/domains/simple_http_request.dart';



@dao
abstract class SimpleHttpRequestDao{

  @floor.Query('SELECT * FROM SimpleHttpRequest')
  Future<List<SimpleHttpRequest>> findAllSimpleHttpRequest();

  @insert
  Future<void> insertSimpleHttpRequest(SimpleHttpRequest request);

  @update
  Future<int> updateSimpleHttpRequests(List<SimpleHttpRequest> request);

  @delete
  Future<int> deleteSimpleHttpRequests(List<SimpleHttpRequest> request);

  @delete
  Future<int> deleteSimpleHttpRequest(SimpleHttpRequest request);

}
