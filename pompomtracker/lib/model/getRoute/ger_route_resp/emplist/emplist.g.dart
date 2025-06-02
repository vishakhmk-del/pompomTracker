// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emplist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emplist _$EmplistFromJson(Map<String, dynamic> json) => Emplist(
      conductorId: json['conductor_id'] as String?,
      name: json['name'] as String?,
      driverId: json['driver_id'] as String?,
    );

Map<String, dynamic> _$EmplistToJson(Emplist instance) => <String, dynamic>{
      'conductor_id': instance.conductorId,
      'driver_id': instance.driverId,
      'name': instance.name,
    };
