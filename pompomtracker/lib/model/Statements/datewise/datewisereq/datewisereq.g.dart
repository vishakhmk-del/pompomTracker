// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datewisereq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datewisereq _$DatewisereqFromJson(Map<String, dynamic> json) => Datewisereq(
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
      fromdate: json['fromdate'] as String?,
      todate: json['todate'] as String?,
      regNo: json['reg_no'] as String?,
      summary: json['summary'] as bool?,
    );

Map<String, dynamic> _$DatewisereqToJson(Datewisereq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_type': instance.userType,
      'fromdate': instance.fromdate,
      'todate': instance.todate,
      'reg_no': instance.regNo,
      'summary': instance.summary,
    };
