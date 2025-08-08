import 'package:pompomtracker/core/hook/hook.dart';

class BusRouteListFunctions {
  BusRouteListFunctions._internal();
  static BusRouteListFunctions instance = BusRouteListFunctions._internal();
  BusRouteListFunctions factory() {
    return instance;
  }

  ValueNotifier<List<Listdet>> getBusRouteListNotifier = ValueNotifier([]);

  Future getBusRouteList() async {
    // print('nnn');
    Response<dynamic>? busRouteReqListRespVar;
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final busRouteReq = MasterListReq(
        userId: sharedValue!.userId, usertype: sharedValue.userType);
    busRouteReqListRespVar = await Busdata().fetchBusRouteList(busRouteReq);
    if (busRouteReqListRespVar == null) {
      //print('null');
      getBusRouteListNotifier.value.clear();
      getBusRouteListNotifier.value.addAll([]);
      getBusRouteListNotifier.notifyListeners();
    } else if (busRouteReqListRespVar.statusCode == 200) {
      final resultAsJson = jsonDecode(busRouteReqListRespVar.toString());
      final busRouteListRespVal =
          MasterListMdl.fromJson(resultAsJson as Map<String, dynamic>);
      if (busRouteListRespVal.status == 'success') {
        //print('sucess');
        final item_det = busRouteListRespVal.listDet;
        //print(item_det.);
        getBusRouteListNotifier.value.clear();
        getBusRouteListNotifier.value.addAll(item_det);
        getBusRouteListNotifier.notifyListeners();
      } else if (busRouteListRespVal.status == 'Failed') {
        final item_det = busRouteListRespVal.listDet;
        getBusRouteListNotifier.value.clear();
        getBusRouteListNotifier.value.addAll(item_det);
        getBusRouteListNotifier.notifyListeners();
      }
    }
  }
}
