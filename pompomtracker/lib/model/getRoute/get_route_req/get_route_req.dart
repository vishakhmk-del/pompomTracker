import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_route_req.g.dart';

@JsonSerializable()
class GetRouteReq {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;
  @JsonKey(name: 'emp_type')
  int? empType;
  @JsonKey(name: 'owner_id')
  String? ownerId;

  GetRouteReq({this.userId, this.userType, this.empType, this.ownerId});

  factory GetRouteReq.fromJson(Map<String, dynamic> json) {
    return _$GetRouteReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetRouteReqToJson(this);
}
