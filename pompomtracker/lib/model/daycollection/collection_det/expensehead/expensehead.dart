import 'package:json_annotation/json_annotation.dart';

part 'expensehead.g.dart';

@JsonSerializable()
class Expensehead {
  @JsonKey(name: 'expense_head')
  String? expenseHead;
  String? amount;

  Expensehead({this.expenseHead, this.amount});

  factory Expensehead.fromJson(Map<String, dynamic> json) {
    return _$ExpenseheadFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExpenseheadToJson(this);
}
