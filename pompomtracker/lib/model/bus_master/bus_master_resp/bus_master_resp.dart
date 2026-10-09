import 'package:json_annotation/json_annotation.dart';

part 'bus_master_resp.g.dart';

@JsonSerializable()
class BusMasterResp {
  String? status;
  String? message;
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'document_id')
  String? docId;
  @JsonKey(name: 'expiry_count')
  dynamic expiryCount;

  BusMasterResp({this.status, this.message, this.busId, this.docId,this.expiryCount});

  factory BusMasterResp.fromJson(Map<String, dynamic> json) {
    return _$BusMasterRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusMasterRespToJson(this);
}
