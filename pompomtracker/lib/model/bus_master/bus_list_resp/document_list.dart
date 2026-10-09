import 'package:json_annotation/json_annotation.dart';

part 'document_list.g.dart';

@JsonSerializable()
class DocumentList {
  @JsonKey(name: 'document_id')
  String? documentId;
  @JsonKey(name: 'doc_type_id')
  int? docTypeId;
  @JsonKey(name: 'doc_type')
  String? docType;
  @JsonKey(name: 'owner_id')
  String? ownerId;
  @JsonKey(name: 'bus_id')
  dynamic busId;
  @JsonKey(name: 'registration_no')
  dynamic regno;
  @JsonKey(name: 'permit_id')
  String? permitId;
  @JsonKey(name: 'permit_no')
  dynamic permitNo;
  @JsonKey(name: 'valid_from')
  String? validFrom;
  @JsonKey(name: 'valid_to')
  String? validTo;
  @JsonKey(name: 'notify_before_expiry')
  dynamic notifyExpiry;
  @JsonKey(name: 'remaining_days')
  dynamic remainingDays;
  @JsonKey(name: 'expiry_status')
  String? expiryStatus;
  
  DocumentList({
    this.documentId,
    this.docTypeId,
    this.docType,
    this.ownerId,
    this.busId,
    this.regno,
    this.permitId,
    this.permitNo,
    this.validFrom,
    this.validTo,
    this.notifyExpiry,
    this.remainingDays,
    this.expiryStatus
  });

  factory DocumentList.fromJson(Map<String, dynamic> json) {
    return _$DocumentListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DocumentListToJson(this);
}
