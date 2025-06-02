// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_assign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeAssign _$EmployeeAssignFromJson(Map<String, dynamic> json) =>
    EmployeeAssign(
      status: json['status'] as String?,
      ownerId: json['owner_id'] as String?,
      tripDetails: (json['trip_details'] as List<dynamic>?)
          ?.map((e) => TripDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeAssignToJson(EmployeeAssign instance) =>
    <String, dynamic>{
      'status': instance.status,
      'owner_id': instance.ownerId,
      'trip_details': instance.tripDetails,
    };
