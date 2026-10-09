// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_master_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusMasterReq _$BusMasterReqFromJson(Map<String, dynamic> json) => BusMasterReq(
      busName: json['bus_name'] as String?,
      shName: json['sh_name'] as String?,
      regno: json['regno'] as String?,
      busType: json['bus_type'] as String?,
      permitno: json['permitno'] as String?,
      vfrom: json['valid_from'] as String?,
      vto: json['valid_to'] as String?,
      userId: json['user_id'] as String?,
      active: json['active'] as String?,
      docType: json['doc_type'] as String?,
      permitId: json['permit_id'] as String?,
      busId: json['bus_id'] as String?,
      notifyExpiry: json['notify_expiry'],
      documentId: json['document_id'] as String?,

    );

Map<String, dynamic> _$BusMasterReqToJson(BusMasterReq instance) =>
    <String, dynamic>{
      'bus_name': instance.busName,
      'sh_name': instance.shName,
      'regno': instance.regno,
      'bus_type': instance.busType,
      'permitno': instance.permitno,
      'valid_from': instance.vfrom,
      'valid_to': instance.vto,
      'user_id': instance.userId,
      'active': instance.active,
      'doc_type': instance.docType,
      'permit_id': instance.permitId,
      'bus_id': instance.busId,
      'notify_expiry':instance.notifyExpiry,
      'document_id':instance.documentId
    };
