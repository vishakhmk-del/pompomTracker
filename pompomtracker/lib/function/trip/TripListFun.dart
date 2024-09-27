import 'package:pompomtracker/core/hook/hook.dart';

class TripListFuntions {
  TripListFuntions._internal();
  static TripListFuntions instance = TripListFuntions._internal();
  TripListFuntions factory() {
    return instance;
  }

  ValueNotifier<List<Listdet>> getTripListNotifier = ValueNotifier([]);
  Future getTripList() async {
    // print('nnn');
    Response<dynamic>? tripListRespVar;
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final tripReq = MasterListReq(
        userId: sharedValue!.userId, usertype: sharedValue.userType);
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

  Future TripEditFun(String regNo, int tripId) async {}
}
