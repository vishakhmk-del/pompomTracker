import 'package:json_annotation/json_annotation.dart';

part 'sharedpref.g.dart';

@JsonSerializable()
class Sharedpref {
  String? status;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'owner_name')
  String? ownerName;
  @JsonKey(name: 'access_token')
  String? token;

  Sharedpref(
      {this.status,
      this.userId,
      this.userType,
      this.userName,
      this.ownerName,
      this.token});
  Sharedpref.value({
    this.status,
    required this.userId,
    required this.userType,
    required this.userName,
    required this.ownerName,
    required this.token,
  });

  factory Sharedpref.fromJson(Map<String, dynamic> json) {
    return _$SharedprefFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SharedprefToJson(this);
}
