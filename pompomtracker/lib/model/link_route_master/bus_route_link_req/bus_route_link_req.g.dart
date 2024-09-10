// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route_link_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusRouteLinkReq _$BusRouteLinkReqFromJson(Map<String, dynamic> json) =>
    BusRouteLinkReq(
      regNo: json['reg_no'] as String?,
      routeId: (json['route_id'] as num?)?.toInt(),
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$BusRouteLinkReqToJson(BusRouteLinkReq instance) =>
    <String, dynamic>{
      'reg_no': instance.regNo,
      'route_id': instance.routeId,
      'user_id': instance.userId,
    };
