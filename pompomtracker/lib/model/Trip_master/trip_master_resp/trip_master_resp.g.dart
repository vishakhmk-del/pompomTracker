// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_master_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripMasterResp _$TripMasterRespFromJson(Map<String, dynamic> json) =>
    TripMasterResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      tripDetails: (json['trip_details'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TripMasterRespToJson(TripMasterResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'trip_details': instance.tripDetails,
    };
