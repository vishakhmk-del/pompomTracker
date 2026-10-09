// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_det.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketDet _$TicketDetFromJson(Map<String, dynamic> json) => TicketDet(
      regNo: json['reg_no'] as String?,
      trips: (json['trips'] as List<dynamic>?)
          ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalExpense: json['total_expense'] as String?,
      grandTotal: json['grand_total'] as String?,
    );

Map<String, dynamic> _$TicketDetToJson(TicketDet instance) => <String, dynamic>{
      'reg_no': instance.regNo,
      'trips': instance.trips,
      'total_expense': instance.totalExpense,
      'grand_total': instance.grandTotal,
    };
