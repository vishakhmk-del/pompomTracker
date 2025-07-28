import 'package:json_annotation/json_annotation.dart';

part 'emplist.g.dart';

@JsonSerializable()
class Emplist {
  @JsonKey(name: 'emp_id')
  String? empId;

  String? name;

  Emplist({this.empId, this.name});

  factory Emplist.fromJson(Map<String, dynamic> json) {
    return _$EmplistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmplistToJson(this);
}
