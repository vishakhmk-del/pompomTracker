import 'package:json_annotation/json_annotation.dart';

part 'bus_list_req.g.dart';

@JsonSerializable()
class BusListReq {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'from_place')
  dynamic fromPlace;
  @JsonKey(name: 'to_place')
  dynamic toPlace;
  @JsonKey(name: 'trip_id')
  dynamic tripId;
  

  BusListReq({
    this.userId,
    this.userType,
    this.busId,
    this.fromPlace,
    this.toPlace,
    this.tripId});

  factory BusListReq.fromJson(Map<String, dynamic> json) {
    return _$BusListReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusListReqToJson(this);
}
