import 'package:json_annotation/json_annotation.dart';

import 'ticket_det.dart';

part 'dailystatement.g.dart';

@JsonSerializable()
class Dailystatement {
  String? status;
  String? message;
  @JsonKey(name: 'ticket_det')
  List<TicketDet>? ticketDet;

  Dailystatement({this.status, this.message, this.ticketDet});

  factory Dailystatement.fromJson(Map<String, dynamic> json) {
    return _$DailystatementFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DailystatementToJson(this);
}
