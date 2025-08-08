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
    this.offline,
    this.refund,
    this.totalCollection,
    this.travelDate,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);
}
