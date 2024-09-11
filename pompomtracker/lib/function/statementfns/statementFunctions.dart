import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class StatementFunctions {
  StatementFunctions._internal();
  static StatementFunctions instance = StatementFunctions._internal();
  StatementFunctions factory() {
    return instance;
  }

  ValueNotifier<List<TicketList>> getDatewiseStmntNotifier = ValueNotifier([]);

  Future collectionStmntFn(String? selectedValue, Stmntfnparameter val) async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();

    Response<dynamic>? dtwiseresp;

    String? dateString = val.fromdate;
    DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime dateTime = format.parse(dateString!);
    print(dateTime);
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String fmdt = dateFormat.format(dateTime);
    print(fmdt);

    String? todtval = val.todate;
    DateFormat format1 = DateFormat("dd-MM-yyyy");
    DateTime dateTime2 = format1.parse(todtval!);
    print(dateTime2);
    DateFormat dateFormat2 = DateFormat("yyyy-MM-dd");
    String todt = dateFormat2.format(dateTime2);
    print(todt);

    final dtwiserqst = Datewisereq.req(
        userId: sharevalue!.userId,
        userType: sharevalue.userType,
        fromdate: fmdt,
        todate: todt,
        regNo: val.type,
        summary: val.summary,
        mode: val.mode);

    if (selectedValue == dtWise) {
      dtwiseresp = await Busdata().getDatewiseStmnt(dtwiserqst);
    } else if (selectedValue == bsWise) {
      dtwiseresp = await Busdata().getBuswiseStmnt(dtwiserqst);
    } else if (selectedValue == exStatmnt) {
      dtwiseresp = await Busdata().getExpenseStmnt(dtwiserqst);
    } else if (selectedValue == chStatmnt) {
      dtwiseresp = await Busdata().getCashStmnt(dtwiserqst);
    }

    if (dtwiseresp == null) {
      log('weeklycollection data fetch null');
      getDatewiseStmntNotifier.value.clear();
      getDatewiseStmntNotifier.value.addAll([]);
      getDatewiseStmntNotifier.notifyListeners();
    } else if (dtwiseresp.statusCode == 200) {
      final resultAsjson = jsonDecode(dtwiseresp.toString());
      final dtwiserspval =
          DatewiseStmnt.fromJson(resultAsjson as Map<String, dynamic>);
      if (dtwiserspval.status == 'success') {
        log('weeklycollection data fetch success');

        final dtwiselist = dtwiserspval.ticketDet;

        getDatewiseStmntNotifier.value.clear();
        getDatewiseStmntNotifier.value.addAll(dtwiselist);
        getDatewiseStmntNotifier.notifyListeners();
      } else if (dtwiserspval.status == 'Failed') {
        log('weeklycollection data fetch failed');
        final dtwiselist = dtwiserspval.ticketDet;
        getDatewiseStmntNotifier.value.clear();
        getDatewiseStmntNotifier.value.addAll(dtwiselist);
        getDatewiseStmntNotifier.notifyListeners();
      }
    } else {
      log('weeklycollection data fetch exception');
      getDatewiseStmntNotifier.value.clear();
      getDatewiseStmntNotifier.value.addAll([]);
      getDatewiseStmntNotifier.notifyListeners();
    }
  }
}
