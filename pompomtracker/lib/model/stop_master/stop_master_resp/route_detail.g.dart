// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteDetail _$RouteDetailFromJson(Map<String, dynamic> json) => RouteDetail(
      tripId: json['trip_id'] as String?,
      stopName: json['stop_name'] as String?,
      stopId: json['stop_id'] as String?,
      stageId: json['stage_id'] as String?,
      isStage: json['is_stage'] as String?,
      km: json['km'] as String?,
      arrivingTime: json['arriving_time'] as String?,
    );

Map<String, dynamic> _$RouteDetailToJson(RouteDetail instance) =>
    <String, dynamic>{
      'trip_id': instance.tripId,
      'stop_name': instance.stopName,
      'stop_id': instance.stopId,
      'stage_id': instance.stageId,
      'is_stage': instance.isStage,
      'km': instance.km,
      'arriving_time': instance.arrivingTime,
    };
