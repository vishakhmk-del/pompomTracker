import 'package:json_annotation/json_annotation.dart';

part 'permit_list.g.dart';

@JsonSerializable()
class PermitList {
  @JsonKey(name: 'permit_id')
  String? permitId;
  @JsonKey(name: 'permit_no')
  String? permitNo;

  PermitList({this.permitId, this.permitNo});

  factory PermitList.fromJson(Map<String, dynamic> json) {
    return _$PermitListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PermitListToJson(this);
}
