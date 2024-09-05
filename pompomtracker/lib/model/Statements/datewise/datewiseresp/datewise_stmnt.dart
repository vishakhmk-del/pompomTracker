import 'package:pompomtracker/core/hook/hook.dart';

class DatewiseStmnt {
  String? status;
  String? message;
  List<TicketList> ticketDet;
  DatewiseStmnt({this.status, this.message, this.ticketDet = const []});
  factory DatewiseStmnt.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["ticket_det"] ?? []) as List);
    List<TicketList> wklylist =
        tklst.map((e) => TicketList.fromJson(e)).toList();
    return DatewiseStmnt(
      status: json["status"],
      message: json["message"],
      ticketDet: wklylist,
    );
  }
  Map<String, dynamic> toJson() =>
      {"status": status, "message": message, "ticket_det": ticketDet};
}
