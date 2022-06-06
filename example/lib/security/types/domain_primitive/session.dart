import 'package:json_annotation/json_annotation.dart';
import 'package:lz_flutter/flutter_base.dart';

part 'session.g.dart';

@JsonSerializable()
class Session{

  int? id;
  String? accessToken;
  String? refreshToken;
  DateTime? tokenLastUpdateTime;

  Session(
      {this.id,
        this.accessToken,
        this.refreshToken,this.tokenLastUpdateTime});

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  Future<void> save() async => SpUtil.putObject('user', toJson());

}