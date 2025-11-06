// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      tripId: json['trip_id'] as String?,
      tripNo: json['trip_no'] as String?,
      tripName: json['trip_name'] as String?,
      fromStation: json['from_station'] as String?,
      toStation: json['to_station'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      online: json['online'] as String?,
      offline: json['offline'] as String?,
      refund: json['refund'] as String?,
      refundCount: json['refund_count'] as String?,
      concessionCount: json['concession_count'] as String?,
      concession: json['concession'] as String?,
      totalCollection: json['total_collection'] as String?,
      travelDate: json['travel_date'] as String?,
      onlineCount: json['online_count'] as String?,
      offlineCount: json['offline_count'] as String?,
      studentCount: json['student_count'] as String?,
      handiCount: json['handicaped_count'] as String?,
      luggageCount: json['luggage_count'] as String?,
      adultCount: json['adult_count'] as String?,
      kidsCount: json['kids_count'] as String?,
      studentTotelAmt: json['student_total_amt'] as String?,
      handiTotelAmt: json['handicaped_total_amt'] as String?,
      luggageTotelAmt: json['luggage_total_amt'] as String?,
      adultTotelAmt: json['adult_total_amt'] as String?,
      kidsTotelAmt: json['kids_total_amt'] as String?,
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'trip_id': instance.tripId,
      'trip_no': instance.tripNo,
      'trip_name': instance.tripName,
      'from_station': instance.fromStation,
      'to_station': instance.toStation,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'online': instance.online,
      'offline': instance.offline,
      'refund':instance.refund,
      'refund_count':instance.refundCount,
      'concession':instance.concession,
      'concession_count':instance.concessionCount,
      'total_collection': instance.totalCollection,
      'travel_date': instance.travelDate,
      'online_count': instance.onlineCount,
      'offline_count': instance.offlineCount,
      'student_count': instance.studentCount,
      'handicaped_count': instance.handiCount,
      'luggage_count': instance.luggageCount,
      'adult_count': instance.adultCount,
      'kids_count': instance.kidsCount,
      'student_total_amt': instance.studentTotelAmt,
      'handicaped_total_amt': instance.handiTotelAmt,
      'luggage_total_amt': instance.luggageTotelAmt,
      'adult_total_amt': instance.adultTotelAmt,
      'kids_total_amt': instance.kidsTotelAmt,

    };
