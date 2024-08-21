import 'package:json_annotation/json_annotation.dart';

part 'bus_master_req.g.dart';

@JsonSerializable()
class BusMasterReq {
  @JsonKey(name: 'bus_name')
  String? busName;
  @JsonKey(name: 'sh_name')
  String? shName;
  String? regno;
  @JsonKey(name: 'bus_type')
  String? busType;
  String? permitno;
  String? vfrom;
  String? vto;
  @JsonKey(name: 'user_id')
  String? userId;
  String? active;

  BusMasterReq({
    this.busName,
    this.shName,
    this.regno,
    this.busType,
    this.permitno,
    this.vfrom,
    this.vto,
    this.userId,
    this.active,
  });
  BusMasterReq.req({
    required this.busName,
    required this.shName,
    required this.regno,
    required this.busType,
    required this.permitno,
    required this.vfrom,
    required this.vto,
    required this.userId,
    required this.active,
  });

  factory BusMasterReq.fromJson(Map<String, dynamic> json) {
    return _$BusMasterReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusMasterReqToJson(this);
}
