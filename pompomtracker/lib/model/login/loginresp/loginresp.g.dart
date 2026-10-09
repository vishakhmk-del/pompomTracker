// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loginresp _$LoginrespFromJson(Map<String, dynamic> json) => Loginresp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      errorCode: json['error_code'] as String?,
      mandatory: json['mandatory'] as bool?,
      data: json['data'] == null
          ? null
          : DataCount.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginrespToJson(Loginresp instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'error_code': instance.errorCode,
      'mandatory': instance.mandatory,
      'data': instance.data,
    };
