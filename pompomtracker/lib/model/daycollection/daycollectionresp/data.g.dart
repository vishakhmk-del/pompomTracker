// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCollection _$DataCollectionFromJson(Map<String, dynamic> json) =>
    DataCollection(
      collection: (json['collection'] as List<dynamic>?)
          ?.map((e) => Collection.fromJson(e as Map<String, dynamic>))
          .toList(),
      grandTotal: json['grand_total'],
      grandExpense: json['grand_expense'],
      collectionDate: json['collection_date'] as String?,
    );

Map<String, dynamic> _$DataCollectionToJson(DataCollection instance) =>
    <String, dynamic>{
      'collection': instance.collection,
      'grand_total': instance.grandTotal,
      'grand_expense': instance.grandExpense,
      'collection_date': instance.collectionDate,
    };
