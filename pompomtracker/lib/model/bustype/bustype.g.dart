// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bustype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bustype _$BustypeFromJson(Map<String, dynamic> json) => Bustype(
      status: json['status'] as String?,
      message: json['message'] as String?,
      busList: (json['bus_list'] as List<dynamic>?)
          ?.map((e) => BusList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BustypeToJson(Bustype instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'bus_list': instance.busList,
    };
