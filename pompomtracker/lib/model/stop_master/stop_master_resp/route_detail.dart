import 'package:json_annotation/json_annotation.dart';

part 'route_detail.g.dart';

@JsonSerializable()
class RouteDetail {
  @JsonKey(name: 'trip_id')
  String? tripId;
  @JsonKey(name: 'stop_name')
  String? stopName;
  @JsonKey(name: 'stop_id')
  String? stopId;
  @JsonKey(name: 'stage_id')
  String? stageId;
  @JsonKey(name: 'is_stage')
  String? isStage;
  String? km;
  @JsonKey(name: 'arriving_time')
  String? arrivingTime;

  RouteDetail({
    this.tripId,
    this.stopName,
    this.stopId,
    this.stageId,
    this.isStage,
    this.km,
    this.arrivingTime,
  });

  factory RouteDetail.fromJson(Map<String, dynamic> json) {
    return _$RouteDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RouteDetailToJson(this);
}
