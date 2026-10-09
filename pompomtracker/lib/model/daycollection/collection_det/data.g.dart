// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDetails _$DataDetailsFromJson(Map<String, dynamic> json) => DataDetails(
      busId: json['bus_id'] as String?,
      regno: json['reg_no'] as String?,
      ticketDet: (json['ticket_det'] as List<dynamic>?)
          ?.map((e) => TicketList.fromJson(e as Map<String, dynamic>))
          .toList(),
      expenseHead: (json['expense_head'] as List<dynamic>?)
          ?.map((e) => Expensehead.fromJson(e as Map<String, dynamic>))
          .toList(),
      trips: (json['trips'] as List<dynamic>?)
          ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalExpense: json['total_expense'],
      grandTotal: json['grand_total'],
    );

Map<String, dynamic> _$DataDetailsToJson(DataDetails instance) =>
    <String, dynamic>{
      'bus_id': instance.busId,
      'reg_no': instance.regno,
      'ticket_det': instance.ticketDet,
      'expense_head': instance.expenseHead,
      'trips': instance.trips,
      'total_expense': instance.totalExpense,
      'grand_total': instance.grandTotal,
    };
