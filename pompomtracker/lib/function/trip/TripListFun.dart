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
}
