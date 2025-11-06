
import 'dart:developer';
import 'package:pompomtracker/core/hook/hook.dart';


class SearchFun {
  SearchFun._internal();
  static SearchFun instance = SearchFun._internal();
  SearchFun factory() {
    return instance;
  }

  Future<DataList?> fetchStopLoc(BusListReq req, BuildContext context) async {
    DataList? value;
    try {
      final bnkLstresp = await Busdata().fetchStopLoc(req);
      String? message;
      if (bnkLstresp == null) {
        if (!context.mounted) return value;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (bnkLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(bnkLstresp.toString());
        final bnklstVal = StoplocResp.fromJson(
          resultAsJson as Map<String, dynamic>,
        );
        if (bnklstVal.status == 'success') {
          final cpaymob = bnklstVal.data;
          return cpaymob;
        } else if (bnklstVal.status == 'failed') {
          if (!context.mounted) return value;
          Wklycollectfn.instance.showApierror(
            context,
            "No matches found for Search",
          );
          return value;
        }
      } else if (message == 'Unauthenticated' || bnkLstresp.statusCode == 401) {
        if (!context.mounted) return value;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (bnkLstresp.statusCode == 500) {
        if (!context.mounted) return value;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (bnkLstresp.statusCode == 408) {
        if (!context.mounted) return value;
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return value;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return value;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }

  Future<BusLocation?> fetchLiveBusLoc(
      BusListReq req, BuildContext context) async {
    //Datalive? value;
    BusLocation? busLocation;
    try {
      final bnkLstresp = await Busdata().liveBusLoc(req);
      String? message;
      if (bnkLstresp == null) {
        if (!context.mounted) return busLocation;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (bnkLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(bnkLstresp.toString());
        final bnklstVal = LiveBusresp.fromJson(
          resultAsJson as Map<String, dynamic>,
        );
        if (bnklstVal.status == 'success') {
          final cpaymob = bnklstVal.data?.busLocation;
          return cpaymob;
        } else if (bnklstVal.status == 'failed') {
          log("no live location found");
        }
      } else if (message == 'Unauthenticated' || bnkLstresp.statusCode == 401) {
        if (!context.mounted) return busLocation;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (bnkLstresp.statusCode == 500) {
        if (!context.mounted) return busLocation;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (bnkLstresp.statusCode == 408) {
        if (!context.mounted) return busLocation;
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return busLocation;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return busLocation;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }
}
