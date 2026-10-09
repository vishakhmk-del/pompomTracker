// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctypelist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctypelist _$DoctypelistFromJson(Map<String, dynamic> json) => Doctypelist(
      id: (json['id'] as num?)?.toInt(),
      docType: json['doc_type'] as String?,
      docFlag: (json['doc_flag'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DoctypelistToJson(Doctypelist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doc_type': instance.docType,
      'doc_flag': instance.docFlag,
    };
