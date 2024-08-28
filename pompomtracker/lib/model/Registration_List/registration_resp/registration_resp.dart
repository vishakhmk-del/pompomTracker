import 'package:json_annotation/json_annotation.dart';

import 'bus_list.dart';

part 'registration_resp.g.dart';

@JsonSerializable()
class RegistrationResp {
  String? status;
  String? message;
  @JsonKey(name: 'bus_list')
  List<BusList>? busList;

  RegistrationResp({this.status, this.message, this.busList});

  factory RegistrationResp.fromJson(Map<String, dynamic> json) {
    return _$RegistrationRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegistrationRespToJson(this);
}
