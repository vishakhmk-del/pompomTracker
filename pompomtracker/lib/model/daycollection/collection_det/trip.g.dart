// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      tripId: json['trip_id'] as String?,
      tripNo: json['trip_no'] as String?,
      tripName: json['trip_name'] as String?,
      fromStation: json['from_station'] as String?,
      toStation: json['to_station'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      online: json['online'] as String?,
      offline: json['offline'] as String?,
      refund: json['refund'] as String?,
      totalCollection: json['total_collection'] as String?,
      travelDate: json['travel_date'] as String?,
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'trip_id': instance.tripId,
      'trip_no': instance.tripNo,
      'trip_name': instance.tripName,
      'from_station': instance.fromStation,
      'to_station': instance.toStation,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'online': instance.online,
      'offline': instance.offline,
      'refund':instance.refund,
      'total_collection': instance.totalCollection,
      'travel_date': instance.travelDate,
    };
