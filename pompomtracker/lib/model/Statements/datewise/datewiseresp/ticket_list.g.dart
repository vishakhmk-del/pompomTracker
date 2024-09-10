// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketList _$TicketListFromJson(Map<String, dynamic> json) => TicketList(
      amount: json['amount'] as String?,
      mode: json['mode'] as String?,
      payDate: json['pay_date'] as String?,
      regNo: json['reg_no'] as String?,
      totalIncome: json['total_income'] as String?,
      totalExpense: json['total_expense'] as String?,
      expense: json['expense'] as String?,
      expensehead: json['expense_head'] as String?,
    );

Map<String, dynamic> _$TicketListToJson(TicketList instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'mode': instance.mode,
      'pay_date': instance.payDate,
      'reg_no': instance.regNo,
      'total_income':instance.totalIncome,
      'total_expense':instance.totalExpense,
      'expense':instance.expense,
      'expense_head':instance.expensehead
    };
