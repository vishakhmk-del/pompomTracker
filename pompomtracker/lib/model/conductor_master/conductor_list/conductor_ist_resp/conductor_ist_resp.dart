import 'package:pompomtracker/model/conductor_master/conductor_list/conductor_ist_resp/conductor_list.dart';
import 'package:pompomtracker/model/conductor_master/conductor_list/conductor_list_req/conductor_list_req.dart';

class ConductorIstResp {
  String? status;
  String? message;

  List<ConductorList>? conductorList;

  ConductorIstResp({this.status, this.message, this.conductorList = const []});

  factory ConductorIstResp.fromJson(Map<String, dynamic> json) {
    var conductorlst = ((json["conductor_list"] ?? []) as List);
    List<ConductorList> busdetailslist =
        conductorlst.map((e) => ConductorList.fromJson(e)).toList();
    return ConductorIstResp(
      status: json["status"],
      message: json["message"],
      conductorList: busdetailslist,
    );
  }
}
