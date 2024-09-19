import 'package:json_annotation/json_annotation.dart';

part 'list_req.g.dart';

@JsonSerializable()
class MasterListReq {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;

  MasterListReq({required this.userId, required this.userType});

  factory MasterListReq.fromJson(Map<String, dynamic> json) {
    return _$MasterListReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MasterListReqToJson(this);
}
