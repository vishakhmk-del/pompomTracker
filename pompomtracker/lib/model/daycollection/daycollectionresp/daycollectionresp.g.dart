// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daycollectionresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Daycollectionresp _$DaycollectionrespFromJson(Map<String, dynamic> json) =>
    Daycollectionresp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DataCollection.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DaycollectionrespToJson(Daycollectionresp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
