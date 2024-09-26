import 'package:json_annotation/json_annotation.dart';

part 'list_req.g.dart';

@JsonSerializable()
class MasterListReq {
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
  @JsonKey(name: 'user_type')
  String? usertype;
  @JsonKey(name: 'trip_id')
  String? tripId;

  MasterListReq({
     this.cname,
    this.caddress,
    this.mobNo,
    this.busRegNo,
    this.emailId,
    this.status,
    this.accNo,
    this.userId,
    this.ownerId,
    this.usertype,
    this.tripId

  });

  factory MasterListReq.fromJson(Map<String, dynamic> json) {
    return _$MasterListReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MasterListReqToJson(this);
}
