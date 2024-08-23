import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/weeklycollection/wklycollectnmdltyp2/buswklycollect.dart';
import 'package:pompomtracker/model/weeklycollection/wklycollectnmdltyp2/buswklycollectmdl.dart';

abstract class Commonfn {
  Future wklycolctfn();
}

class Wklycollectfn implements Commonfn {
  Wklycollectfn._internal();
  static Wklycollectfn instance = Wklycollectfn._internal();
  Wklycollectfn factory() {
    return instance;
  }

  ValueNotifier<List<Buswklycollectlist>> wklycollectionNotifier =
      ValueNotifier([]);

  @override
  Future wklycolctfn() async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);

    final wklyrqst = Weeklycollectionreq.req(
        userId: sharevalue!.userId, curDate: '2024-06-29');
    final wklyresp = await Busdata().weeklycollection(wklyrqst);
    final resultAsjson = jsonDecode(wklyresp.toString());
    final wklyrspval =
        Buswklycollction.fromJson(resultAsjson as Map<String, dynamic>);

    if (wklyresp == null) {
      log('weeklycollection data fetch null');
      wklycollectionNotifier.value.clear();
      wklycollectionNotifier.value.addAll([]);
      wklycollectionNotifier.notifyListeners();
    } else if (wklyresp.statusCode == 200 && wklyrspval.status == 'success') {
      log('weeklycollection data fetch success');
      final wklylist = wklyrspval.repDetails;

      wklycollectionNotifier.value.clear();
      wklycollectionNotifier.value.addAll(wklylist);
      wklycollectionNotifier.notifyListeners();
    } else if (wklyrspval.status == 'Failed') {
      log('weeklycollection data fetch failed');
      final wklylist = wklyrspval.repDetails;
      wklycollectionNotifier.value.clear();
      wklycollectionNotifier.value.addAll(wklylist);
      wklycollectionNotifier.notifyListeners();
    } else {
      log('weeklycollection data fetch exception');
      wklycollectionNotifier.value.clear();
      wklycollectionNotifier.value.addAll([]);
      wklycollectionNotifier.notifyListeners();
    }
  }
}
