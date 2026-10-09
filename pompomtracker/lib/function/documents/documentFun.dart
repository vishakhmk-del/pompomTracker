

import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/bus_master/bus_list_resp/document_list.dart';

class DocumentsFun {
  DocumentsFun._internal();
  static DocumentsFun instance = DocumentsFun._internal();
  DocumentsFun factory() {
    return instance;
  }

  ValueNotifier<List<DocumentList>> getDocListNotifier = ValueNotifier([]);

  Future documentSave(BusMasterReq req, BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    try {
      final bnkLstresp = await Busdata().documentSave(req);
      loadingProvider.reset();

      String? message;
      if (bnkLstresp == null) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (bnkLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(bnkLstresp.toString());
        final bnklstVal = BusMasterResp.fromJson(
          resultAsJson as Map<String, dynamic>,
        );
        if (bnklstVal.status == 'success') {
          if (!context.mounted) return;

          Navigator.pushReplacement(context, Approutes().docListScreen);

          Wklycollectfn.instance.showApierror(
            context,
            bnklstVal.message,
          );
        } else if (bnklstVal.status == 'failed') {
          if (!context.mounted) return;

          Wklycollectfn.instance.showApierror(
            context,
            bnklstVal.message,
          );
        }
      } else if (message == 'Unauthenticated' || bnkLstresp.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (bnkLstresp.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (bnkLstresp.statusCode == 408) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }

  Future getDocList(BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    try {
      final value =await SharedPrefManager.instance.getSharedData();
      final docreq=BusListReq(userId: value!.userId,userType: value.userType);
      final bnkLstresp = await Busdata().fetchDocList(docreq);
      loadingProvider.reset();

      String? message;
      if (bnkLstresp == null) {
        getDocListNotifier.value.clear();
        getDocListNotifier.value.addAll([]);
        getDocListNotifier.notifyListeners();
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (bnkLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(bnkLstresp.toString());
        final doclstVal = BusListResp.fromJson(
          resultAsJson as Map<String, dynamic>,
        );
        if (doclstVal.status == 'success') {
          final doclistDet = doclstVal.docDet;
          getDocListNotifier.value.clear();
          getDocListNotifier.value.addAll(doclistDet);
          getDocListNotifier.notifyListeners();
          if (!context.mounted) return;

          // Wklycollectfn.instance.showApierror(
          //   context,
          //   doclstVal.message,
          // );
        } else if (doclstVal.status == 'failed') {
          final doclistDet = doclstVal.docDet;

          if (!context.mounted) return;

          Wklycollectfn.instance.showApierror(
            context,
            doclstVal.message,
          );
          getDocListNotifier.value.clear();
          getDocListNotifier.value.addAll(doclistDet);
          getDocListNotifier.notifyListeners();
        }
      } else if (message == 'Unauthenticated' || bnkLstresp.statusCode == 401) {
        getDocListNotifier.value.clear();
        getDocListNotifier.value.addAll([]);
        getDocListNotifier.notifyListeners();
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (bnkLstresp.statusCode == 500) {
        getDocListNotifier.value.clear();
        getDocListNotifier.value.addAll([]);
        getDocListNotifier.notifyListeners();
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (bnkLstresp.statusCode == 408) {
        getDocListNotifier.value.clear();
        getDocListNotifier.value.addAll([]);
        getDocListNotifier.notifyListeners();
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        getDocListNotifier.value.clear();
        getDocListNotifier.value.addAll([]);
        getDocListNotifier.notifyListeners();
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      getDocListNotifier.value.clear();
      getDocListNotifier.value.addAll([]);
      getDocListNotifier.notifyListeners();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }

Future documentUpdate(BusMasterReq req, BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    try {
      final bnkLstresp = await Busdata().documentUpdate(req);
      loadingProvider.reset();

      String? message;
      if (bnkLstresp == null) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (bnkLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(bnkLstresp.toString());
        final bnklstVal = BusMasterResp.fromJson(
          resultAsJson as Map<String, dynamic>,
        );
        if (bnklstVal.status == 'success') {
          if (!context.mounted) return;

          Navigator.pushReplacement(context, Approutes().docListScreen);

          Wklycollectfn.instance.showApierror(
            context,
            bnklstVal.message,
          );
        } else if (bnklstVal.status == 'failed') {
          if (!context.mounted) return;

          Wklycollectfn.instance.showApierror(
            context,
            bnklstVal.message,
          );
        }
      } else if (message == 'Unauthenticated' || bnkLstresp.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (bnkLstresp.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (bnkLstresp.statusCode == 408) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }

  Future documentDelete(BusMasterReq req, BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    try {
      final bnkLstresp = await Busdata().documentDlt(req);
      loadingProvider.reset();

      String? message;
      if (bnkLstresp == null) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (bnkLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(bnkLstresp.toString());
        final bnklstVal = BusMasterResp.fromJson(
          resultAsJson as Map<String, dynamic>,
        );
        if (bnklstVal.status == 'success') {
          if (!context.mounted) return;

          Navigator.pushReplacement(context, Approutes().docListScreen);

          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(
            context,
            bnklstVal.message,
          );
        } else if (bnklstVal.status == 'failed') {
          if (!context.mounted) return;

          Wklycollectfn.instance.showApierror(
            context,
            bnklstVal.message,
          );
        }
      } else if (message == 'Unauthenticated' || bnkLstresp.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (bnkLstresp.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (bnkLstresp.statusCode == 408) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }

  Future<int> documentNotification(BusMasterReq req, BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    try {
      final bnkLstresp = await Busdata().documentNotification(req);
      loadingProvider.reset();

      String? message;
      if (bnkLstresp == null) {
        if (!context.mounted) return 0;
        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (bnkLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(bnkLstresp.toString());
        final bnklstVal = BusMasterResp.fromJson(
          resultAsJson as Map<String, dynamic>,
        );
        if (bnklstVal.status == 'success') {
          if (!context.mounted) return 0;

          // Wklycollectfn.instance.showApierror(
          //   context,
          //   bnklstVal.message,
          // );
          return bnklstVal.expiryCount ?? 0;
        } else if (bnklstVal.status == 'failed') {
          if (!context.mounted) return 0;

          Wklycollectfn.instance.showApierror(
            context,
            bnklstVal.message,
          );
        }
      } else if (message == 'Unauthenticated' || bnkLstresp.statusCode == 401) {
        if (!context.mounted) return 0;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (bnkLstresp.statusCode == 500) {
        if (!context.mounted) return 0;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (bnkLstresp.statusCode == 408) {
        if (!context.mounted) return 0;
        Wklycollectfn.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return 0;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return 0;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return 0;
  }
}
