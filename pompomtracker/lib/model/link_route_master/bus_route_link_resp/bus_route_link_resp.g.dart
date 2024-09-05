// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route_link_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusRouteLinkResp _$BusRouteLinkRespFromJson(Map<String, dynamic> json) =>
    BusRouteLinkResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      routeId: json['route_id'] as String?,
    );

Map<String, dynamic> _$BusRouteLinkRespToJson(BusRouteLinkResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'route_id': instance.routeId,
    };
