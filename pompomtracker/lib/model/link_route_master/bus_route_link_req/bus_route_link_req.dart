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

  BusRouteLinkReq(
      {required this.regNo, required this.routeId, required this.userId});

  factory BusRouteLinkReq.fromJson(Map<String, dynamic> json) {
    return _$BusRouteLinkReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusRouteLinkReqToJson(this);
}
