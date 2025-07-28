// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusDetList _$BusDetListFromJson(Map<String, dynamic> json) => BusDetList(
      busName: json['bus_name'] as String?,
      busId: json['bus_id'] as String?,
      registrationNo: json['registration_no'] as String?,
      busType: json['bus_type'] as String?,
      liveLatitude: json['live_latitude'] as String?,
      liveLongitude: json['live_longitude'] as String?,
      liveDate: json['live_date'] as String?,
      tripId: json['trip_id'] as String?,
      fromStation: json['from_station'] as String?,
      toStation: json['to_station'] as String?,
      tripName: json['trip_name'] as String?,
      tripStatus: json['trip_status'] as String?,
    );

Map<String, dynamic> _$BusDetListToJson(BusDetList instance) => <String, dynamic>{
      'bus_name': instance.busName,
      'bus_id': instance.busId,
      'registration_no': instance.registrationNo,
      'bus_type': instance.busType,
      'live_latitude': instance.liveLatitude,
      'live_longitude': instance.liveLongitude,
      'live_date': instance.liveDate,
      'trip_id':instance.tripId,
      'from_station':instance.fromStation,
      'to_station':instance.toStation,
      'trip_name':instance.tripName,
      'trip_status':instance.tripStatus
    };
