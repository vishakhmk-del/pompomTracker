import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'collection_det.g.dart';

@JsonSerializable()
class CollectionDet {
  String? status;
  String? message;
  DataDetails? data;

  CollectionDet({this.status, this.message, this.data});

  factory CollectionDet.fromJson(Map<String, dynamic> json) {
    return _$CollectionDetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CollectionDetToJson(this);
}
