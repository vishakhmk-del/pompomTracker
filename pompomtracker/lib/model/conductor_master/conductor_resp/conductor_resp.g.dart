// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorResp _$ConductorRespFromJson(Map<String, dynamic> json) =>
    ConductorResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      empId: json['emp_id'],
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$ConductorRespToJson(ConductorResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'emp_id': instance.empId,
      'flag': instance.flag,
    };
