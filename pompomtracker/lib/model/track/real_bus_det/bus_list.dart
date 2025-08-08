import 'package:json_annotation/json_annotation.dart';

part 'bus_list.g.dart';

@JsonSerializable()
class BusDetList {
  @JsonKey(name: 'bus_name')
  String? busName;
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'registration_no')
  String? registrationNo;
  @JsonKey(name: 'bus_type')
  String? busType;
  @JsonKey(name: 'live_latitude')
  String? liveLatitude;
  @JsonKey(name: 'live_longitude')
  String? liveLongitude;
  @JsonKey(name: 'live_date')
  String? liveDate;
  @JsonKey(name: 'trip_id')
  String? tripId;
  @JsonKey(name: 'trip_name')
  String? tripName;
  @JsonKey(name: 'from_station')
  String? fromStation;
  @JsonKey(name: 'to_station')
  String? toStation;
  @JsonKey(name: 'trip_status')
  String? tripStatus;

  BusDetList(
      {this.busName,
      this.busId,
      this.registrationNo,
      this.busType,
      this.liveLatitude,
      this.liveLongitude,
      this.liveDate,
      this.tripId,
      this.fromStation,
      this.toStation,
      this.tripName,
      this.tripStatus});

  factory BusDetList.fromJson(Map<String, dynamic> json) {
    return _$BusDetListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusDetListToJson(this);
}
