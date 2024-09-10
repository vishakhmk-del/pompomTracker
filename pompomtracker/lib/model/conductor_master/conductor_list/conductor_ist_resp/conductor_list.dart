import 'package:json_annotation/json_annotation.dart';

part 'conductor_list.g.dart';

@JsonSerializable()
class ConductorList {
  @JsonKey(name: 'conductor_id')
  String? conductorId;
  String? name;
  String? address;
  @JsonKey(name: 'account_no')
  String? accountNo;
  @JsonKey(name: 'mobile_no')
  String? mobileNo;
  String? status;
  @JsonKey(name: 'registration_no')
  String? registrationNo;

  ConductorList({
    this.conductorId,
    this.name,
    this.address,
    this.accountNo,
    this.mobileNo,
    this.status,
    this.registrationNo,
  });

  factory ConductorList.fromJson(Map<String, dynamic> json) {
    return _$ConductorListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorListToJson(this);
}
