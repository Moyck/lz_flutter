import 'package:flutter/material.dart';

import '../manager/local_manager.dart';


extension ExtString on String {

  String resLocal(BuildContext context) =>
      LocalManager.getInstance().local(context,this) ?? this;

  List<String> resStringList(BuildContext context) =>
      LocalManager.getInstance().stringList(context,this) ?? [this];


}
