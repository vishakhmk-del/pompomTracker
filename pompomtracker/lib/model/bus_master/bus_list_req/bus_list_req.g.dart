// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_list_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusListReq _$BusListReqFromJson(Map<String, dynamic> json) => BusListReq(
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
      busId: json['bus_id'] as String?,
      fromPlace: json['from_place'],
      toPlace: json['to_place'],
      tripId: json['trip_id'],
      collectionDt: json['collection_date'] as String?,
    );

Map<String, dynamic> _$BusListReqToJson(BusListReq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_type': instance.userType,
      'bus_id': instance.busId,
      'from_place': instance.fromPlace,
      'to_place': instance.toPlace,
      'trip_id': instance.tripId,
      'collection_date': instance.collectionDt,
    };
