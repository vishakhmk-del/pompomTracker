// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buscollectionmdl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Buscollectionmdl _$BuscollectionmdlFromJson(Map<String, dynamic> json) =>
    Buscollectionmdl(
      status: json['status'] as String?,
      repDetails: (json['rep_details'] as List<dynamic>?)
          ?.map((e) => RepDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuscollectionmdlToJson(Buscollectionmdl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'rep_details': instance.repDetails,
    };
