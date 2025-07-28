// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_edit_re.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorEditRe _$ConductorEditReFromJson(Map<String, dynamic> json) =>
    ConductorEditRe(
      empId: json['emp_id'] as String?,
      userId: json['user_id'] as String?,
      empType: (json['emp_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ConductorEditReToJson(ConductorEditRe instance) =>
    <String, dynamic>{
      'emp_id': instance.empId,
      'user_id': instance.userId,
      'emp_type': instance.empType,
    };
