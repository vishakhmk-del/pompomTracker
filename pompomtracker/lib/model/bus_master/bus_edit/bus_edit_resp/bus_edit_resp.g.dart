// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_edit_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusEditResp _$BusEditRespFromJson(Map<String, dynamic> json) => BusEditResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      busDetails: (json['bus_details'] as List<dynamic>?)
          ?.map((e) => BusDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusEditRespToJson(BusEditResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'bus_details': instance.busDetails,
    };
