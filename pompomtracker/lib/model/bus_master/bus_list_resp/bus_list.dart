import 'package:json_annotation/json_annotation.dart';

part 'bus_list.g.dart';

@JsonSerializable()
class BusList {
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
  String? activeTrip;
  @JsonKey(name: 'bus_type')
  String? busType;

  BusList({
    this.registrationNo,
    this.busName,
    this.permitNo,
    this.validFrom,
    this.validTo,
    this.activeTrip,
    this.busType,
  });

  factory BusList.fromJson(Map<String, dynamic> json) {
    return _$BusListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusListToJson(this);
}
