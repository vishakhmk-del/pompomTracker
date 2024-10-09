// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_master_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripMasterReq _$TripMasterReqFromJson(Map<String, dynamic> json) =>
    TripMasterReq(
      routeId: (json['route_id'] as num?)?.toInt(),
      regNo: json['reg_no'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      ftime: json['ftime'] as String?,
      ttime: json['ttime'] as String?,
      userId: json['user_id'] as String?,
      tripId: json['trip_id'] as String?,
    );

Map<String, dynamic> _$TripMasterReqToJson(TripMasterReq instance) =>
    <String, dynamic>{
      'route_id': instance.routeId,
      'reg_no': instance.regNo,
      'from': instance.from,
      'to': instance.to,
      'ftime': instance.ftime,
      'ttime': instance.ttime,
      'user_id': instance.userId,
      'trip_id': instance.tripId,
    };
