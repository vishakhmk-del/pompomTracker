// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_master_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopMasterResp _$StopMasterRespFromJson(Map<String, dynamic> json) =>
    StopMasterResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      routeDetails: (json['route_details'] as List<dynamic>?)
          ?.map((e) => RouteDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StopMasterRespToJson(StopMasterResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'route_details': instance.routeDetails,
    };
