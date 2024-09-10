import 'package:json_annotation/json_annotation.dart';

part 'bus_list_req.g.dart';

@JsonSerializable()
class BusListReq {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;

  BusListReq({required this.userId, required this.userType});

  factory BusListReq.fromJson(Map<String, dynamic> json) {
    return _$BusListReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BusListReqToJson(this);
}
