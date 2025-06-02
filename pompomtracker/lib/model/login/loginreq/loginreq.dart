import 'package:json_annotation/json_annotation.dart';

part 'loginreq.g.dart';

@JsonSerializable()
class Loginreq {
  @JsonKey(name: 'user_name')
  String? userName;
  String? pwd;
  @JsonKey(name: 'device_model')
  String? phone;
  @JsonKey(name: 'device_id')
  String? deviceid;
  String? phoneos;
  @JsonKey(name: 'android_id')
  String? androidid;
  String? osversion;
  @JsonKey(name: 'app_version')
  String? appversion;
  @JsonKey(name: 'build_number')
  String? buildnumber;

  Loginreq(
      {this.userName,
      this.pwd,
      this.phone,
      this.deviceid,
      this.phoneos,
      this.androidid,
      this.osversion,
      this.appversion,
      this.buildnumber});
  Loginreq.req({required this.userName, required this.pwd});

  factory Loginreq.fromJson(Map<String, dynamic> json) {
    return _$LoginreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginreqToJson(this);
}
