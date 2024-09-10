import 'package:json_annotation/json_annotation.dart';

part 'bus_edit_req.g.dart';

@JsonSerializable()
class BusEditReq {
  @JsonKey(name: 'reg_no')
  String? regNo;

  BusEditReq({required this.regNo});

  factory BusEditReq.fromJson(Map<String, dynamic> json) {
    return _$BusEditReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusEditReqToJson(this);
}
