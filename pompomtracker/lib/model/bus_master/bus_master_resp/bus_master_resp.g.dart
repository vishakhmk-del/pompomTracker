// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_master_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusMasterResp _$BusMasterRespFromJson(Map<String, dynamic> json) =>
    BusMasterResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      busId: json['bus_id'] as String?,
    );

Map<String, dynamic> _$BusMasterRespToJson(BusMasterResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'bus_id': instance.busId,
    };
