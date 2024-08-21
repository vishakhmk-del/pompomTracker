import 'package:json_annotation/json_annotation.dart';

import 'bus_list.dart';

part 'bustype.g.dart';

@JsonSerializable()
class Bustype {
  String? status;
  String? message;
  @JsonKey(name: 'bus_list')
  List<BusList>? busList;

  Bustype({this.status, this.message, this.busList});

  factory Bustype.fromJson(Map<String, dynamic> json) {
    return _$BustypeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BustypeToJson(this);
}
