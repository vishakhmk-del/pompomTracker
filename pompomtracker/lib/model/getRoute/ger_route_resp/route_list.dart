import 'package:json_annotation/json_annotation.dart';

part 'route_list.g.dart';

@JsonSerializable()
class RouteList {
  @JsonKey(name: 'route_name')
  String? routeName;
  @JsonKey(name: 'route_id')
  String? routeId;
  String? via;

  RouteList({this.routeName, this.routeId, this.via});

  factory RouteList.fromJson(Map<String, dynamic> json) {
    return _$RouteListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RouteListToJson(this);
}
