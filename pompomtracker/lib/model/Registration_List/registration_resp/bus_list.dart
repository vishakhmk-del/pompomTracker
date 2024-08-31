import 'package:json_annotation/json_annotation.dart';

part 'bus_list.g.dart';

@JsonSerializable()
class BusRegList {
  @JsonKey(name: 'registration_no')
  String? registrationNo;

  BusRegList({this.registrationNo});

  factory BusRegList.fromJson(Map<String, dynamic> json) {
    return _$BusRegListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusRegListToJson(this);

  void fromJson(Map<String, dynamic> resultAsJson) {}
}
