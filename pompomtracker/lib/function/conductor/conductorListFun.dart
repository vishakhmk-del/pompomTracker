import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/conductor_master/conductor_edit/conductor_edit_req/conductor_edit_re.dart';
import 'package:pompomtracker/model/conductor_master/conductor_edit/conductor_edit_resp/conductor_detail.dart';
import 'package:pompomtracker/model/conductor_master/conductor_edit/conductor_edit_resp/conductor_edit_resp.dart';

class ConductorListFunctions {
  ConductorListFunctions._internal();
  static ConductorListFunctions instance = ConductorListFunctions._internal();
  ConductorListFunctions factory() {
    return instance;
  }

  ValueNotifier<List<Listdet>> getConductoristNotifier = ValueNotifier([]);

  Future getConductorList() async {
    // print('nnn');
    Response<dynamic>? conductorListRespVar;
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final condutorReq = MasterListReq(
        userId: sharedValue!.userId, userType: sharedValue.userType);
    conductorListRespVar = await Busdata().fetchConductorList(condutorReq);
    if (conductorListRespVar == null) {
//print('null');
      getConductoristNotifier.value.clear();
      getConductoristNotifier.value.addAll([]);
      getConductoristNotifier.notifyListeners();
    } else if (conductorListRespVar.statusCode == 200) {
      final resultAsJson = jsonDecode(conductorListRespVar.toString());
      final conductorListRespVal =
          MasterListMdl.fromJson(resultAsJson as Map<String, dynamic>);
      if (conductorListRespVal.status == 'success') {
        //print('sucess');
        final item_det = conductorListRespVal.listDet;
        //print(item_det.);
        getConductoristNotifier.value.clear();
        getConductoristNotifier.value.addAll(item_det);
        getConductoristNotifier.notifyListeners();
      } else if (conductorListRespVal.status == 'Failed') {
        final item_det = conductorListRespVal.listDet;
        getConductoristNotifier.value.clear();
        getConductoristNotifier.value.addAll(item_det);
        getConductoristNotifier.notifyListeners();
      }
    }
  }

  Future fetchCondcutorEditDetails(String conductorId) async {
    List<ConductorDetail>? conDetailslist = [];
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    ConductorEditRe conEditReq = ConductorEditRe(
        conductorId: conductorId,
        userId: sharedValue!.userId,
        userType: sharedValue.userType);
    final getEditDet = await Busdata().fetchConEditDetails(conEditReq);
    if (getEditDet == null) {
      conDetailslist = conDetailslist;
      return conDetailslist;
    } else if (getEditDet.statusCode == 200) {
      final resultJson = jsonDecode(getEditDet.toString());
      final Details =
          ConductorEditResp.fromJson(resultJson as Map<String, dynamic>);
      if (Details.status == 'success') {
        log('Bus edit  data fetch success');
        final conlistDet = Details.conductorDetails;
        conDetailslist = conlistDet;
        return conDetailslist;
      } else if (Details.status == 'Failed') {
        log('Bus edit  data fetch failed');
        final conlistDet = Details.conductorDetails;
        conDetailslist = conlistDet;
        return conDetailslist;
      }
    } else {
      log('Route data fetch exception');
      conDetailslist = conDetailslist;
      return conDetailslist;
    }
    return conDetailslist;
  }
}
