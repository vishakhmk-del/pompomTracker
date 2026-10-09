import 'package:json_annotation/json_annotation.dart';
import 'package:pompomtracker/model/login/loginresp/data.dart';

part 'loginresp.g.dart';

@JsonSerializable()
class Loginresp {
  String? status;
  String? message;
  @JsonKey(name: 'error_code')
  String? errorCode;
  bool? mandatory;
  DataCount? data;

  Loginresp(
      {this.status, this.message, this.errorCode, this.mandatory, this.data});

  factory Loginresp.fromJson(Map<String, dynamic> json) {
    return _$LoginrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginrespToJson(this);
}
