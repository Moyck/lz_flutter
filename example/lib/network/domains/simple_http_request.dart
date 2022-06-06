import 'package:lz_flutter/flutter_base.dart';


@entity
class SimpleHttpRequest{

  @PrimaryKey(autoGenerate: true)
  int? id;
  String? method = '';
  String? url = '';
  String? body = '';

  SimpleHttpRequest({this.id,this.method,this.url,this.body});

}