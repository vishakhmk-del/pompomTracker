// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteList _$RouteListFromJson(Map<String, dynamic> json) => RouteList(
      routeName: json['route_name'] as String?,
      routeId: json['route_id'] as String?,
      via: json['via'] as String?,
      driverId: json['driver_id'] as String?,
      name: json['name'] as String?,
      conductorId: json['conductor_id'] as String?,
    );

Map<String, dynamic> _$RouteListToJson(RouteList instance) => <String, dynamic>{
      'route_name': instance.routeName,
      'route_id': instance.routeId,
      'via': instance.via,
      'driver_id': instance.driverId,
      'name': instance.name,
      'conductor_id': instance.conductorId,
    };
