// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listdet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Listdet _$ListdetFromJson(Map<String, dynamic> json) => Listdet(
      tripName: json['trip_name'] as String?,
      via: json['via'],
      tripId: json['trip_id'] as String?,
      startTime: json['start_time'] as String?,
      stopName: json['stop_name'] as String?,
      stopId: json['stop_id'] as String?,
      stageId:json['stage_id'] as String?,
      isStage: json['is_stage'] as String?,
      km: json['km'] as String?,
      arrivingTime: json['arriving_time'] as String?,
    );

Map<String, dynamic> _$ListdetToJson(Listdet instance) => <String, dynamic>{
      'trip_name': instance.tripName,
      'via': instance.via,
      'trip_id': instance.tripId,
      'start_time': instance.startTime,
      'stop_name':instance.stopName,
      'stop_id':instance.stopId,
      'stage_id':instance.stageId,
      'is_stage':instance.isStage,
      'km':instance.km,
      'arriving_time':instance.arrivingTime
    };
