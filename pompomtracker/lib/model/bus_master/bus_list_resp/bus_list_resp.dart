import 'package:pompomtracker/core/hook/hook.dart';

class BusListResp {
  String? status;
  String? message;
  List<BusList> busDet;
  BusListResp({this.status, this.message, this.busDet = const []});
  factory BusListResp.fromJson(Map<String, dynamic> json) {
    var buslst = ((json["bus_list"] ?? []) as List);
    List<BusList> busdetailslist =
        buslst.map((e) => BusList.fromJson(e)).toList();
    return BusListResp(
      status: json["status"],
      message: json["message"],
      busDet: busdetailslist,
    );
  }
}
