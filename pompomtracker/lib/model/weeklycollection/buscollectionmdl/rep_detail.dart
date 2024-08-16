import 'package:json_annotation/json_annotation.dart';

part 'rep_detail.g.dart';

@JsonSerializable()
class RepDetail {
  String? amount;
  @JsonKey(name: 'pay_date')
  String? payDate;

  RepDetail({this.amount, this.payDate});

  factory RepDetail.fromJson(Map<String, dynamic> json) {
    return _$RepDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RepDetailToJson(this);
}
