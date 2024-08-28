import 'package:json_annotation/json_annotation.dart';

part 'bus_list.g.dart';

@JsonSerializable()
class BusList {
  @JsonKey(name: 'registration_no')
  String? registrationNo;

  BusList({this.registrationNo});

  factory BusList.fromJson(Map<String, dynamic> json) {
    return _$BusListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusListToJson(this);

  void fromJson(Map<String, dynamic> resultAsJson) {}
}
