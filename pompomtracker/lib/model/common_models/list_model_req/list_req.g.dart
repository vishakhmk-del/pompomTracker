// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterListReq _$MasterListReqFromJson(Map<String, dynamic> json) => MasterListReq(
      cname: json['cname'] as String?,
      caddress: json['caddress'] as String?,
      mobNo: json['mob_no'] as String?,
      busRegNo: json['bus_reg_no'] as String?,
      emailId: json['email_id'] as String?,
      status: json['status'] as String?,
      accNo: json['acc_no'] as String?,
      userId: json['user_id'] as String?,
      ownerId: json['owner_id'] as String?,
      usertype: json['user_type'] as String?,
      tripId: json['trip_id'] as String?,
    );

Map<String, dynamic> _$MasterListReqToJson(MasterListReq instance) =>
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
      'user_type':instance.usertype,
      'trip_id':instance.tripId
      
    };
