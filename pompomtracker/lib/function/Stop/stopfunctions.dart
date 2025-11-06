import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';

class StopFunctions {
  StopFunctions._internal();
  static StopFunctions instance = StopFunctions._internal();
  StopFunctions factory() {
    return instance;
  }

  ValueNotifier<List<Listdet>> getStopDetNotifier = ValueNotifier([]);
  ValueNotifier<List<Listdet>> getExistingStopNotifier = ValueNotifier([]);
  ValueNotifier<List<Listdet>> getPriviewStopNotifier = ValueNotifier([]);

  Future<List<Listdet>> tripNameList(String? busid,BuildContext context) async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();

    Response<dynamic>? dtwiseresp;
    List<Listdet> triplist = [];

    final dtwiserqst = MasterListReq(
      busId:busid,
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

  Future<List<Listdet>> stopDetFn(String? tripId) async {
    final stopreq = MasterListReq(tripId: tripId);
    List<Listdet> stplist = [];

    final stpresp = await Busdata().getStopdet(stopreq);

    if (stpresp == null) {
      log('stop list data fetch null');
      getStopDetNotifier.value.clear();
      getStopDetNotifier.value.addAll([]);
      getStopDetNotifier.notifyListeners();
      stplist = stplist;
      return stplist;
    } else if (stpresp.statusCode == 200) {
      final resultAsjson = jsonDecode(stpresp.toString());
      final stprspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (stprspval.status == 'success') {
        log('stop list data fetch success');

        final stoplist = stprspval.listDet;

        getStopDetNotifier.value.clear();
        getStopDetNotifier.value.addAll(stplist);
        getStopDetNotifier.notifyListeners();
        stplist = stoplist;
      return stplist;
      } else if (stprspval.status == 'Failed') {
        log('stop list data fetch failed');
        final stoplist = stprspval.listDet;
        getStopDetNotifier.value.clear();
        getStopDetNotifier.value.addAll(stplist);
        getStopDetNotifier.notifyListeners();
        stplist = stoplist;
      return stplist;
      }
    } else {
      log('Stop list data fetch exception');
      getStopDetNotifier.value.clear();
      getStopDetNotifier.value.addAll([]);
      getStopDetNotifier.notifyListeners();
      stplist = stplist;
      return stplist;
    }
      return stplist;

  }

  Future deleteStop(String? tripId, String? stopId) async {
    Response<dynamic>? dtwiseresp;

    final dtwiserqst = MasterListReq(
      tripId: tripId,
      stopId: stopId,
    );
    dtwiseresp = await Busdata().deleteStop(dtwiserqst);

    final reultAsJson = jsonDecode(dtwiseresp.toString());
    final resValue =
        StopMasterResp.fromJson(reultAsJson as Map<String, dynamic>);
    if (dtwiseresp == null) {
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
      final List<Listdet> currentList =
          StopFunctions.instance.getStopDetNotifier.value;

      // Remove the item where tripId and stopId match
      currentList.removeWhere(
          (item) => item.tripId == tripId && item.stopId == stopId);

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
    if (dtwiseresp == null) {
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

  // Future<List<Listdet>> getExistingStpFn(String? tripId) async {
  //   final sharevalue = await SharedPrefManager.instance.getSharedData();

  //   final stopreq = MasterListReq(
  //       tripId: tripId,
  //       userId: sharevalue!.userId,
  //       usertype: sharevalue.userType);
  //   List<Listdet> stplist = [];

  //   final stpresp = await Busdata().exstingStop(stopreq);

  //   if (stpresp == null) {
  //     log('stop list data fetch null');
  //     getExistingStopNotifier.value.clear();
  //     getExistingStopNotifier.value.addAll([]);
  //     getExistingStopNotifier.notifyListeners();
  //     stplist = stplist;
  //     return stplist;
  //   } else if (stpresp.statusCode == 200) {
  //     final resultAsjson = jsonDecode(stpresp.toString());
  //     final stprspval =
  //         MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
  //     if (stprspval.status == 'success') {
  //       log('stop list data fetch success');

  //       final stoplist = stprspval.listDet;

  //       getExistingStopNotifier.value.clear();
  //       getExistingStopNotifier.value.addAll(stoplist);
  //       getExistingStopNotifier.notifyListeners();
  //       //final routeList = dtwiserspval.listDet;
  //       stplist = stoplist;
  //       return stplist;
  //     } else if (stprspval.status == 'Failed') {
  //       log('stop list data fetch failed');
  //       final stoplist = stprspval.listDet;
  //       getExistingStopNotifier.value.clear();
  //       getExistingStopNotifier.value.addAll(stoplist);
  //       getExistingStopNotifier.notifyListeners();

  //       //final routeList = dtwiserspval.listDet;
  //       stplist = stoplist;
  //       return stplist;
  //     }
  //   } else {
  //     log('Stop list data fetch exception');
  //     getExistingStopNotifier.value.clear();
  //     getExistingStopNotifier.value.addAll([]);
  //     getExistingStopNotifier.notifyListeners();
  //     stplist = stplist;
  //     return stplist;
  //   }
  //   return stplist;
  // }
  Future<Map<String, dynamic>>  getExistingStpFn(String? tripId) async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();

    final stopreq = MasterListReq(
        tripId: tripId,
        userId: sharevalue!.userId,
        usertype: sharevalue.userType);
    List<Listdet> stplist = [];
    int flag = 0;
    final stpresp = await Busdata().exstingStop(stopreq);

    if (stpresp == null) {
      log('stop list data fetch null');
      getExistingStopNotifier.value.clear();
      getExistingStopNotifier.value.addAll([]);
      getExistingStopNotifier.notifyListeners();
      stplist = stplist;
      return {
        'stops': stplist,
        'flag': flag,
      };
    } else if (stpresp.statusCode == 200) {
      final resultAsjson = jsonDecode(stpresp.toString());
      final stprspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (stprspval.status == 'success') {
        log('stop list data fetch success');

        final stoplist = stprspval.listDet;
        final flagvalue=stprspval.flag;
        getExistingStopNotifier.value.clear();
        getExistingStopNotifier.value.addAll(stoplist);
        getExistingStopNotifier.notifyListeners();
        //final routeList = dtwiserspval.listDet;
        stplist = stoplist;
        return {
          'stops': stplist,
          'flag': flagvalue,
        };
      } else if (stprspval.status == 'failed') {
        log('stop list data fetch failed');
        final stoplist = stprspval.listDet;
        getExistingStopNotifier.value.clear();
        getExistingStopNotifier.value.addAll(stoplist);
        getExistingStopNotifier.notifyListeners();

        //final routeList = dtwiserspval.listDet;
        stplist = stoplist;
        return {
        'stops': stplist,
        'flag': flag,
      };
      }
    } else {
      log('Stop list data fetch exception');
      getExistingStopNotifier.value.clear();
      getExistingStopNotifier.value.addAll([]);
      getExistingStopNotifier.notifyListeners();
      stplist = stplist;
      return {
        'stops': stplist,
        'flag': flag,
      };
    }
    return {
        'stops': stplist,
        'flag': flag,
      };
  }
  Future getPrvwStpFn(String? tripId,int? flag) async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();

    final stopreq = MasterListReq(
        tripId: tripId,
        userId: sharevalue!.userId,
        usertype: sharevalue.userType);
    // List<Listdet> stplist = [];

    final stpresp = await Busdata().prvwStop(stopreq);

    if (stpresp == null) {
      log('stop list data fetch null');
      if(flag==0){
        getPriviewStopNotifier.value.clear();
      getPriviewStopNotifier.value.addAll([]);
      getPriviewStopNotifier.notifyListeners();
      }else{
        getExistingStopNotifier.value.clear();
      getExistingStopNotifier.value.addAll([]);
      getExistingStopNotifier.notifyListeners();
      }
      
      
    } else if (stpresp.statusCode == 200) {
      final resultAsjson = jsonDecode(stpresp.toString());
      final stprspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (stprspval.status == 'success') {
        log('stop list data fetch success');

        final stoplist = stprspval.listDet;
        if(flag==0){
        getPriviewStopNotifier.value.clear();
        getPriviewStopNotifier.value.addAll(stoplist);
        getPriviewStopNotifier.notifyListeners();
        }else{
          getExistingStopNotifier.value.clear();
          getExistingStopNotifier.value.addAll(stoplist);
          getExistingStopNotifier.notifyListeners();
        }
        
        //final routeList = dtwiserspval.listDet;
        // stplist = stoplist;
        // return stplist;
      } else if (stprspval.status == 'failed') {
        log('stop list data fetch failed');
        if(flag==0){
        getPriviewStopNotifier.value.clear();
        getPriviewStopNotifier.value.addAll([]);
        getPriviewStopNotifier.notifyListeners();
        }else{
          getExistingStopNotifier.value.clear();
        getExistingStopNotifier.value.addAll([]);
        getExistingStopNotifier.notifyListeners();
        }

        //final routeList = dtwiserspval.listDet;
        // stplist = stoplist;
        // return stplist;
      }
    } else {
      log('Stop list data fetch exception');
      if(flag==0){
        getPriviewStopNotifier.value.clear();
        getPriviewStopNotifier.value.addAll([]);
        getPriviewStopNotifier.notifyListeners();
        }else{
          getExistingStopNotifier.value.clear();
          getExistingStopNotifier.value.addAll([]);
          getExistingStopNotifier.notifyListeners();
          }
      // stplist = stplist;
      // return stplist;
    }
    // return stplist;
  }
Future updateStopdet(String? tripid, BuildContext context) async {
    try {
      Response<dynamic>? conductorListRespVar;
      final sharevalue = await SharedPrefManager.instance.getSharedData();

    final stopreq = MasterListReq(
        tripId: tripid,
        userId: sharevalue!.userId,
        usertype: sharevalue.userType);
   // List<Listdet> stplist = [];

      conductorListRespVar = await Busdata().updateStop(stopreq);

      if (conductorListRespVar == null) {
      } else if (conductorListRespVar.statusCode == 200) {
        final resultAsJson = jsonDecode(conductorListRespVar.toString());
        final conductorListRespVal = MasterListMdl.fromJson(resultAsJson as Map<String, dynamic>);

        if (conductorListRespVal.status == 'success') {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "updated successfully");
        Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ScreenStopMasterNew(),
                    ),
                  );

        } else if (conductorListRespVal.status == 'failed') {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "Unable to update stop.");

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

  Future<String?> editArrivingTime(Listdet value) async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();
    Response<dynamic>? dtwiseresp;
    List<Listdet> triplist = [];
    String stage = value.isStage == "y" ? "y" : "n";

    final dtwiserqst = MasterListReq(
      userId: sharevalue!.userId,
      tripId: value.tripId,
      stopId: value.stopId,
      km: value.km,
      isStage: stage,
      stageId: value.stageId,
      stopName: value.stopName,
      arrivingTime: value.arrivingTime,
      departureTime: value.departureTime
    );

    dtwiseresp = await Busdata().editArvTime(dtwiserqst);

    if (dtwiseresp == null) {
      triplist = triplist;
      return "Failed";
    } else if (dtwiseresp.statusCode == 200) {
      final resultAsjson = jsonDecode(dtwiseresp.toString());
      final dtwiserspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (dtwiserspval.status == 'success') {
        log('stop details added success');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        Fluttertoast.showToast(
            msg: "Stop details added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 15.0);

        return dtwiserspval.status;
      } else if (dtwiserspval.status == 'failed') {
        log('stop details added failed');
        final routeList = dtwiserspval.listDet;
        triplist = routeList;
        showArvTimerror(2);
        return dtwiserspval.status;
      }
    } else {
      log('stop name fetch exception');
      triplist = triplist;
      showArvTimerror(3);
      return "Failed";
    }
    return "Failed";
  }

  showArvTimerror(stat) {
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Stop details cant added",
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

  Future<List<Listdet>> tripNewNameList(String? busid,BuildContext context) async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();

    Response<dynamic>? dtwiseresp;
    List<Listdet> triplist = [];

    final dtwiserqst = MasterListReq(
      userId: sharevalue!.userId,
      usertype: sharevalue.userType,
      busId: busid
    );
    dtwiseresp = await Busdata().getNewTripdet(dtwiserqst);

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


}
