import 'package:json_annotation/json_annotation.dart';

import 'trip.dart';

part 'data.g.dart';

@JsonSerializable()
class DataDetails {
  @JsonKey(name: 'bus_id')
  String? busId;
  List<Trip>? trips;
  @JsonKey(name: 'total_expense')
  String? totalExpense;
  @JsonKey(name: 'grand_total')
  dynamic grandTotal;

  DataDetails({this.busId, this.trips, this.totalExpense,this.grandTotal});

  factory DataDetails.fromJson(Map<String, dynamic> json) => _$DataDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailsToJson(this);
}
