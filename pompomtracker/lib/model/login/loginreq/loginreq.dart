import 'package:json_annotation/json_annotation.dart';

part 'loginreq.g.dart';

@JsonSerializable()
class Loginreq {
  @JsonKey(name: 'user_name')
  String? userName;
  String? pwd;

  Loginreq({this.userName, this.pwd});
  Loginreq.req({required this.userName, required this.pwd});

  factory Loginreq.fromJson(Map<String, dynamic> json) {
    return _$LoginreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginreqToJson(this);
}
