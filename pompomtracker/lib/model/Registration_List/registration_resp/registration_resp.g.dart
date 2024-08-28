// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResp _$RegistrationRespFromJson(Map<String, dynamic> json) =>
    RegistrationResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      busList: (json['bus_list'] as List<dynamic>?)
          ?.map((e) => BusList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RegistrationRespToJson(RegistrationResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'bus_list': instance.busList,
    };
