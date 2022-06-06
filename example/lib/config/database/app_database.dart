import 'package:injectable/injectable.dart';

import 'my_floor_database.dart';

@singleton
class AppDataBase    {

  late MyFloorDatabase db;

  Future<void> init() async =>
    db = await $FloorMyFloorDatabase.databaseBuilder('app_database.db').build();


}
