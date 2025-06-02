import 'package:json_annotation/json_annotation.dart';

part 'conductor_resp.g.dart';

@JsonSerializable()
class ConductorResp {
  String? status;
  String? message;
  @JsonKey(name: 'conductor_id')
  dynamic conductorId;
  @JsonKey(name: 'driver_id')
  dynamic driverId;
  @JsonKey(name: 'flag')
  String? flag;

  ConductorResp({this.status, this.message, this.conductorId, this.driverId,this.flag});

  factory ConductorResp.fromJson(Map<String, dynamic> json) {
    return _$ConductorRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorRespToJson(this);
}
