// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_route_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRouteReq _$GetRouteReqFromJson(Map<String, dynamic> json) => GetRouteReq(
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
      empType: (json['emp_type'] as num?)?.toInt(),
      ownerId: json['owner_id'] as String?,
    );

Map<String, dynamic> _$GetRouteReqToJson(GetRouteReq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_type': instance.userType,
      'emp_type': instance.empType,
      'owner_id': instance.ownerId,
    };
