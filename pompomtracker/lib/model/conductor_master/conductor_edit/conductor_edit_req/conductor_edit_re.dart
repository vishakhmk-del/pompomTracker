import 'package:json_annotation/json_annotation.dart';

part 'conductor_edit_re.g.dart';

@JsonSerializable()
class ConductorEditRe {
  @JsonKey(name: 'conductor_id')
  String? conductorId;
  @JsonKey(name: 'driver_id')
  String? driverId;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;

  ConductorEditRe(
      {this.conductorId, this.userId, this.userType, this.driverId});

  factory ConductorEditRe.fromJson(Map<String, dynamic> json) {
    return _$ConductorEditReFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConductorEditReToJson(this);
}
