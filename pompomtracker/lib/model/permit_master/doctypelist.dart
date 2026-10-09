import 'package:json_annotation/json_annotation.dart';

part 'doctypelist.g.dart';

@JsonSerializable()
class Doctypelist {
  int? id;
  @JsonKey(name: 'doc_type')
  String? docType;
  @JsonKey(name: 'doc_flag')
  int? docFlag;

  Doctypelist({this.id, this.docType, this.docFlag});

  factory Doctypelist.fromJson(Map<String, dynamic> json) {
    return _$DoctypelistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctypelistToJson(this);
}
