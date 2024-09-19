import 'package:pompomtracker/core/hook/hook.dart';

class MasterListMdl {
  String? status;
  String? message;
  List<Listdet> listDet;
  MasterListMdl({this.status, this.message, this.listDet = const []});
  factory MasterListMdl.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["list_det"] ?? []) as List);
    List<Listdet> wklylist = tklst.map((e) => Listdet.fromJson(e)).toList();
    return MasterListMdl(
      status: json["status"],
      message: json["message"],
      listDet: wklylist,
    );
  }
  Map<String, dynamic> toJson() =>
      {"status": status, "message": message, "list_det": listDet};
}
