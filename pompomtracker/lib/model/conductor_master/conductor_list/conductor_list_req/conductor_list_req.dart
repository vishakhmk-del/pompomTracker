import 'package:json_annotation/json_annotation.dart';

part 'conductor_list_req.g.dart';

@JsonSerializable()
class ConductorListReq {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;

  ConductorListReq({required this.userId, required this.userType});

  factory ConductorListReq.fromJson(Map<String, dynamic> json) {
    return _$ConductorListReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorListReqToJson(this);
}
