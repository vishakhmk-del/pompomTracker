// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_master_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopMasterReq _$StopMasterReqFromJson(Map<String, dynamic> json) =>
    StopMasterReq(
      tripId: (json['trip_id'] as num?)?.toInt(),
      kilometer: json['kilometer'] as String?,
      isStage: (json['is_stage'] as num?)?.toInt(),
      stop: json['stop'] as String?,
      userId: json['user_id'] as String?,
      arrivingTime: json['arriving_time'] as String?,
      departureTime: json['departure_time'] as String?,
    );

Map<String, dynamic> _$StopMasterReqToJson(StopMasterReq instance) =>
    <String, dynamic>{
      'trip_id': instance.tripId,
      'kilometer': instance.kilometer,
      'is_stage': instance.isStage,
      'stop': instance.stop,
      'user_id': instance.userId,
      'arriving_time': instance.arrivingTime,
      'departure_time': instance.departureTime,
    };
