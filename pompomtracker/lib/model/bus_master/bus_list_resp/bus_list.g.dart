// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusList _$BusListFromJson(Map<String, dynamic> json) => BusList(
      registrationNo: json['registration_no'] as String?,
      busName: json['bus_name'] as String?,
      permitNo: json['permit_no'] as String?,
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      activeTrip: json['active_trip'] as String?,
      busType: json['bus_type'] as String?,
    );

Map<String, dynamic> _$BusListToJson(BusList instance) => <String, dynamic>{
      'registration_no': instance.registrationNo,
      'bus_name': instance.busName,
      'permit_no': instance.permitNo,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'active_trip': instance.activeTrip,
      'bus_type': instance.busType,
    };
