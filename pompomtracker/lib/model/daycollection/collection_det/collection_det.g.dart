// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_det.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionDet _$CollectionDetFromJson(Map<String, dynamic> json) =>
    CollectionDet(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DataDetails.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectionDetToJson(CollectionDet instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
