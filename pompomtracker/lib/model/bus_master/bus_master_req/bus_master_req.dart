import 'package:json_annotation/json_annotation.dart';

part 'bus_master_req.g.dart';

@JsonSerializable()
class BusMasterReq {
  @JsonKey(name: 'bus_name')
  String? busName;
  @JsonKey(name: 'sh_name')
  String? shName;
  String? regno;
  @JsonKey(name: 'bus_type')
  String? busType;
  String? permitno;
  @JsonKey(name: 'valid_from')
  String? vfrom;
  @JsonKey(name: 'valid_to')
  String? vto;
  @JsonKey(name: 'user_id')
  String? userId;
  String? active;
  @JsonKey(name: 'doc_type')
  String? docType;
  @JsonKey(name: 'permit_id')
  String? permitId;
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'notify_expiry')
  dynamic notifyExpiry;
  @JsonKey(name: 'document_id')
  String? documentId;

  BusMasterReq(
      {this.busName,
      this.shName,
      this.regno,
      this.busType,
      this.permitno,
      this.vfrom,
      this.vto,
      this.userId,
      this.active,
      this.docType,
      this.permitId,
      this.busId,
      this.notifyExpiry,
      this.documentId});

  BusMasterReq.req({
    required this.busName,
    this.shName,
    required this.regno,
    this.busType,
    required this.permitno,
    required this.vfrom,
    required this.vto,
    required this.userId,
    required this.active,
  });

  factory BusMasterReq.fromJson(Map<String, dynamic> json) {
    return _$BusMasterReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusMasterReqToJson(this);
}
