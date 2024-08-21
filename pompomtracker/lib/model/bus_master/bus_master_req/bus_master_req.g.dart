// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_master_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusMasterReq _$BusMasterReqFromJson(Map<String, dynamic> json) => BusMasterReq(
      busName: json['bus_name'] as String?,
      shName: json['sh_name'] as String?,
      regno: json['regno'] as String?,
      busType: json['bus_type'] as String?,
      permitno: json['permitno'] as String?,
      vfrom: json['vfrom'] as String?,
      vto: json['vto'] as String?,
      userId: json['user_id'] as String?,
      active: json['active'] as String?,
    );

Map<String, dynamic> _$BusMasterReqToJson(BusMasterReq instance) =>
    <String, dynamic>{
      'bus_name': instance.busName,
      'sh_name': instance.shName,
      'regno': instance.regno,
      'bus_type': instance.busType,
      'permitno': instance.permitno,
      'vfrom': instance.vfrom,
      'vto': instance.vto,
      'user_id': instance.userId,
      'active': instance.active,
    };
