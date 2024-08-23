import 'package:pompomtracker/model/weeklycollection/wklycollectnmdltyp2/buswklycollect.dart';

class Buswklycollction {
  String? status;
  List<Buswklycollectlist> repDetails;

  Buswklycollction({this.status, this.repDetails = const []});
  factory Buswklycollction.fromJson(Map<String, dynamic> json) {
    var collctlst = ((json["rep_details"] ?? []) as List);
    List<Buswklycollectlist> wklylist =
        collctlst.map((e) => Buswklycollectlist.fromMap(e)).toList();
    return Buswklycollction(
      status: json["status"],
      repDetails: wklylist,
    );
  }
  Map<String, dynamic> toJson() =>
      {"status": status, "rep_details": repDetails};
}
