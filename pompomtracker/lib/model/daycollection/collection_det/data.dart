import 'package:json_annotation/json_annotation.dart';
import 'package:pompomtracker/model/Statements/datewise/datewiseresp/ticket_list.dart';
import 'package:pompomtracker/model/daycollection/collection_det/expensehead/expensehead.dart';

import 'trip.dart';

part 'data.g.dart';

@JsonSerializable()
class DataDetails {
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'reg_no')
  String? regno;
  @JsonKey(name: 'ticket_det')
  List<TicketList>? ticketDet;
  @JsonKey(name: 'expense_head')
  List<Expensehead>? expenseHead;
  List<Trip>? trips;
  @JsonKey(name: 'total_expense')
  dynamic totalExpense;
  @JsonKey(name: 'grand_total')
  dynamic grandTotal;

  DataDetails(
      {this.busId,
      this.regno,
      this.ticketDet,
      this.expenseHead,
      this.trips,
      this.totalExpense,
      this.grandTotal});

  factory DataDetails.fromJson(Map<String, dynamic> json) =>
      _$DataDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailsToJson(this);
}
