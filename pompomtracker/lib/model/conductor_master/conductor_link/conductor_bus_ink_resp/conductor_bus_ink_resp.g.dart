// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_bus_ink_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorBusInkResp _$ConductorBusInkRespFromJson(Map<String, dynamic> json) =>
    ConductorBusInkResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$ConductorBusInkRespToJson(
        ConductorBusInkResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'link': instance.link,
    };
