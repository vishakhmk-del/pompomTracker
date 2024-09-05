import 'package:json_annotation/json_annotation.dart';

part 'conductor_req.g.dart';

@JsonSerializable()
class ConductorReq {
  String? cname;
  String? caddress;
  @JsonKey(name: 'mob_no')
  String? mobNo;
  @JsonKey(name: 'bus_reg_no')
  String? busRegNo;
  @JsonKey(name: 'email_id')
  String? emailId;
  String? status;
  @JsonKey(name: 'acc_no')
  String? accNo;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'owner_id')
  String? ownerId;

  ConductorReq({
    required this.cname,
    required this.caddress,
    required this.mobNo,
    required this.busRegNo,
    required this.emailId,
    required this.status,
    required this.accNo,
    required this.userId,
    required this.ownerId,
  });

  factory ConductorReq.fromJson(Map<String, dynamic> json) {
    return _$ConductorReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorReqToJson(this);
}
