import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/track/real_bus_det/bus_list.dart';
import 'package:pompomtracker/model/track/real_bus_det/real_bus_det.dart';

class BusTrackFunctions {
  BusTrackFunctions._internal();
  static BusTrackFunctions instance = BusTrackFunctions._internal();
  BusTrackFunctions factory() {
    return instance;
  }

  Future<List<BusDetList>?> realbusdet(
      BusListReq req, BuildContext context) async {
    try {
      final bnkLstresp = await Busdata().realBusDet(req);
      String? message;
      if (bnkLstresp == null) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (bnkLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(bnkLstresp.toString());
        final bnklstVal = RealBusDet.fromJson(
          resultAsJson as Map<String, dynamic>,
        );
        if (bnklstVal.status == 'success') {
          final cpaymob = bnklstVal.busList;
          return cpaymob;
        } else if (bnklstVal.status == 'failed') {
          if (!context.mounted) return [];
          Wklycollectfn.instance.showApierror(
            context,
            "No Bus found",
          );
          return [];
        }
      } else if (message == 'Unauthenticated' || bnkLstresp.statusCode == 401) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (bnkLstresp.statusCode == 500) {
        if (!context.mounted) return [];
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (bnkLstresp.statusCode == 408) {
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
    return null;
  }
}
