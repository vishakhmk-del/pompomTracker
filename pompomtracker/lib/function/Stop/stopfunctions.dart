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

  Future stopDetFn(String? tripId) async {
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


  Future deleteStop(String? tripId,String? stopId) async {

    Response<dynamic>? dtwiseresp;

    final dtwiserqst = MasterListReq(
        tripId: tripId,
        stopId: stopId,
        );
    dtwiseresp = await Busdata().deleteStop(dtwiserqst);

    final reultAsJson = jsonDecode(dtwiseresp.toString());
    final resValue =
        StopMasterResp.fromJson(reultAsJson as Map<String, dynamic>);
    if(dtwiseresp==null){
      showerror(3);
    }
    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg: "Stop Deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
      final List<Listdet> currentList = StopFunctions.instance.getStopDetNotifier.value;

        // Remove the item where tripId and stopId match
        currentList.removeWhere((item) => item.tripId == tripId && item.stopId == stopId);

        // Update the notifier to trigger UI rebuild
        StopFunctions.instance.getStopDetNotifier.value = List.from(currentList);

    } else if (resValue.status == 'Failed') {
      showerror(2);
    } else {
      showerror(3);
    }
  }

  showerror(stat) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Stop Can't delete",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    }
  }
  Future<List<Listdet>> stopNameList(String? tripId) async {
    
    Response<dynamic>? dtwiseresp;
     List<Listdet> triplist = [];

    final dtwiserqst = MasterListReq(
        tripId: tripId,       
        );
    dtwiseresp = await Busdata().getStopname(dtwiserqst);

    if (dtwiseresp == null) {
      triplist = triplist;
      return triplist;
    } else if (dtwiseresp.statusCode == 200) {
      final resultAsjson = jsonDecode(dtwiseresp.toString());
      final dtwiserspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (dtwiserspval.status == 'success') {
       log('stop name fetch success');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        return triplist;
      } else if (dtwiserspval.status == 'Failed') {
        log('stop name fetch failed');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        return triplist;
      }
    } else {
      log('stop name fetch exception');
      triplist = triplist;
      return triplist;
    }
    return triplist;
  }

  Future<String?> addstopName(MasterListReq value) async {
    
    Response<dynamic>? dtwiseresp;
    
    dtwiseresp = await Busdata().addNewStop(value);

    final reultAsJson = jsonDecode(dtwiseresp.toString());
    final resValue =
        StopMasterResp.fromJson(reultAsJson as Map<String, dynamic>);
    if(dtwiseresp==null){
      showstoperror(3);
    }
    if (resValue.status == 'success') {
      Fluttertoast.showToast(
          msg: "Stop Added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
      return resValue.status;

    } else if (resValue.status == 'Failed') {
      showstoperror(2);
      return resValue.status;
    } else {
      showstoperror(3);
      return "Failed";
    }
  }
showstoperror(stat) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Stop Can't added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    }
  }
 
  }

