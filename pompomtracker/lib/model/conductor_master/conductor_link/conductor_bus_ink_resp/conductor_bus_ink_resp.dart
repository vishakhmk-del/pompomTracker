import 'package:json_annotation/json_annotation.dart';

part 'conductor_bus_ink_resp.g.dart';

@JsonSerializable()
class ConductorBusInkResp {
  String? status;
  String? message;
  String? link;

  ConductorBusInkResp({this.status, this.message, this.link});

  factory ConductorBusInkResp.fromJson(Map<String, dynamic> json) {
    return _$ConductorBusInkRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorBusInkRespToJson(this);
}
