import 'package:json_annotation/json_annotation.dart';

part 'trip_detail.g.dart';

@JsonSerializable()
class TripDetail {
  @JsonKey(name: 'registration_no')
  String? registrationNo;
  @JsonKey(name: 'bus_name')
  String? busName;
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'total_trips')
  String? totalTrips;
  @JsonKey(name: 'conductor_id')
  dynamic conductorId;
  @JsonKey(name: 'driver_id')
  dynamic driverId;
  @JsonKey(name: 'conductor_name')
  dynamic conductorName;
  @JsonKey(name: 'driver_name')
  dynamic driverName;

  TripDetail({
    this.registrationNo,
    this.busName,
    this.busId,
    this.totalTrips,
    this.conductorId,
    this.driverId,
    this.conductorName,
    this.driverName,
  });

  factory TripDetail.fromJson(Map<String, dynamic> json) {
    return _$TripDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TripDetailToJson(this);
}
