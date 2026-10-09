import 'package:json_annotation/json_annotation.dart';

part 'bus_detail.g.dart';

@JsonSerializable()
class BusDetail {
  @JsonKey(name: 'registration_no')
  String? registrationNo;
  @JsonKey(name: 'bus_name')
  String? busName;
  @JsonKey(name: 'permit_no')
  String? permitNo;
  @JsonKey(name: 'valid_from')
  String? validFrom;
  @JsonKey(name: 'valid_to')
  String? validTo;
  @JsonKey(name: 'active_trip')
  dynamic activeTrip;
  @JsonKey(name: 'short_name')
  String? shortName;
  @JsonKey(name: 'bus_type')
  String? busType;

  BusDetail({
    this.registrationNo,
    this.busName,
    this.permitNo,
    this.validFrom,
    this.validTo,
    this.activeTrip,
    this.shortName,
    this.busType,
  });

  factory BusDetail.fromJson(Map<String, dynamic> json) {
    return _$BusDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusDetailToJson(this);
}
