import 'package:json_annotation/json_annotation.dart';

import 'rep_detail.dart';

part 'buscollectionmdl.g.dart';

@JsonSerializable()
class Buscollectionmdl {
  String? status;
  @JsonKey(name: 'rep_details')
  List<RepDetail>? repDetails;

  Buscollectionmdl({this.status, this.repDetails});

  factory Buscollectionmdl.fromJson(Map<String, dynamic> json) {
    return _$BuscollectionmdlFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BuscollectionmdlToJson(this);
}
