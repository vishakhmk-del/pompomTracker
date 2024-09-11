// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stmntfnparameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stmntfnparameter _$StmntfnparameterFromJson(Map<String, dynamic> json) =>
    Stmntfnparameter(
      type: json['type'] as String?,
      fromdate: json['fromdate'] as String?,
      todate: json['todate'] as String?,
      summary: json['summary'] as bool?,
      mode: json['mode'] as String?,
    );

Map<String, dynamic> _$StmntfnparameterToJson(Stmntfnparameter instance) =>
    <String, dynamic>{
      'type': instance.type,
      'fromdate': instance.fromdate,
      'todate': instance.todate,
      'summary': instance.summary,
      'mode': instance.mode,
    };
