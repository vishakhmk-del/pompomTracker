import 'package:json_annotation/json_annotation.dart';

import 'route_list.dart';

part 'ger_route_resp.g.dart';

@JsonSerializable()
class GerRouteResp {
  String? status;
  String? message;
  @JsonKey(name: 'route_list')
  List<RouteList>? routeList;

  GerRouteResp(
      {required this.status, required this.message, required this.routeList});

  factory GerRouteResp.fromJson(Map<String, dynamic> json) {
    return _$GerRouteRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GerRouteRespToJson(this);
}
