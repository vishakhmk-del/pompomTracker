// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_list_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorListReq _$ConductorListReqFromJson(Map<String, dynamic> json) =>
    ConductorListReq(
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
    );

Map<String, dynamic> _$ConductorListReqToJson(ConductorListReq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_type': instance.userType,
    };
