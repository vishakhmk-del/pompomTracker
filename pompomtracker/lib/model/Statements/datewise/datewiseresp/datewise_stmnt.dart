import 'package:pompomtracker/core/hook/hook.dart';

class DatewiseStmnt {
  String? status;
  String? message;
  DataDetails? data;
  List<TicketList> ticketDet;
  DatewiseStmnt(
      {this.status, this.message, this.data, this.ticketDet = const []});
  factory DatewiseStmnt.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["ticket_det"] ?? []) as List);
    List<TicketList> wklylist =
        tklst.map((e) => TicketList.fromJson(e)).toList();
    return DatewiseStmnt(
      status: json["status"],
      message: json["message"],
      data: json["data"] != null ? DataDetails.fromJson(json["data"]) : null,
      ticketDet: wklylist,
    );
  }
  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "ticket_det": ticketDet.map((e) => e.toJson()).toList(),
      };
}
