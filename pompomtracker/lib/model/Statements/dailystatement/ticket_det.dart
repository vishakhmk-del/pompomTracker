import 'package:json_annotation/json_annotation.dart';

import 'trip.dart';

part 'ticket_det.g.dart';

@JsonSerializable()
class TicketDet {
  @JsonKey(name: 'reg_no')
  String? regNo;
  List<Trip>? trips;
  @JsonKey(name: 'total_expense')
  String? totalExpense;
  @JsonKey(name: 'grand_total')
  String? grandTotal;

  TicketDet({this.regNo, this.trips, this.totalExpense, this.grandTotal});

  factory TicketDet.fromJson(Map<String, dynamic> json) {
    return _$TicketDetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TicketDetToJson(this);
}
