// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDetails _$DataDetailsFromJson(Map<String, dynamic> json) => DataDetails(
      busId: json['bus_id'] as String?,
      trips: (json['trips'] as List<dynamic>?)
          ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalExpense: json['total_expense'] as dynamic,
      grandTotal: json['grand_total'] as dynamic,

    );

Map<String, dynamic> _$DataDetailsToJson(DataDetails instance) => <String, dynamic>{
      'bus_id': instance.busId,
      'trips': instance.trips,
      'total_expense': instance.totalExpense,
      'grand_total':instance.grandTotal
    };
