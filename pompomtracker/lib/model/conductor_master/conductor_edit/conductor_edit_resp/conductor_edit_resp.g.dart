// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_edit_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorEditResp _$ConductorEditRespFromJson(Map<String, dynamic> json) =>
    ConductorEditResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      flag: json['flag'] as String?,
      conductorDetails: (json['employee_details'] as List<dynamic>?)
          ?.map((e) => ConductorDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      busList: (json['bus_list'] as List<dynamic>?)
          ?.map((e) => BusList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConductorEditRespToJson(ConductorEditResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'flag': instance.flag,
      'employee_details': instance.conductorDetails,
      'bus_list': instance.busList,
    };
