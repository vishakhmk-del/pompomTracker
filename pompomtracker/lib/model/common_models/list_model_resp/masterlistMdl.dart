import 'package:pompomtracker/core/hook/hook.dart';

class MasterListMdl {
  String? status;
  String? message;
  int? flag;

  List<Listdet> listDet;
  MasterListMdl({this.status, this.message,this.flag, this.listDet = const []});
  factory MasterListMdl.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["list_det"] ?? []) as List);
    List<Listdet> wklylist = tklst.map((e) => Listdet.fromJson(e)).toList();
    return MasterListMdl(
      status: json["status"],
      message: json["message"],
      flag: json["flag"],
      listDet: wklylist,
    );
  }
  Map<String, dynamic> toJson() =>
      {"status": status, "message": message,"flag":flag, "list_det": listDet};
}
