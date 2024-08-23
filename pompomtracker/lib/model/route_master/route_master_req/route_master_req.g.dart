// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_master_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteMasterReq _$RouteMasterReqFromJson(Map<String, dynamic> json) =>
    RouteMasterReq(
      from: json['from'] as String?,
      to: json['to'] as String?,
      via: json['via'] as String?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$RouteMasterReqToJson(RouteMasterReq instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'via': instance.via,
      'user_id': instance.userId,
    };
