// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentList _$DocumentListFromJson(Map<String, dynamic> json) => DocumentList(
      documentId: json['document_id'] as String?,
      docTypeId: (json['doc_type_id'] as num?)?.toInt(),
      docType: json['doc_type'] as String?,
      ownerId: json['owner_id'] as String?,
      busId: json['bus_id'],
      regno: json['registration_no'],
      permitId: json['permit_id'] as String?,
      permitNo: json['permit_no'],
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      notifyExpiry: json['notify_before_expiry'],
      remainingDays: json['remaining_days'],
      expiryStatus: json['expiry_status'] as String?,
    );

Map<String, dynamic> _$DocumentListToJson(DocumentList instance) =>
    <String, dynamic>{
      'document_id': instance.documentId,
      'doc_type_id': instance.docTypeId,
      'doc_type': instance.docType,
      'owner_id': instance.ownerId,
      'bus_id': instance.busId,
      'registration_no':instance.regno,
      'permit_id': instance.permitId,
      'permit_no':instance.permitNo,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'notify_before_expiry':instance.notifyExpiry,
      'remaining_days':instance.remainingDays,
      'expiry_status':instance.expiryStatus
    };
