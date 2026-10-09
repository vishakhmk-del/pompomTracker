// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expensehead.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expensehead _$ExpenseheadFromJson(Map<String, dynamic> json) => Expensehead(
      expenseHead: json['expense_head'] as String?,
      amount: json['amount'] as String?,
    );

Map<String, dynamic> _$ExpenseheadToJson(Expensehead instance) =>
    <String, dynamic>{
      'expense_head': instance.expenseHead,
      'amount': instance.amount,
    };
