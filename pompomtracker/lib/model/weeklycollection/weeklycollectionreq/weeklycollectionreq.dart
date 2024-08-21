import 'package:json_annotation/json_annotation.dart';

part 'weeklycollectionreq.g.dart';

@JsonSerializable()
class Weeklycollectionreq {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'cur_date')
  String? curDate;

  Weeklycollectionreq({this.userId, this.curDate});
  Weeklycollectionreq.req({required this.userId,required this.curDate});

  factory Weeklycollectionreq.fromJson(Map<String, dynamic> json) {
    return _$WeeklycollectionreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeeklycollectionreqToJson(this);
}
