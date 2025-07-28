import 'package:json_annotation/json_annotation.dart';

part 'conductor_resp.g.dart';

@JsonSerializable()
class ConductorResp {
  String? status;
  String? message;
  @JsonKey(name: 'emp_id')
  dynamic empId;
  @JsonKey(name: 'flag')
  String? flag;

  ConductorResp({this.status, this.message, this.empId, this.flag});

  factory ConductorResp.fromJson(Map<String, dynamic> json) {
    return _$ConductorRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorRespToJson(this);
}
