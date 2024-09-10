import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/conductor_master/conductor_list/conductor_ist_resp/conductor_ist_resp.dart';
import 'package:pompomtracker/model/conductor_master/conductor_list/conductor_ist_resp/conductor_list.dart';
import 'package:pompomtracker/model/conductor_master/conductor_list/conductor_list_req/conductor_list_req.dart';

class ConductorListFunctions {
  ConductorListFunctions._internal();
  static ConductorListFunctions instance = ConductorListFunctions._internal();
  ConductorListFunctions factory() {
    return instance;
  }

  ValueNotifier<List<ConductorList>> getConductoristNotifier =
      ValueNotifier([]);
  Future getConductorList() async {
    Response<dynamic>? conductorListRespVar;
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final condutorReq = ConductorListReq(
        userId: sharedValue!.userId, userType: sharedValue.userType);
    conductorListRespVar = await Busdata().fetchConductorList(condutorReq);
    if (conductorListRespVar == null) {
      getConductoristNotifier.value.clear();
      getConductoristNotifier.value.addAll([]);
      getConductoristNotifier.notifyListeners();
    } else if (conductorListRespVar.statusCode == 200) {
      final resultAsJson = jsonDecode(conductorListRespVar.toString());
      final conductorListRespVal =
          ConductorIstResp.fromJson(resultAsJson as Map<String, dynamic>);
      if (conductorListRespVal.status == 'success') {
        final item_det = conductorListRespVal.conductorList;
        if (item_det != null) {
          getConductoristNotifier.value.clear();
          getConductoristNotifier.value.addAll(item_det);
          getConductoristNotifier.notifyListeners();
        }
      } else if (conductorListRespVal.status == 'Failed') {
        final item_det = conductorListRespVal.conductorList;
        if (item_det != null) {
          getConductoristNotifier.value.clear();
          getConductoristNotifier.value.addAll(item_det);
          getConductoristNotifier.notifyListeners();
        }
      } else {}
    }
  }
}
