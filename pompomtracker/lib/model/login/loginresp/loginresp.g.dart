// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loginresp _$LoginrespFromJson(Map<String, dynamic> json) => Loginresp(
      status: json['status'] as String?,
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
      userName: json['user_name'] as String?,
      ownerName: json['owner_name'] as String?,
    );

Map<String, dynamic> _$LoginrespToJson(Loginresp instance) => <String, dynamic>{
      'status': instance.status,
      'user_id': instance.userId,
      'user_type': instance.userType,
      'user_name': instance.userName,
      'owner_name': instance.ownerName,
    };
