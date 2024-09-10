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
  @JsonKey(name: 'total_income')
  String? totalIncome;
  @JsonKey(name: 'total_expense')
  String? totalExpense;
  @JsonKey(name: 'expense')
  String? expense;
  @JsonKey(name: 'expense_head')
  String? expensehead;

  TicketList({
    this.amount,
     this.mode,
      this.payDate,
       this.regNo,
       this.totalIncome,
       this.totalExpense,
       this.expense,
       this.expensehead
       });

  factory TicketList.fromJson(Map<String, dynamic> json) {
    return _$TicketListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TicketListToJson(this);
}
