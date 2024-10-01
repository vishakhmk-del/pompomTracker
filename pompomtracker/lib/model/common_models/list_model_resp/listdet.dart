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


  @JsonKey(name: 'name')
  String? cname;
  @JsonKey(name: 'mobile_no')
  String? mobileNo;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'conductor_id')
  String? conductorId;
  @JsonKey(name: 'account_no')
  String? accountNo;
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

  Listdet({
    this.tripName,
    this.via,
    this.tripId,
    this.startTime,
    this.stopName,
       this.stopId,
       this.stageId,
       this.isStage,
       this.km,
       this.arrivingTime,
    this.cname,
    this.mobileNo,
    this.address,
    this.conductorId,
    this.accountNo,
    this.status,
    this.registratioNo,
    this.routeName,
    this.routeId,
    this.busId,
  });

  //Listdet({this.tripName, this.via, this.tripId, this.startTime});


  factory Listdet.fromJson(Map<String, dynamic> json) {
    return _$ListdetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListdetToJson(this);
}
