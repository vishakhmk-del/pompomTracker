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
    );

Map<String, dynamic> _$ListdetToJson(Listdet instance) => <String, dynamic>{
      'trip_name': instance.tripName,
      'via': instance.via,
      'trip_id': instance.tripId,
      'start_time': instance.startTime,
    };
