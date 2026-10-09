import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/daycollection/collection_det/collection_det.dart';
import 'package:pompomtracker/model/daycollection/daycollectionresp/daycollectionresp.dart';

class StatementFunctions {
  StatementFunctions._internal();

  static StatementFunctions instance = StatementFunctions._internal();

  StatementFunctions factory() {
    return instance;
  }

  ValueNotifier<List<TicketList>> getDatewiseStmntNotifier = ValueNotifier([]);

  //ValueNotifier<List<Listdet>> getDayCollectionNotifier = ValueNotifier([]);

  ValueNotifier<DataCollection?> getDayCollectionNotifier = ValueNotifier(null);

  ValueNotifier<DataDetails?> getCollectDetNotifier = ValueNotifier(null);

  Future<DataDetails?> collectionStmntFn(
      String? selectedValue, Stmntfnparameter val) async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();
    List<TicketList> dtwiselist;
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
    if (selectedValue == dailyCollectn) {
      dtwiseresp = await Busdata().getDailyStmnt(dtwiserqst);
    } else if (selectedValue == dtWise) {
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
        if (selectedValue == dailyCollectn) {
          if (val.type == 'All') {
            dtwiselist = dtwiserspval.ticketDet;
          } else {
            dtwiselist = dtwiserspval.data?.ticketDet ?? [];
            getDatewiseStmntNotifier.value.clear();
            getDatewiseStmntNotifier.value.addAll(dtwiselist);
            getDatewiseStmntNotifier.notifyListeners();
            return dtwiserspval.data;
          }
        } else {
          dtwiselist = dtwiserspval.ticketDet;
        }

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
    return null;
  }

  Future getDayCollection(String collectDt, BuildContext context) async {
    try {
      Response<dynamic>? conductorListRespVar;
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      final condutorReq =
          BusListReq(userId: sharedValue!.userId, collectionDt: collectDt);

      conductorListRespVar = await Busdata().daycollection(condutorReq);

      if (conductorListRespVar == null) {
        getDayCollectionNotifier.value = null;
        getDayCollectionNotifier.notifyListeners();
      } else if (conductorListRespVar.statusCode == 200) {
        final resultAsJson = jsonDecode(conductorListRespVar.toString());
        final conductorListRespVal =
            Daycollectionresp.fromJson(resultAsJson as Map<String, dynamic>);

        if (conductorListRespVal.status == 'success') {
          getDayCollectionNotifier.value = conductorListRespVal.data;
          getDayCollectionNotifier.notifyListeners();
        } else if (conductorListRespVal.status == 'failed') {
          getDayCollectionNotifier.value = null;
          getDayCollectionNotifier.notifyListeners();
        }
      } else if (conductorListRespVar.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (conductorListRespVar.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Server Not reached");
      } else if (conductorListRespVar.statusCode == 408) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Connection time out");
      } else {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future getCollectionDet(
      String? busid, String? collectDt, BuildContext context) async {
    try {
      Response<dynamic>? conductorListRespVar;

      final condutorReq = BusListReq(busId: busid, collectionDt: collectDt);

      conductorListRespVar = await Busdata().collectDetails(condutorReq);

      if (conductorListRespVar == null) {
        getCollectDetNotifier.value = null;
        getCollectDetNotifier.notifyListeners();
      } else if (conductorListRespVar.statusCode == 200) {
        final resultAsJson = jsonDecode(conductorListRespVar.toString());
        final conductorListRespVal =
            CollectionDet.fromJson(resultAsJson as Map<String, dynamic>);

        if (conductorListRespVal.status == 'success') {
          // final data=conductorListRespVal.data;
          getCollectDetNotifier.value = conductorListRespVal.data;
          getCollectDetNotifier.notifyListeners();
        } else if (conductorListRespVal.status == 'failed') {
          getCollectDetNotifier.value = null;
          getCollectDetNotifier.notifyListeners();
        }
      } else if (conductorListRespVar.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (conductorListRespVar.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Server Not reached");
      } else if (conductorListRespVar.statusCode == 408) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Connection time out");
      } else {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }
}
