// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_list_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusListReq _$BusListReqFromJson(Map<String, dynamic> json) => BusListReq(
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
    );

Map<String, dynamic> _$BusListReqToJson(BusListReq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_type': instance.userType,
    };
