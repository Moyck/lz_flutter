import 'package:injectable/injectable.dart';

import '../../config/database/app_database.dart';
import '../domains/simple_http_request.dart';

@injectable
class SimpleHttpRequestRepository{

  AppDataBase _appDataBase;

  SimpleHttpRequestRepository(this._appDataBase);

  Future save(SimpleHttpRequest simpleHttpRequest) async => _appDataBase.db.simpleHttpRequestDao.insertSimpleHttpRequest(simpleHttpRequest);


  Future delete(SimpleHttpRequest simpleHttpRequest) async => _appDataBase.db.simpleHttpRequestDao.deleteSimpleHttpRequest(simpleHttpRequest);


  Future<List<SimpleHttpRequest>> getAllRequest() async => _appDataBase.db.simpleHttpRequestDao.findAllSimpleHttpRequest();


}