import 'package:json_annotation/json_annotation.dart';

part 'loginresp.g.dart';

@JsonSerializable()
class Loginresp {
  String? status;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'owner_name')
  String? ownerName;

  Loginresp({
    this.status,
    this.userId,
    this.userType,
    this.userName,
    this.ownerName,
  });

  factory Loginresp.fromJson(Map<String, dynamic> json) {
    return _$LoginrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginrespToJson(this);
}
