import 'package:json_annotation/json_annotation.dart';

part 'route_master_resp.g.dart';

@JsonSerializable()
class RouteMasterResp {
  String? status;
  String? message;
  @JsonKey(name: 'route_id')
  int? routeId;

  RouteMasterResp(
      {required this.status, required this.message, required this.routeId});

  factory RouteMasterResp.fromJson(Map<String, dynamic> json) {
    return _$RouteMasterRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RouteMasterRespToJson(this);
}
