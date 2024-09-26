import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/common_models/list_model_req/list_req.dart';
import 'package:pompomtracker/model/common_models/list_model_resp/masterlistMdl.dart';

class StopFunctions {
  StopFunctions._internal();
  static StopFunctions instance = StopFunctions._internal();
  StopFunctions factory() {
    return instance;
  }

  ValueNotifier<List<Listdet>> getDatewiseStmntNotifier = ValueNotifier([]);

  Future tripNameList() async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();

    Response<dynamic>? dtwiseresp;

    final dtwiserqst = MasterListReq(
        userId: sharevalue!.userId,
        usertype: sharevalue.userType,
        );

    if (dtwiseresp == null) {
      log('weeklycollection data fetch null');
      getDatewiseStmntNotifier.value.clear();
      getDatewiseStmntNotifier.value.addAll([]);
      getDatewiseStmntNotifier.notifyListeners();
    } else if (dtwiseresp.statusCode == 200) {
      final resultAsjson = jsonDecode(dtwiseresp.toString());
      final dtwiserspval =
          MasterListMdl.fromJson(resultAsjson as Map<String, dynamic>);
      if (dtwiserspval.status == 'success') {
        log('weeklycollection data fetch success');

        final dtwiselist = dtwiserspval.listDet;

        getDatewiseStmntNotifier.value.clear();
        getDatewiseStmntNotifier.value.addAll(dtwiselist);
        getDatewiseStmntNotifier.notifyListeners();
      } else if (dtwiserspval.status == 'Failed') {
        log('weeklycollection data fetch failed');
        final dtwiselist = dtwiserspval.listDet;
        getDatewiseStmntNotifier.value.clear();
        getDatewiseStmntNotifier.value.addAll(dtwiselist);
        getDatewiseStmntNotifier.notifyListeners();
      }
    } else {
      log('weeklycollection data fetch exception');
      getDatewiseStmntNotifier.value.clear();
      getDatewiseStmntNotifier.value.addAll([]);
      getDatewiseStmntNotifier.notifyListeners();
    }
  }
}
