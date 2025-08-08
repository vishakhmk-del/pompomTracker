import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'daycollectionresp.g.dart';

@JsonSerializable()
class Daycollectionresp {
  String? status;
  String? message;
  DataCollection? data;

  Daycollectionresp({this.status, this.message, this.data});

  factory Daycollectionresp.fromJson(Map<String, dynamic> json) {
    return _$DaycollectionrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DaycollectionrespToJson(this);
}
