import 'package:json_annotation/json_annotation.dart';

part 'datewisereq.g.dart';

@JsonSerializable()
class Datewisereq {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_type')
  String? userType;
  String? fromdate;
  String? todate;
  @JsonKey(name: 'reg_no')
  String? regNo;
  @JsonKey(name: 'summary')
  bool? summary;

  Datewisereq(
      {this.userId,
      this.userType,
      this.fromdate,
      this.todate,
      this.regNo,
      this.summary});

  Datewisereq.req(
      {required this.userId,
      this.userType,
      required this.fromdate,
      required this.todate,
      this.regNo,
      this.summary});

  factory Datewisereq.fromJson(Map<String, dynamic> json) {
    return _$DatewisereqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DatewisereqToJson(this);
}
