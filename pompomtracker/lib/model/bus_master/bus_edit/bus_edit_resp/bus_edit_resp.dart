import 'package:json_annotation/json_annotation.dart';

import 'bus_detail.dart';

part 'bus_edit_resp.g.dart';

@JsonSerializable()
class BusEditResp {
  String? status;
  String? message;
  @JsonKey(name: 'bus_details')
  List<BusDetail>? busDetails;

  BusEditResp({this.status, this.message, this.busDetails});

  factory BusEditResp.fromJson(Map<String, dynamic> json) {
    return _$BusEditRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusEditRespToJson(this);
}
