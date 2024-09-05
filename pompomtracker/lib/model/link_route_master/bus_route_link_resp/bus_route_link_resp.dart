import 'package:json_annotation/json_annotation.dart';

part 'bus_route_link_resp.g.dart';

@JsonSerializable()
class BusRouteLinkResp {
  String? status;
  String? message;
  @JsonKey(name: 'route_id')
  String? routeId;

  BusRouteLinkResp({this.status, this.message, this.routeId});

  factory BusRouteLinkResp.fromJson(Map<String, dynamic> json) {
    return _$BusRouteLinkRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusRouteLinkRespToJson(this);
}
