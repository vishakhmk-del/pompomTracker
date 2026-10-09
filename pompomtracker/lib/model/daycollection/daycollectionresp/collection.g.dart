// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      busId: json['bus_id'] as String?,
      busName: json['bus_name'] as String?,
      registrationNo: json['registration_no'] as String?,
      totalAmount: json['total_amount'],
      collectionDate: json['collection_date'] as String?,
      totalExpense: json['total_expense'],
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'bus_id': instance.busId,
      'bus_name': instance.busName,
      'registration_no': instance.registrationNo,
      'total_amount': instance.totalAmount,
      'collection_date': instance.collectionDate,
      'total_expense': instance.totalExpense,
    };
