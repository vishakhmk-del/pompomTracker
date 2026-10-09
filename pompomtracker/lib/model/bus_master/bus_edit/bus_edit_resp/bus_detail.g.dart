// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusDetail _$BusDetailFromJson(Map<String, dynamic> json) => BusDetail(
      registrationNo: json['registration_no'] as String?,
      busName: json['bus_name'] as String?,
      permitNo: json['permit_no'] as String?,
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      activeTrip: json['active_trip'],
      shortName: json['short_name'] as String?,
      busType: json['bus_type'] as String?,
    );

Map<String, dynamic> _$BusDetailToJson(BusDetail instance) => <String, dynamic>{
      'registration_no': instance.registrationNo,
      'bus_name': instance.busName,
      'permit_no': instance.permitNo,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'active_trip': instance.activeTrip,
      'short_name': instance.shortName,
      'bus_type': instance.busType,
    };
