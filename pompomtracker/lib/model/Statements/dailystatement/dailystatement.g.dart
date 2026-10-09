// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailystatement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dailystatement _$DailystatementFromJson(Map<String, dynamic> json) =>
    Dailystatement(
      status: json['status'] as String?,
      message: json['message'] as String?,
      ticketDet: (json['ticket_det'] as List<dynamic>?)
          ?.map((e) => TicketDet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailystatementToJson(Dailystatement instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'ticket_det': instance.ticketDet,
    };
