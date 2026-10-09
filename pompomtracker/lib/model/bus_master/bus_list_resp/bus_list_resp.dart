import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/bus_master/bus_list_resp/document_list.dart';

class BusListResp {
  String? status;
  String? message;
  List<BusList> busDet;
  List<DocumentList> docDet;

  BusListResp({this.status, this.message, this.busDet = const [],this.docDet = const []});
  factory BusListResp.fromJson(Map<String, dynamic> json) {
    var buslst = ((json["bus_list"] ?? []) as List);
    List<BusList> busdetailslist =
        buslst.map((e) => BusList.fromJson(e)).toList();

    var doclst = ((json["document_list"] ?? []) as List);
    List<DocumentList> docmentlist =
        doclst.map((e) => DocumentList.fromJson(e)).toList();
        
    return BusListResp(
      status: json["status"],
      message: json["message"],
      busDet: busdetailslist,
      docDet: docmentlist
    );
  }
}
