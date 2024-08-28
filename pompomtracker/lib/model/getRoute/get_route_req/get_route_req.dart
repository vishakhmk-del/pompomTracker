import 'package:json_annotation/json_annotation.dart';

part 'get_route_req.g.dart';

@JsonSerializable()
class GetRouteReq {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;

  GetRouteReq({this.userId, this.userType});

  factory GetRouteReq.fromJson(Map<String, dynamic> json) {
    return _$GetRouteReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetRouteReqToJson(this);
}
