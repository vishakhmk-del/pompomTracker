import 'package:json_annotation/json_annotation.dart';

part 'stmntfnparameter.g.dart';

@JsonSerializable()
class Stmntfnparameter {
  String? type;
  String? fromdate;
  String? todate;
  bool? summary;
  String? mode;

  Stmntfnparameter(
      {this.type, this.fromdate, this.todate, this.summary, this.mode});

  factory Stmntfnparameter.fromJson(Map<String, dynamic> json) {
    return _$StmntfnparameterFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StmntfnparameterToJson(this);
}
