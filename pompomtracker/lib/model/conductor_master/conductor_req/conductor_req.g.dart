// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorReq _$ConductorReqFromJson(Map<String, dynamic> json) => ConductorReq(
      cname: json['cname'] as String?,
      caddress: json['caddress'] as String?,
      mobNo: json['mob_no'] as String?,
      busRegNo: json['bus_reg_no'] as String?,
      emailId: json['email_id'] as String?,
      status: json['status'] as String?,
      accNo: json['acc_no'] as String?,
      userId: json['user_id'] as String?,
      ownerId: json['owner_id'] as String?,
    );

Map<String, dynamic> _$ConductorReqToJson(ConductorReq instance) =>
    <String, dynamic>{
      'cname': instance.cname,
      'caddress': instance.caddress,
      'mob_no': instance.mobNo,
      'bus_reg_no': instance.busRegNo,
      'email_id': instance.emailId,
      'status': instance.status,
      'acc_no': instance.accNo,
      'user_id': instance.userId,
      'owner_id': instance.ownerId,
    };
