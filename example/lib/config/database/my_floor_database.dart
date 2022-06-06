import 'package:floor/floor.dart';
import 'package:lz_flutter_app/network/domains/simple_http_request.dart';
import 'package:lz_flutter_app/network/local_persistence/simple_http_request_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import 'dart:async';

part 'my_floor_database.g.dart';

@Database(version: 1, entities: [SimpleHttpRequest])
abstract class MyFloorDatabase extends FloorDatabase {
  SimpleHttpRequestDao get simpleHttpRequestDao;
}
