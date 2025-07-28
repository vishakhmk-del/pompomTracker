import 'package:json_annotation/json_annotation.dart';

part 'employee_req.g.dart';

@JsonSerializable()
class EmployeeReq {
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'emp_id')
  String? empId;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'user_type')
  dynamic userType;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'owner_id')
  String? ownerId;
  @JsonKey(name: 'flag')
  String? flag;

  EmployeeReq(
      {this.busId,
      this.empId,
      this.startDate,
      this.userType,
      this.userId,
      this.ownerId,
      this.flag});

  EmployeeReq copyWith({
    String? busId,
    String? empId,
    String? startDate,
    dynamic userType,
    String? userId,
    String? ownerId,
    String? flag,
  }) {
    return EmployeeReq(
      empId: empId ?? this.empId,
      busId: busId ?? this.busId,
      startDate: startDate ?? this.startDate,
      userType: userType ?? this.userType,
      userId: userId ?? this.userId,
      ownerId: ownerId ?? this.ownerId,
      flag: flag ?? this.flag,
    );
  }

  factory EmployeeReq.fromJson(Map<String, dynamic> json) {
    return _$EmployeeReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmployeeReqToJson(this);
}
