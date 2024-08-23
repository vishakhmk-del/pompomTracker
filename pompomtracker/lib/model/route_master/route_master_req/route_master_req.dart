import 'package:json_annotation/json_annotation.dart';

part 'route_master_req.g.dart';

@JsonSerializable()
class RouteMasterReq {
  String? from;
  String? to;
  String? via;
  @JsonKey(name: 'user_id')
  String? userId;

  RouteMasterReq(
      {required this.from,
      required this.to,
      required this.via,
      required this.userId});

  factory RouteMasterReq.fromJson(Map<String, dynamic> json) {
    return _$RouteMasterReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RouteMasterReqToJson(this);
}
