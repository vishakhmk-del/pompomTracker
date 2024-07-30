// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loginreq _$LoginreqFromJson(Map<String, dynamic> json) => Loginreq(
      userName: json['user_name'] as String?,
      pwd: json['pwd'] as String?,
    );

Map<String, dynamic> _$LoginreqToJson(Loginreq instance) => <String, dynamic>{
      'user_name': instance.userName,
      'pwd': instance.pwd,
    };
