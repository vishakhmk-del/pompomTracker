import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

@JsonSerializable()
class Trip {
  @JsonKey(name: 'trip_id')
  String? tripId;
  @JsonKey(name: 'trip_no')
  String? tripNo;
  @JsonKey(name: 'trip_name')
  String? tripName;
  @JsonKey(name: 'from_station')
  String? fromStation;
  @JsonKey(name: 'to_station')
  String? toStation;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'end_time')
  String? endTime;
  String? online;
  @JsonKey(name: 'online_count')
  String? onlineCount;
  String? offline;
  @JsonKey(name: 'offline_count')
  String? offlineCount;
  @JsonKey(name: 'adult_count')
  String? adultCount;
  @JsonKey(name: 'adult_total_amt')
  String? adultTotalAmt;
  @JsonKey(name: 'kids_count')
  String? kidsCount;
  @JsonKey(name: 'kids_total_amt')
  String? kidsTotalAmt;
  @JsonKey(name: 'student_count')
  String? studentCount;
  @JsonKey(name: 'student_total_amt')
  String? studentTotalAmt;
  @JsonKey(name: 'handicaped_count')
  String? handicapedCount;
  @JsonKey(name: 'handicaped_total_amt')
  String? handicapedTotalAmt;
  @JsonKey(name: 'luggage_count')
  String? luggageCount;
  @JsonKey(name: 'luggage_total_amt')
  String? luggageTotalAmt;
  String? refund;
  @JsonKey(name: 'refund_count')
  String? refundCount;
  String? concession;
  @JsonKey(name: 'concession_count')
  String? concessionCount;
  @JsonKey(name: 'total_collection')
  String? totalCollection;
  @JsonKey(name: 'travel_date')
  String? travelDate;

  Trip({
    this.tripId,
    this.tripNo,
    this.tripName,
    this.fromStation,
    this.toStation,
    this.startTime,
    this.endTime,
    this.online,
    this.onlineCount,
    this.offline,
    this.offlineCount,
    this.adultCount,
    this.adultTotalAmt,
    this.kidsCount,
    this.kidsTotalAmt,
    this.studentCount,
    this.studentTotalAmt,
    this.handicapedCount,
    this.handicapedTotalAmt,
    this.luggageCount,
    this.luggageTotalAmt,
    this.refund,
    this.refundCount,
    this.concession,
    this.concessionCount,
    this.totalCollection,
    this.travelDate,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);
}
