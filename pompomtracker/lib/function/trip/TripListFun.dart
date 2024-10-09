import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';

class TripListFuntions {
  TripListFuntions._internal();
  static TripListFuntions instance = TripListFuntions._internal();
  TripListFuntions factory() {
    return instance;
  }

  ValueNotifier<List<Listdet>> getTripListNotifier = ValueNotifier([]);
  Future getTripList(selectedBusList) async {
    // print('nnn');
    Response<dynamic>? tripListRespVar;
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final tripReq = MasterListReq(
        userId: sharedValue!.userId,
        usertype: sharedValue.userType,
        busRegNo: selectedBusList);
    tripListRespVar = await Busdata().fetchTripList(tripReq);
    if (tripListRespVar == null) {
//print('null');
      getTripListNotifier.value.clear();
      getTripListNotifier.value.addAll([]);
      getTripListNotifier.notifyListeners();
    } else if (tripListRespVar.statusCode == 200) {
      final resultAsJson = jsonDecode(tripListRespVar.toString());
      final tripListRespVal =
          MasterListMdl.fromJson(resultAsJson as Map<String, dynamic>);
      if (tripListRespVal.status == 'success') {
        //print('sucess');
        final item_det = tripListRespVal.listDet;
        //print(item_det.);
        getTripListNotifier.value.clear();
        getTripListNotifier.value.addAll(item_det);
        getTripListNotifier.notifyListeners();
      } else if (tripListRespVal.status == 'Failed') {
        final item_det = tripListRespVal.listDet;
        getTripListNotifier.value.clear();
        getTripListNotifier.value.addAll(item_det);
        getTripListNotifier.notifyListeners();
      }
    }
  }

  Future tripEditFun(regNo, tripId) async {
    List<Listdet>? tripDetailslist = [];
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final tripEdit = MasterListReq(
        userId: sharedValue!.userId,
        usertype: sharedValue.userType,
        busRegNo: regNo,
        tripId: tripId);
    Response<dynamic>? tripEditResp;
    tripEditResp = await Busdata().fetchTripEdit(tripEdit);
    if (tripEditResp == null) {
      tripDetailslist = tripDetailslist;
      return tripDetailslist;
    } else if (tripEditResp.statusCode == 200) {
      //  print(tripEditResp);
      final resultAsJson = jsonDecode(tripEditResp.toString());
      final Details =
          MasterListMdl.fromJson(resultAsJson as Map<String, dynamic>);
      if (Details.status == 'success') {
        tripDetailslist = Details.listDet;
        return tripDetailslist;
      } else if (Details.status == 'Failed') {
        tripDetailslist = Details.listDet;
        return tripDetailslist;
      }
    } else {
      tripDetailslist = tripDetailslist;
      return tripDetailslist;
    }
    return tripDetailslist;
  }

  Future<List<Listdet>> sortedrouteList(String? regno) async {
    
    Response<dynamic>? dtwiseresp;
     List<Listdet> triplist = [];

    final dtwiserqst = MasterListReq(
        regNo: regno,       
        );
    dtwiseresp = await Busdata().sortedRoute(dtwiserqst);

    if (dtwiseresp == null) {
      triplist = triplist;
      return triplist;
    } else if (dtwiseresp.statusCode == 200) {
      final resultAsjson = jsonDecode(dtwiseresp.toString());
      final dtwiserspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (dtwiserspval.status == 'success') {
       log('sorted route fetch success');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        return triplist;
      } else if (dtwiserspval.status == 'Failed') {
        log('sorted route  fetch failed');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        return triplist;
      }
    } else {
      log('sorted route  fetch exception');
      triplist = triplist;
      return triplist;
    }
    return triplist;
  }

  Future<List<Listdet>> stationList(int? routeId) async {
    
    Response<dynamic>? dtwiseresp;
     List<Listdet> triplist = [];

    final dtwiserqst = MasterListReq(
        routeId: routeId,       
        );
    dtwiseresp = await Busdata().fromToStaton(dtwiserqst);

    if (dtwiseresp == null) {
      triplist = triplist;
      return triplist;
    } else if (dtwiseresp.statusCode == 200) {
      final resultAsjson = jsonDecode(dtwiseresp.toString());
      final dtwiserspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (dtwiserspval.status == 'success') {
       log('sorted route fetch success');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        return triplist;
      } else if (dtwiserspval.status == 'Failed') {
        log('sorted route  fetch failed');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        return triplist;
      }
    } else {
      log('sorted route  fetch exception');
      triplist = triplist;
      return triplist;
    }
    return triplist;
  }
}
