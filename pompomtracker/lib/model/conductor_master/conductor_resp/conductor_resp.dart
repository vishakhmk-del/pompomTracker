import 'package:json_annotation/json_annotation.dart';

part 'conductor_resp.g.dart';

@JsonSerializable()
class ConductorResp {
  String? status;
  String? message;
  @JsonKey(name: 'conductor_id')
  String? conductorId;

  ConductorResp({this.status, this.message, this.conductorId});

  factory ConductorResp.fromJson(Map<String, dynamic> json) {
    return _$ConductorRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorRespToJson(this);
}
