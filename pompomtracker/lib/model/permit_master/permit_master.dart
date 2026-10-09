import 'package:json_annotation/json_annotation.dart';
import 'package:pompomtracker/model/permit_master/doctypelist.dart';

import 'permit_list.dart';

part 'permit_master.g.dart';

@JsonSerializable()
class PermitMaster {
  String? status;
  String? message;
  @JsonKey(name: 'permit_list')
  List<PermitList>? permitList;
  @JsonKey(name: 'doc_type_list')
  List<Doctypelist>? docTypeList;

  PermitMaster({this.status, this.message, this.permitList, this.docTypeList});

  factory PermitMaster.fromJson(Map<String, dynamic> json) {
    return _$PermitMasterFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PermitMasterToJson(this);
}
