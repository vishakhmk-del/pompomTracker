import 'package:json_annotation/json_annotation.dart';

part 'stop_master_req.g.dart';

@JsonSerializable()
class StopMasterReq {
  @JsonKey(name: 'trip_id')
  int? tripId;
  String? kilometer;
  @JsonKey(name: 'is_stage')
  int? isStage;
  String? stop;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'arriving_time')
  String? arrivingTime;

  StopMasterReq({
    required this.tripId,
    required this.kilometer,
    required this.isStage,
    required this.stop,
    required this.userId,
    required this.arrivingTime,
  });

  factory StopMasterReq.fromJson(Map<String, dynamic> json) {
    return _$StopMasterReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StopMasterReqToJson(this);
}
