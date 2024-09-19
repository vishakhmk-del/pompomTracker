import 'package:json_annotation/json_annotation.dart';

part 'listdet.g.dart';

@JsonSerializable()
class Listdet {
  @JsonKey(name: 'trip_name')
  String? tripName;
  dynamic via;
  @JsonKey(name: 'trip_id')
  String? tripId;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'name')
  String? cname;
  @JsonKey(name: 'mobile_no')
  String? mobileNo;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'conductor_id')
  String? conductorId;
  @JsonKey(name: 'account_no')
  String? accountNo;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'registration_no')
  String? registratioNo;

  Listdet(
      {this.tripName,
      this.via,
      this.tripId,
      this.startTime,
      this.cname,
      this.mobileNo,
      this.address,
      this.conductorId,
      this.accountNo,
      this.status,
      this.registratioNo});

  factory Listdet.fromJson(Map<String, dynamic> json) {
    return _$ListdetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListdetToJson(this);
}
