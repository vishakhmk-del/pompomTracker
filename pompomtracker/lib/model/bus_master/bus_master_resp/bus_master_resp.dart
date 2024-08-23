import 'package:json_annotation/json_annotation.dart';

part 'bus_master_resp.g.dart';

@JsonSerializable()
class BusMasterResp {
  String? status;
  String? message;
  @JsonKey(name: 'bus_id')
  String? busId;

  BusMasterResp(
      {required this.status, required this.message, required this.busId});

  factory BusMasterResp.fromJson(Map<String, dynamic> json) {
    return _$BusMasterRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusMasterRespToJson(this);
}
