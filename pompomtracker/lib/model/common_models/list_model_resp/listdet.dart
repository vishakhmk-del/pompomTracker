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

  Listdet({this.tripName, this.via, this.tripId, this.startTime});

  factory Listdet.fromJson(Map<String, dynamic> json) {
    return _$ListdetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListdetToJson(this);
}
