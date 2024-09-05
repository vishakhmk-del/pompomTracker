import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/getRoute/ger_route_resp/route_list.dart';

abstract class Commonfn {
  Future wklycolctfn();
  Future<List<BusRegList>?> busReglistfn();
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

    if (wklyresp == null) {
      log('weeklycollection data fetch null');
      wklycollectionNotifier.value.clear();
      wklycollectionNotifier.value.addAll([]);
      wklycollectionNotifier.notifyListeners();
    } else if (wklyresp.statusCode == 200) {
      final resultAsjson = jsonDecode(wklyresp.toString());
      final wklyrspval =
          Buswklycollction.fromJson(resultAsjson as Map<String, dynamic>);
      if (wklyrspval.status == 'success') {
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
      }
    } else {
      log('weeklycollection data fetch exception');
      wklycollectionNotifier.value.clear();
      wklycollectionNotifier.value.addAll([]);
      wklycollectionNotifier.notifyListeners();
    }
  }

  @override
  Future<List<BusRegList>?> busReglistfn() async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();

    List<BusRegList>? busreglist = [];

    final regrqst = RegistrationReq(
      userId: sharevalue!.userId,
    );
    final regresp = await Busdata().getBusRegistartionList(regrqst);

    if (regresp == null) {
      busreglist = busreglist;
      return busreglist;
    } else if (regresp.statusCode == 200) {
      final resultAsjson = jsonDecode(regresp.toString());
      final regrspval =
          RegistrationResp.fromJson(resultAsjson as Map<String, dynamic>);

      if (regrspval.status == 'success') {
        log('weeklycollection data fetch success');
        final reglist = regrspval.busList;
        busreglist = reglist;
        return busreglist;
      } else if (regrspval.status == 'Failed') {
        log('weeklycollection data fetch failed');
        final reglist = regrspval.busList;
        busreglist = reglist;
        return busreglist;
      }
    } else {
      log('weeklycollection data fetch exception');
      busreglist = busreglist;
      return busreglist;
    }
    return busreglist;
  }

  Future<dynamic> fetchRouteList() async {
    final value = await SharedPrefManager.instance.getSharedData();
    GetRouteReq routeReq =
        GetRouteReq(userId: value!.userId, userType: value.userType);
    final getRouteList = await Busdata().getRouteList(routeReq);

    List<RouteList>? routeDetailslist = [];

    if (getRouteList == null) {
      routeDetailslist = routeDetailslist;
      return routeDetailslist;
    } else if (getRouteList.statusCode == 200) {
      final resultAsjson = jsonDecode(getRouteList.toString());
      final regrspval =
          GerRouteResp.fromJson(resultAsjson as Map<String, dynamic>);

      if (regrspval.status == 'success') {
        log('Route  data fetch success');
        final routeList = regrspval.routeList;
        routeDetailslist = routeList;
        return routeDetailslist;
      } else if (regrspval.status == 'Failed') {
        log('Route data fetch failed');
        final routeList = regrspval.routeList;
        routeDetailslist = routeList;
        return routeDetailslist;
      }
    } else {
      log('Route data fetch exception');
      routeDetailslist = routeDetailslist;
      return routeDetailslist;
    }
    return routeDetailslist;
  }
}
