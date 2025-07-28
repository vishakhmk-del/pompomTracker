// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeReq _$EmployeeReqFromJson(Map<String, dynamic> json) => EmployeeReq(
      busId: json['bus_id'] as String?,
      empId: json['emp_id'] as String?,
      startDate: json['start_date'] as String?,
      userType: json['user_type'],
      userId: json['user_id'] as String?,
      ownerId: json['owner_id'] as String?,
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$EmployeeReqToJson(EmployeeReq instance) =>
    <String, dynamic>{
      'bus_id': instance.busId,
      'emp_id': instance.empId,
      'start_date': instance.startDate,
      'user_type': instance.userType,
      'user_id': instance.userId,
      'owner_id': instance.ownerId,
      'flag': instance.flag,
    };
