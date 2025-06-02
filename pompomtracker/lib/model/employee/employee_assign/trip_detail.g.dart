// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetail _$TripDetailFromJson(Map<String, dynamic> json) => TripDetail(
      registrationNo: json['registration_no'] as String?,
      busName: json['bus_name'] as String?,
      busId: json['bus_id'] as String?,
      totalTrips: json['total_trips'] as String?,
      conductorId: json['conductor_id'],
      driverId: json['driver_id'],
      conductorName: json['conductor_name'],
      driverName: json['driver_name'],
    );

Map<String, dynamic> _$TripDetailToJson(TripDetail instance) =>
    <String, dynamic>{
      'registration_no': instance.registrationNo,
      'bus_name': instance.busName,
      'bus_id': instance.busId,
      'total_trips': instance.totalTrips,
      'conductor_id': instance.conductorId,
      'driver_id': instance.driverId,
      'conductor_name': instance.conductorName,
      'driver_name': instance.driverName,
    };
