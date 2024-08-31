import 'package:json_annotation/json_annotation.dart';

part 'trip_master_resp.g.dart';

@JsonSerializable()
class TripMasterResp {
  String? status;
  String? message;
  @JsonKey(name: 'trip_details')
  int? tripDetails;

  TripMasterResp(
      {required this.status, required this.message, required this.tripDetails});

  factory TripMasterResp.fromJson(Map<String, dynamic> json) {
    return _$TripMasterRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TripMasterRespToJson(this);
}
