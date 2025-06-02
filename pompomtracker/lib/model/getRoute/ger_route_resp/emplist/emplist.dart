import 'package:json_annotation/json_annotation.dart';

part 'emplist.g.dart';

@JsonSerializable()
class Emplist {
  @JsonKey(name: 'conductor_id')
  String? conductorId;
  @JsonKey(name: 'driver_id')
  String? driverId;
  String? name;

  Emplist({this.conductorId, this.name, this.driverId});

  factory Emplist.fromJson(Map<String, dynamic> json) {
    return _$EmplistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmplistToJson(this);
}
