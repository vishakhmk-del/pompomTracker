import 'package:json_annotation/json_annotation.dart';

import 'bus_list.dart';

part 'real_bus_det.g.dart';

@JsonSerializable()
class RealBusDet {
  String? status;
  String? message;
  @JsonKey(name: 'bus_list')
  List<BusDetList>? busList;

  RealBusDet({this.status, this.message, this.busList});

  factory RealBusDet.fromJson(Map<String, dynamic> json) {
    return _$RealBusDetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RealBusDetToJson(this);
}
