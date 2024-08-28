import 'package:json_annotation/json_annotation.dart';

part 'registration_req.g.dart';

@JsonSerializable()
class RegistrationReq {
  @JsonKey(name: 'user_id')
  String? userId;

  RegistrationReq({required this.userId});

  factory RegistrationReq.fromJson(Map<String, dynamic> json) {
    return _$RegistrationReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegistrationReqToJson(this);
}
