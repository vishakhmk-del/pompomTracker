import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:pompomtracker/core/hook/hook.dart';

abstract class Commonfn {
  Future wklycolctfn();
  Future<List<BusRegList>?> busReglistfn(BuildContext context);
}

class Wklycollectfn implements Commonfn {
  Wklycollectfn._internal();
  static Wklycollectfn instance = Wklycollectfn._internal();
  Wklycollectfn factory() {
    return instance;
  }

  ValueNotifier<List<Buswklycollectlist>> wklycollectionNotifier =
      ValueNotifier([]);
  Future signout(BuildContext context) async {
    Fluttertoast.showToast(
        msg: "Session Expired.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    final sharedprf = await SharedPreferences.getInstance();

    await sharedprf.remove(savekeyname);
    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const ScreenLogin(),
        ),
        (Route<dynamic> route) => false);
  }

  Future showApierror(BuildContext? context, String? msg) async {
    //print('hi');

    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 15.0);
  }

  @override
  Future wklycolctfn() async {
    final sharevalue = await SharedPrefManager.instance.getSharedData();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);

    final wklyrqst = Weeklycollectionreq.req(
        userId: sharevalue!.userId, curDate: formattedDate);
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
  Future<List<BusRegList>?> busReglistfn(BuildContext context) async {
    try {
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
      } else if (regresp.statusCode == 500) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (regresp.statusCode == 408) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future<dynamic> fetchRouteList(BuildContext context) async {
    try {
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
      } else if (getRouteList.statusCode == 500) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (getRouteList.statusCode == 408) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future<dynamic> conductorList(BuildContext context) async {
    try {
      final value = await SharedPrefManager.instance.getSharedData();
      GetRouteReq routeReq = GetRouteReq(userId: value!.userId, empType: 3);
      final getRouteList = await Busdata().empList(routeReq);

      List<Emplist>? routeDetailslist = [];

      if (getRouteList == null) {
        routeDetailslist = routeDetailslist;
        return routeDetailslist;
      } else if (getRouteList.statusCode == 200) {
        final resultAsjson = jsonDecode(getRouteList.toString());
        final regrspval =
            GerRouteResp.fromJson(resultAsjson as Map<String, dynamic>);

        if (regrspval.status == 'success') {
          log('Route  data fetch success');
          final routeList = regrspval.employeeList;
          routeDetailslist = routeList;
          return routeDetailslist;
        } else if (regrspval.status == 'Failed') {
          log('Route data fetch failed');
          final routeList = regrspval.employeeList;
          routeDetailslist = routeList;
          return routeDetailslist;
        }
      } else if (getRouteList.statusCode == 500) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (getRouteList.statusCode == 408) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future<dynamic> driverList(BuildContext context) async {
    try {
      final value = await SharedPrefManager.instance.getSharedData();
      GetRouteReq routeReq = GetRouteReq(userId: value!.userId, empType: 5);
      final getRouteList = await Busdata().empList(routeReq);

      List<Emplist>? routeDetailslist = [];

      if (getRouteList == null) {
        routeDetailslist = routeDetailslist;
        return routeDetailslist;
      } else if (getRouteList.statusCode == 200) {
        final resultAsjson = jsonDecode(getRouteList.toString());
        final regrspval =
            GerRouteResp.fromJson(resultAsjson as Map<String, dynamic>);

        if (regrspval.status == 'success') {
          log('Route  data fetch success');
          final routeList = regrspval.employeeList;
          routeDetailslist = routeList;
          return routeDetailslist;
        } else if (regrspval.status == 'Failed') {
          log('Route data fetch failed');
          final routeList = regrspval.employeeList;
          routeDetailslist = routeList;
          return routeDetailslist;
        }
      } else if (getRouteList.statusCode == 500) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (getRouteList.statusCode == 408) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }
}
