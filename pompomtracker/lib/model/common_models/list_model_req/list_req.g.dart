// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterListReq _$MasterListReqFromJson(Map<String, dynamic> json) =>
    MasterListReq(
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
    );

Map<String, dynamic> _$MasterListReqToJson(MasterListReq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_type': instance.userType,
    };
