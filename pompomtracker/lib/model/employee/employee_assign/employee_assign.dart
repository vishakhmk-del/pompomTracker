import 'package:json_annotation/json_annotation.dart';

import 'trip_detail.dart';

part 'employee_assign.g.dart';

@JsonSerializable()
class EmployeeAssign {
  String? status;
  @JsonKey(name: 'owner_id')
  String? ownerId;
  @JsonKey(name: 'trip_details')
  List<TripDetail>? tripDetails;

  EmployeeAssign({this.status, this.ownerId, this.tripDetails});

  factory EmployeeAssign.fromJson(Map<String, dynamic> json) {
    return _$EmployeeAssignFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmployeeAssignToJson(this);
}
