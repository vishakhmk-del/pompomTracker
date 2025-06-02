import 'package:json_annotation/json_annotation.dart';

part 'route_list.g.dart';

@JsonSerializable()
class RouteList {
  @JsonKey(name: 'route_name')
  String? routeName;
  @JsonKey(name: 'route_id')
  String? routeId;
  String? via;
  @JsonKey(name: 'driver_id')
  String? driverId;
  String? name;
  @JsonKey(name: 'conductor_id')
  String? conductorId;
  RouteList(
      {this.routeName,
      this.routeId,
      this.via,
      this.driverId,
      this.name,
      this.conductorId});

  factory RouteList.fromJson(Map<String, dynamic> json) {
    return _$RouteListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RouteListToJson(this);
}
