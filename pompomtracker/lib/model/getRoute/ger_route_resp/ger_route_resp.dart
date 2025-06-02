import 'package:json_annotation/json_annotation.dart';
import 'package:pompomtracker/model/getRoute/ger_route_resp/emplist/emplist.dart';

import 'route_list.dart';

part 'ger_route_resp.g.dart';

@JsonSerializable()
class GerRouteResp {
  String? status;
  String? message;
  @JsonKey(name: 'route_list')
  List<RouteList>? routeList;
  @JsonKey(name: 'employee_list')
  List<Emplist>? employeeList;

  GerRouteResp({this.status, this.message, this.routeList, this.employeeList});

  factory GerRouteResp.fromJson(Map<String, dynamic> json) {
    return _$GerRouteRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GerRouteRespToJson(this);
}
