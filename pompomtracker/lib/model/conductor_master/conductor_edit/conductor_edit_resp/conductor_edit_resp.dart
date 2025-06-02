import 'package:json_annotation/json_annotation.dart';

import 'bus_list.dart';
import 'conductor_detail.dart';

part 'conductor_edit_resp.g.dart';

@JsonSerializable()
class ConductorEditResp {
  String? status;
  String? message;
  @JsonKey(name: 'employee_details')
  List<ConductorDetail>? conductorDetails;
  @JsonKey(name: 'bus_list')
  List<BusList>? busList;

  ConductorEditResp({
    this.status,
    this.message,
    this.conductorDetails,
    this.busList,
  });

  factory ConductorEditResp.fromJson(Map<String, dynamic> json) {
    return _$ConductorEditRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorEditRespToJson(this);
}
