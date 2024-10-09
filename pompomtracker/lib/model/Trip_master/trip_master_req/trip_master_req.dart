import 'package:json_annotation/json_annotation.dart';

part 'trip_master_req.g.dart';

@JsonSerializable()
class TripMasterReq {
  @JsonKey(name: 'route_id')
  int? routeId;
  @JsonKey(name: 'reg_no')
  String? regNo;
  String? from;
  String? to;
  String? ftime;
  String? ttime;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'trip_id')
  String? tripId;

  TripMasterReq(
      {required this.routeId,
      required this.regNo,
      required this.from,
      required this.to,
      required this.ftime,
      required this.ttime,
      required this.userId,
      this.tripId});

  factory TripMasterReq.fromJson(Map<String, dynamic> json) {
    return _$TripMasterReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TripMasterReqToJson(this);
}
