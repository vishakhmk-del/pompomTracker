import 'package:json_annotation/json_annotation.dart';

part 'bus_route_link_req.g.dart';

@JsonSerializable()
class BusRouteLinkReq {
  @JsonKey(name: 'reg_no')
  String? regNo;
  @JsonKey(name: 'route_id')
  int? routeId;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'old_route_id')
  String? oldRouteId;

  BusRouteLinkReq(
      {required this.regNo,
      required this.routeId,
      required this.userId,
      this.oldRouteId});

  factory BusRouteLinkReq.fromJson(Map<String, dynamic> json) {
    return _$BusRouteLinkReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusRouteLinkReqToJson(this);
}
