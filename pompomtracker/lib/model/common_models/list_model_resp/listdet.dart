import 'package:json_annotation/json_annotation.dart';

part 'listdet.g.dart';

@JsonSerializable()
class Listdet {
  @JsonKey(name: 'trip_name')
  String? tripName;
  dynamic via;
  @JsonKey(name: 'trip_id')
  String? tripId;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'stop_name')
  String? stopName;
  @JsonKey(name: 'stop_id')
  String? stopId;
  @JsonKey(name: 'stage_id')
  String? stageId;
  @JsonKey(name: 'is_stage')
  String? isStage;
  @JsonKey(name: 'km')
  String? km;
  @JsonKey(name: 'arriving_time')
  String? arrivingTime;
  @JsonKey(name: 'departure_time')
  String? departureTime;
  @JsonKey(name: 'name')
  String? cname;
  @JsonKey(name: 'mobile_no')
  String? mobileNo;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'emp_id')
  String? empId;
  @JsonKey(name: 'account_no')
  String? accountNo;
  @JsonKey(name: 'lisecnce_no')
  String? lisecnceNo;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'registration_no')
  String? registratioNo;
  @JsonKey(name: 'route_name')
  String? routeName;
  @JsonKey(name: 'route_id')
  String? routeId;
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'lisence_no')
  String? lisenceNo;
  @JsonKey(name: 'end_time')
  String? endTime;
  @JsonKey(name: 'from_station')
  String? fromStation;
  @JsonKey(name: 'to_station')
  String? toStation;
  @JsonKey(name: 'station')
  String? station;
  @JsonKey(name: 'emp_type')
  dynamic empType;

  Listdet(
      {this.tripName,
      this.via,
      this.tripId,
      this.startTime,
      this.stopName,
      this.stopId,
      this.stageId,
      this.isStage,
      this.km,
      this.arrivingTime,
      this.departureTime,
      this.cname,
      this.mobileNo,
      this.address,
      this.empId,
      this.accountNo,
      this.lisecnceNo,
      this.status,
      this.registratioNo,
      this.routeName,
      this.routeId,
      this.busId,
      this.endTime,
      this.fromStation,
      this.toStation,
      this.station,
      this.empType,
      this.lisenceNo});

  //Listdet({this.tripName, this.via, this.tripId, this.startTime});

  factory Listdet.fromJson(Map<String, dynamic> json) {
    return _$ListdetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListdetToJson(this);
}
