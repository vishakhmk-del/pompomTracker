// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorResp _$ConductorRespFromJson(Map<String, dynamic> json) =>
    ConductorResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      conductorId: json['conductor_id'] as String?,
    );

Map<String, dynamic> _$ConductorRespToJson(ConductorResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'conductor_id': instance.conductorId,
    };
