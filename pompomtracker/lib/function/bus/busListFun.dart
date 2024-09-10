import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';

class BusListFunctions {
  BusListFunctions._internal();
  static BusListFunctions instance = BusListFunctions._internal();
  BusListFunctions factory() {
    return instance;
  }

  ValueNotifier<List<BusList>> getBusListNotifier = ValueNotifier([]);
  Future getBusDetails() async {
    Response<dynamic>? busListResp;
    final sharevalue = await SharedPrefManager.instance.getSharedData();
    final busreq =
        BusListReq(userId: sharevalue!.userId, userType: sharevalue.userType);
    busListResp = await Busdata().fetchBusList(busreq);
    if (busListResp == null) {
      getBusListNotifier.value.clear();
      getBusListNotifier.value.addAll([]);
      getBusListNotifier.notifyListeners();
    } else if (busListResp.statusCode == 200) {
      final resultAsJson = jsonDecode(busListResp.toString());
      final busListRespVal =
          BusListResp.fromJson(resultAsJson as Map<String, dynamic>);

      if (busListRespVal.status == 'success') {
        final buslist_det = busListRespVal.busDet;
        getBusListNotifier.value.clear();
        getBusListNotifier.value.addAll(buslist_det);
        getBusListNotifier.notifyListeners();
      } else if (busListRespVal.status == 'Failed') {
        log('Data fetch failed');
        final dtwiselist = busListRespVal.busDet;
        getBusListNotifier.value.clear();
        getBusListNotifier.value.addAll(dtwiselist);
        getBusListNotifier.notifyListeners();
      }
    }
  }

  Future fetchBusEditDetails(String regNo) async {
    List<BusDetail>? busDetailslist = [];
    BusEditReq busEditReq = BusEditReq(regNo: regNo);
    final getEditDet = await Busdata().fetchBusEditDetails(busEditReq);
    if (getEditDet == null) {
      busDetailslist = busDetailslist;
      return busDetailslist;
    } else if (getEditDet.statusCode == 200) {
      final resultJson = jsonDecode(getEditDet.toString());
      final Details = BusEditResp.fromJson(resultJson as Map<String, dynamic>);
      if (Details.status == 'success') {
        log('Bus edit  data fetch success');
        final buslistDet = Details.busDetails;
        busDetailslist = buslistDet;
        return busDetailslist;
      } else if (Details.status == 'Failed') {
        log('Bus edit  data fetch failed');
        final buslistDet = Details.busDetails;
        busDetailslist = buslistDet;
        return busDetailslist;
      }
    } else {
      log('Route data fetch exception');
      busDetailslist = busDetailslist;
      return busDetailslist;
    }
    return busDetailslist;
  }
}
