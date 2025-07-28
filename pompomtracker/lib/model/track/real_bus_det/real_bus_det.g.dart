// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_bus_det.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealBusDet _$RealBusDetFromJson(Map<String, dynamic> json) => RealBusDet(
      status: json['status'] as String?,
      message: json['message'] as String?,
      busList: (json['bus_list'] as List<dynamic>?)
          ?.map((e) => BusDetList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RealBusDetToJson(RealBusDet instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'bus_list': instance.busList,
    };
