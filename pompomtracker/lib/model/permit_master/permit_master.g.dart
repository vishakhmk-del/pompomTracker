// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permit_master.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermitMaster _$PermitMasterFromJson(Map<String, dynamic> json) => PermitMaster(
      status: json['status'] as String?,
      message: json['message'] as String?,
      permitList: (json['permit_list'] as List<dynamic>?)
          ?.map((e) => PermitList.fromJson(e as Map<String, dynamic>))
          .toList(),
      docTypeList: (json['doc_type_list'] as List<dynamic>?)
          ?.map((e) => Doctypelist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PermitMasterToJson(PermitMaster instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'permit_list': instance.permitList,
      'doc_type_list': instance.docTypeList,
    };
