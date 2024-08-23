// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_master_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteMasterResp _$RouteMasterRespFromJson(Map<String, dynamic> json) =>
    RouteMasterResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      routeId: (json['route_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RouteMasterRespToJson(RouteMasterResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'route_id': instance.routeId,
    };
