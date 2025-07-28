import 'package:json_annotation/json_annotation.dart';

part 'conductor_edit_re.g.dart';

@JsonSerializable()
class ConductorEditRe {
  @JsonKey(name: 'emp_id')
  String? empId;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'emp_type')
  int? empType;

  ConductorEditRe({
    this.empId,
    this.userId,
    this.empType,
  });

  factory ConductorEditRe.fromJson(Map<String, dynamic> json) {
    return _$ConductorEditReFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorEditReToJson(this);
}
