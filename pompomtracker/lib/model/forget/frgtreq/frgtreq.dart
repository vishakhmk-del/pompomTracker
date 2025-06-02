import 'package:json_annotation/json_annotation.dart';

part 'frgtreq.g.dart';

@JsonSerializable()
class Frgtreq {
  @JsonKey(name: 'mobile_no')
  String? mobileNo;
  String? pwd;

  Frgtreq({this.mobileNo, this.pwd});

  factory Frgtreq.fromJson(Map<String, dynamic> json) {
    return _$FrgtreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FrgtreqToJson(this);
}
