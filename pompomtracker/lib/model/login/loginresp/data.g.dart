// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCount _$DataCountFromJson(Map<String, dynamic> json) => DataCount(
      errorCode: json['error_code'] as String?,
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
      userName: json['user_name'] as String?,
      ownerName: json['owner_name'] as String?,
      token: json['access_token'] as String?,

    );

Map<String, dynamic> _$DataCountToJson(DataCount instance) => <String, dynamic>{
      'error_code': instance.errorCode,
      'user_id': instance.userId,
      'user_type': instance.userType,
      'user_name': instance.userName,
      'owner_name': instance.ownerName,
      'access_token':instance.token
    };
