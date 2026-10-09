import 'package:json_annotation/json_annotation.dart';

part 'deviceinfo.g.dart';

@JsonSerializable()
class Deviceinfo {
  @JsonKey(name: 'user_id')
  dynamic userid;
  dynamic userId;
  String? phone;
  String? devicetoken;
  String? deviceid;
  String? phoneos;
  String? screenresolution;
  String? androidid;
  String? osversion;
  String? packagename;
  String? appversion;
  String? buildnumber;
  String? buildtime;

  Deviceinfo({
    this.userid,
    this.userId,
    this.phone,
    this.devicetoken,
    this.deviceid,
    this.phoneos,
    this.screenresolution,
    this.androidid,
    this.osversion,
    this.packagename,
    this.appversion,
    this.buildnumber,
    this.buildtime,
  });

  factory Deviceinfo.fromJson(Map<String, dynamic> json) {
    return _$DeviceinfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeviceinfoToJson(this);
}
