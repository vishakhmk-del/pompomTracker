// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loginreq _$LoginreqFromJson(Map<String, dynamic> json) => Loginreq(
      userName: json['user_name'] as String?,
      pwd: json['pwd'] as String?,
      phone: json['device_model'] as String?,
      deviceid: json['device_id'] as String?,
      phoneos: json['phoneos'] as String?,
      androidid: json['android_id'] as String?,
      osversion: json['osversion'] as String?,
      appversion: json['app_version'] as String?,
      buildnumber: json['build_number'] as String?,
    );

Map<String, dynamic> _$LoginreqToJson(Loginreq instance) => <String, dynamic>{
      'user_name': instance.userName,
      'pwd': instance.pwd,
      'device_model': instance.phone,
      'device_id': instance.deviceid,
      'phoneos': instance.phoneos,
      'android_id': instance.androidid,
      'osversion': instance.osversion,
      'app_version': instance.appversion,
      'build_number': instance.buildnumber,
    };
