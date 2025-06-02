import 'package:json_annotation/json_annotation.dart';

part 'employee_req.g.dart';

@JsonSerializable()
class EmployeeReq {
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'conductor_id')
  String? conductorId;
  @JsonKey(name: 'driver_id')
  String? driverId;
  @JsonKey(name: 'duty_date')
  String? dutyDate;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'bus_reg_no')
  String? busRegNo;
  @JsonKey(name: 'flag')
  String? flag;
  

  EmployeeReq({
    this.busId,
    this.conductorId,
    this.driverId,
    this.dutyDate,
    this.userId,
    this.busRegNo,
    this.flag
  });

  factory EmployeeReq.fromJson(Map<String, dynamic> json) {
    return _$EmployeeReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmployeeReqToJson(this);
}
