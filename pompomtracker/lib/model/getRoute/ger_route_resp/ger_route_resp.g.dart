// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ger_route_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GerRouteResp _$GerRouteRespFromJson(Map<String, dynamic> json) => GerRouteResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      routeList: (json['route_list'] as List<dynamic>?)
          ?.map((e) => RouteList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GerRouteRespToJson(GerRouteResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'route_list': instance.routeList,
    };
