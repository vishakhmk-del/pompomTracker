import 'package:json_annotation/json_annotation.dart';

part 'listdet.g.dart';

@JsonSerializable()
class Listdet {
  @JsonKey(name: 'trip_name')
  String? tripName;
  dynamic via;
  @JsonKey(name: 'trip_id')
  String? tripId;
  @JsonKey(name: 'start_time')
  String? startTime;
   @JsonKey(name: 'stop_name')
  String? stopName;
   @JsonKey(name: 'stop_id')
  String? stopId;
   @JsonKey(name: 'stage_id')
  String? stageId;
   @JsonKey(name: 'is_stage')
  String? isStage;
   @JsonKey(name: 'km')
  String? km;
   @JsonKey(name: 'arriving_time')
  String? arrivingTime;

  Listdet({
    this.tripName,
     this.via,
      this.tripId,
       this.startTime,
       this.stopName,
       this.stopId,
       this.stageId,
       this.isStage,
       this.km,
       this.arrivingTime
       });

  factory Listdet.fromJson(Map<String, dynamic> json) {
    return _$ListdetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListdetToJson(this);
}
