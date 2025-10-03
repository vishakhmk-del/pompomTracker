import 'package:json_annotation/json_annotation.dart';

part 'list_req.g.dart';

@JsonSerializable()
class MasterListReq {
  @JsonKey(name: 'emp_id')
  String? empId;
  @JsonKey(name: 'cname')
  String? cname;
  @JsonKey(name: 'caddress')
  String? caddress;
  @JsonKey(name: 'mob_no')
  String? mobNo;
  @JsonKey(name: 'bus_reg_no')
  String? busRegNo;
  @JsonKey(name: 'email_id')
  String? emailId;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'acc_no')
  String? accNo;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'owner_id')
  String? ownerId;
  @JsonKey(name: 'user_type')
  String? usertype;
  @JsonKey(name: 'trip_id')
  String? tripId;
  @JsonKey(name: 'lisence_no')
  String? licenceNo;

  @JsonKey(name: 'arriving_time')
  String? arrivingTime;
  @JsonKey(name: 'departure_time')
  String? departureTime;
  @JsonKey(name: 'stop_name')
  String? stopName;
  @JsonKey(name: 'stop_name_old')
  String? stopNameOld;
  @JsonKey(name: 'stop_id')
  String? stopId;
  @JsonKey(name: 'km')
  String? km;
  @JsonKey(name: 'after')
  int? after;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'is_stage')
  dynamic isStage;
  @JsonKey(name: 'stage_id')
  String? stageId;
  @JsonKey(name: 'reg_no')
  String? regNo;
  @JsonKey(name: 'route_id')
  int? routeId;
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'flag')
  String? flag;
  @JsonKey(name: 'role')
  int? role;
  @JsonKey(name: 'emp_type')
  int? emptype;
  MasterListReq(
      {this.empId,
      this.cname,
      this.caddress,
      this.mobNo,
      this.busRegNo,
      this.emailId,
      this.status,
      this.accNo,
      this.userId,
      this.ownerId,
      this.usertype,
      this.tripId,
      this.licenceNo,
      this.arrivingTime,
      this.departureTime,
      this.stopName,
      this.stopNameOld,
      this.stopId,
      this.km,
      this.after,
      this.latitude,
      this.longitude,
      this.isStage,
      this.stageId,
      this.regNo,
      this.routeId,
      this.busId,
      this.flag,
      this.role,
      this.emptype});

  MasterListReq copyWith(
      {String? conductorId,
      String? driverId,
      String? cname,
      String? caddress,
      String? mobNo,
      String? busRegNo,
      String? emailId,
      String? status,
      String? accNo,
      String? userId,
      String? ownerId,
      String? usertype,
      String? tripId,
      String? licenceNo,
      String? arrivingTime,
      String? stopName,
      String? stopNameOld,
      String? stopId,
      String? km,
      int? after,
      String? latitude,
      String? longitude,
      dynamic isStage,
      String? stageId,
      String? regNo,
      int? routeId,
      String? busId,
      String? flag,
      int? role,
      int? emptype}) {
    return MasterListReq(
      empId: conductorId ?? empId,
      cname: cname ?? this.cname,
      caddress: caddress ?? this.caddress,
      mobNo: mobNo ?? this.mobNo,
      busRegNo: busRegNo ?? this.busRegNo,
      emailId: emailId ?? this.emailId,
      status: status ?? this.status,
      accNo: accNo ?? this.accNo,
      userId: userId ?? this.userId,
      ownerId: ownerId ?? this.ownerId,
      usertype: usertype ?? this.usertype,
      tripId: tripId ?? this.tripId,
      licenceNo: licenceNo ?? this.licenceNo,
      arrivingTime: arrivingTime ?? this.arrivingTime,
      stopName: stopName ?? this.stopName,
      stopNameOld: stopNameOld ?? this.stopNameOld,
      stopId: stopId ?? this.stopId,
      km: km ?? this.km,
      after: after ?? this.after,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isStage: isStage ?? this.isStage,
      stageId: stageId ?? this.stageId,
      regNo: regNo ?? this.regNo,
      routeId: routeId ?? this.routeId,
      busId: busId ?? this.busId,
      flag: flag ?? this.flag,
      role: role ?? this.role,
      emptype: emptype ?? this.emptype,
    );
  }

  factory MasterListReq.fromJson(Map<String, dynamic> json) {
    return _$MasterListReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MasterListReqToJson(this);
}
