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
      onlineCount: json['online_count'] as String?,
      offline: json['offline'] as String?,
      offlineCount: json['offline_count'] as String?,
      adultCount: json['adult_count'] as String?,
      adultTotalAmt: json['adult_total_amt'] as String?,
      kidsCount: json['kids_count'] as String?,
      kidsTotalAmt: json['kids_total_amt'] as String?,
      studentCount: json['student_count'] as String?,
      studentTotalAmt: json['student_total_amt'] as String?,
      handicapedCount: json['handicaped_count'] as String?,
      handicapedTotalAmt: json['handicaped_total_amt'] as String?,
      luggageCount: json['luggage_count'] as String?,
      luggageTotalAmt: json['luggage_total_amt'] as String?,
      refund: json['refund'] as String?,
      refundCount: json['refund_count'] as String?,
      concession: json['concession'] as String?,
      concessionCount: json['concession_count'] as String?,
      totalCollection: json['total_collection'] as String?,
      travelDate: json['travel_date'] as String?,
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
      'online_count': instance.onlineCount,
      'offline': instance.offline,
      'offline_count': instance.offlineCount,
      'adult_count': instance.adultCount,
      'adult_total_amt': instance.adultTotalAmt,
      'kids_count': instance.kidsCount,
      'kids_total_amt': instance.kidsTotalAmt,
      'student_count': instance.studentCount,
      'student_total_amt': instance.studentTotalAmt,
      'handicaped_count': instance.handicapedCount,
      'handicaped_total_amt': instance.handicapedTotalAmt,
      'luggage_count': instance.luggageCount,
      'luggage_total_amt': instance.luggageTotalAmt,
      'refund': instance.refund,
      'refund_count': instance.refundCount,
      'concession': instance.concession,
      'concession_count': instance.concessionCount,
      'total_collection': instance.totalCollection,
      'travel_date': instance.travelDate,
    };
