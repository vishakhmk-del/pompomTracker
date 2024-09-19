import 'package:json_annotation/json_annotation.dart';

part 'conductor_detail.g.dart';

@JsonSerializable()
class ConductorDetail {
  @JsonKey(name: 'conductor_id')
  String? conductorId;
  String? name;
  String? address;
  @JsonKey(name: 'account_no')
  String? accountNo;
  @JsonKey(name: 'mobile_no')
  String? mobileNo;
  String? status;
  @JsonKey(name: 'bus_name')
  String? busName;
  @JsonKey(name: 'registration_no')
  String? registrationNo;
  @JsonKey(name: 'email_id')
  String? emailId;

  ConductorDetail({
    this.conductorId,
    this.name,
    this.address,
    this.accountNo,
    this.mobileNo,
    this.status,
    this.busName,
    this.registrationNo,
    this.emailId,
  });

  factory ConductorDetail.fromJson(Map<String, dynamic> json) {
    return _$ConductorDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorDetailToJson(this);
}
