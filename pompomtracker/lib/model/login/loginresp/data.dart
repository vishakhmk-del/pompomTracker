import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class DataCount {
  @JsonKey(name: 'error_code')
  String? errorCode;
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

  DataCount(
      {this.errorCode,
      this.userId,
      this.userType,
      this.userName,
      this.ownerName,
      this.token});

  factory DataCount.fromJson(Map<String, dynamic> json) =>
      _$DataCountFromJson(json);

  Map<String, dynamic> toJson() => _$DataCountToJson(this);
}
