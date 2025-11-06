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
  String? offline;
  String? refund;
  String? concession;
  @JsonKey(name: 'concession_count')
  String? concessionCount;
  @JsonKey(name: 'refund_count')
  String? refundCount;
  @JsonKey(name: 'total_collection')
  String? totalCollection;
  @JsonKey(name: 'travel_date')
  String? travelDate;
  @JsonKey(name: 'online_count')
  String? onlineCount;
  @JsonKey(name: 'offline_count')
  String? offlineCount;
  @JsonKey(name: 'student_count')
  String? studentCount;
  @JsonKey(name: 'handicaped_count')
  String? handiCount;
  @JsonKey(name: 'luggage_count')
  String? luggageCount;
  @JsonKey(name: 'adult_count')
  String? adultCount;
  @JsonKey(name: 'kids_count')
  String? kidsCount;
  @JsonKey(name: 'student_total_amt')
  String? studentTotelAmt;
  @JsonKey(name: 'handicaped_total_amt')
  String? handiTotelAmt;
  @JsonKey(name: 'luggage_total_amt')
  String? luggageTotelAmt;
  @JsonKey(name: 'adult_total_amt')
  String? adultTotelAmt;
  @JsonKey(name: 'kids_total_amt')
  String? kidsTotelAmt;
  Trip({
    this.tripId,
    this.tripNo,
    this.tripName,
    this.fromStation,
    this.toStation,
    this.startTime,
    this.endTime,
    this.online,
    this.offline,
    this.refund,
    this.refundCount,
    this.concession,
    this.concessionCount,
    this.totalCollection,
    this.travelDate,
    this.onlineCount,
    this.offlineCount,
    this.studentCount,
    this.handiCount,
    this.luggageCount,
    this.adultCount,
    this.kidsCount,
    this.studentTotelAmt,
    this.handiTotelAmt,
    this.luggageTotelAmt,
    this.adultTotelAmt,
    this.kidsTotelAmt
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);
}
