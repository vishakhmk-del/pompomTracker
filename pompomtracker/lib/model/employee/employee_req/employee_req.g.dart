// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeReq _$EmployeeReqFromJson(Map<String, dynamic> json) => EmployeeReq(
      busId: json['bus_id'] as String?,
      conductorId: json['conductor_id'] as String?,
      driverId: json['driver_id'] as String?,
      dutyDate: json['duty_date'] as String?,
      userId: json['user_id'] as String?,
      busRegNo: json['bus_reg_no'] as String?,
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$EmployeeReqToJson(EmployeeReq instance) =>
    <String, dynamic>{
      'bus_id': instance.busId,
      'conductor_id': instance.conductorId,
      'driver_id': instance.driverId,
      'duty_date': instance.dutyDate,
      'user_id': instance.userId,
      'bus_reg_no':instance.busRegNo,
      'flag':instance.flag
    };
