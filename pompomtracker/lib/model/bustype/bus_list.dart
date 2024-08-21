import 'package:json_annotation/json_annotation.dart';

part 'bus_list.g.dart';

@JsonSerializable()
class BusList {
  @JsonKey(name: 'type_id')
  String? typeId;

  BusList({this.typeId});

  factory BusList.fromJson(Map<String, dynamic> json) {
    return _$BusListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusListToJson(this);
}
