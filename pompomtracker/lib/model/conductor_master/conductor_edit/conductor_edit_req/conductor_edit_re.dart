import 'package:json_annotation/json_annotation.dart';

part 'conductor_edit_re.g.dart';

@JsonSerializable()
class ConductorEditRe {
  @JsonKey(name: 'conductor_id')
  String? conductorId;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;

  ConductorEditRe(
      {required this.conductorId,
      required this.userId,
      required this.userType});

  factory ConductorEditRe.fromJson(Map<String, dynamic> json) {
    return _$ConductorEditReFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorEditReToJson(this);
}
