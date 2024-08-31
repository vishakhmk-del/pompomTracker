import 'package:json_annotation/json_annotation.dart';

part 'ticket_list.g.dart';

@JsonSerializable()
class TicketList {
  String? amount;
  String? mode;
  @JsonKey(name: 'pay_date')
  String? payDate;
  @JsonKey(name: 'reg_no')
  String? regNo;

  TicketList({this.amount, this.mode, this.payDate, this.regNo});

  factory TicketList.fromJson(Map<String, dynamic> json) {
    return _$TicketListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TicketListToJson(this);
}
