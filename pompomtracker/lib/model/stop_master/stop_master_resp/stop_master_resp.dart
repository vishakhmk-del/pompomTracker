import 'package:json_annotation/json_annotation.dart';

import 'route_detail.dart';

part 'stop_master_resp.g.dart';

@JsonSerializable()
class StopMasterResp {
  String? status;
  String? message;
  @JsonKey(name: 'route_details')
  List<RouteDetail>? routeDetails;

  StopMasterResp({this.status, this.message, this.routeDetails});

  factory StopMasterResp.fromJson(Map<String, dynamic> json) {
    return _$StopMasterRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StopMasterRespToJson(this);
}
