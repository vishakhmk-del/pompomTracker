// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_edit_re.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorEditRe _$ConductorEditReFromJson(Map<String, dynamic> json) =>
    ConductorEditRe(
      conductorId: json['conductor_id'] as String?,
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
    );

Map<String, dynamic> _$ConductorEditReToJson(ConductorEditRe instance) =>
    <String, dynamic>{
      'conductor_id': instance.conductorId,
      'user_id': instance.userId,
      'user_type': instance.userType,
    };
