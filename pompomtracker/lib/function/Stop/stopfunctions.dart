import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';


class StopFunctions {
  StopFunctions._internal();
  static StopFunctions instance = StopFunctions._internal();
  StopFunctions factory() {
    return instance;
  }
  ValueNotifier<List<Listdet>> getStopDetNotifier = ValueNotifier([]);

  Future<List<Listdet>> tripNameList() async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();

    Response<dynamic>? dtwiseresp;
     List<Listdet> triplist = [];

    final dtwiserqst = MasterListReq(
        userId: sharevalue!.userId,
        usertype: sharevalue.userType,
        );
    dtwiseresp = await Busdata().getTripdet(dtwiserqst);

    if (dtwiseresp == null) {
      triplist = triplist;
      return triplist;
    } else if (dtwiseresp.statusCode == 200) {
      final resultAsjson = jsonDecode(dtwiseresp.toString());
      final dtwiserspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (dtwiserspval.status == 'success') {
       log('Trip  data fetch success');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        return triplist;
      } else if (dtwiserspval.status == 'Failed') {
        log('Route data fetch failed');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        return triplist;
      }
    } else {
      log('Route data fetch exception');
      triplist = triplist;
      return triplist;
    }
    return triplist;
  }

  Future stopDetFn(String tripId) async {
    final stopreq=MasterListReq(tripId: tripId);
    
    final stpresp = await Busdata().getStopdet(stopreq);

    if (stpresp == null) {
      log('stop list data fetch null');
      getStopDetNotifier.value.clear();
      getStopDetNotifier.value.addAll([]);
      getStopDetNotifier.notifyListeners();
    } else if (stpresp.statusCode == 200) {
      final resultAsjson = jsonDecode(stpresp.toString());
      final stprspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (stprspval.status == 'success') {
        log('stop list data fetch success');

        final stplist = stprspval.listDet;

        getStopDetNotifier.value.clear();
        getStopDetNotifier.value.addAll(stplist);
        getStopDetNotifier.notifyListeners();
      } else if (stprspval.status == 'Failed') {
        log('stop list data fetch failed');
        final stplist = stprspval.listDet;
        getStopDetNotifier.value.clear();
        getStopDetNotifier.value.addAll(stplist);
        getStopDetNotifier.notifyListeners();
      }
    } else {
      log('Stop list data fetch exception');
      getStopDetNotifier.value.clear();
      getStopDetNotifier.value.addAll([]);
      getStopDetNotifier.notifyListeners();
    }
  }


}
