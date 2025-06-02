import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';


class ConductorListFunctions {
  ConductorListFunctions._internal();
  static ConductorListFunctions instance = ConductorListFunctions._internal();
  ConductorListFunctions factory() {
    return instance;
  }

  ValueNotifier<List<Listdet>> getConductoristNotifier = ValueNotifier([]);
  ValueNotifier<List<Listdet>> getDriveristNotifier = ValueNotifier([]);
  ValueNotifier<List<TripDetail>> getAssignDetailsNotifier = ValueNotifier([]);

  Future getConductorList(BuildContext context) async {
    try {
      Response<dynamic>? conductorListRespVar;
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      final condutorReq = MasterListReq(
          userId: sharedValue!.userId, usertype: sharedValue.userType);
      conductorListRespVar = await Busdata().fetchConductorList(condutorReq);
      if (conductorListRespVar == null) {
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
        } else if (conductorListRespVar.statusCode == 401) {
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, "Unauthenticated");
        } else if (conductorListRespVar.statusCode == 500) {
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, "Sever Not reached");
          // showLoginerror(context, 3);
        } else if (conductorListRespVar.statusCode == 408) {
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, "Connection time out");

          //showLoginerror(context, 4);
        } else {
          if (!context.mounted) return;

          Wklycollectfn.instance.showApierror(context, "Something went wrong");
          //showLoginerror(context, 5);
        }
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future getDriverList(BuildContext context) async {
    // print('nnn');
    try {
      Response<dynamic>? conductorListRespVar;
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      final condutorReq = MasterListReq(
          userId: sharedValue!.userId, usertype: sharedValue.userType);
      conductorListRespVar = await Busdata().fetchdriverView(condutorReq);
      if (conductorListRespVar == null) {
//print('null');
        getDriveristNotifier.value.clear();
        getDriveristNotifier.value.addAll([]);
        getDriveristNotifier.notifyListeners();
      } else if (conductorListRespVar.statusCode == 200) {
        final resultAsJson = jsonDecode(conductorListRespVar.toString());
        final conductorListRespVal =
            MasterListMdl.fromJson(resultAsJson as Map<String, dynamic>);
        if (conductorListRespVal.status == 'success') {
          //print('sucess');
          final item_det = conductorListRespVal.listDet;
          //print(item_det.);
          getDriveristNotifier.value.clear();
          getDriveristNotifier.value.addAll(item_det);
          getDriveristNotifier.notifyListeners();
        } else if (conductorListRespVal.status == 'Failed') {
          final item_det = conductorListRespVal.listDet;
          getDriveristNotifier.value.clear();
          getDriveristNotifier.value.addAll(item_det);
          getDriveristNotifier.notifyListeners();
        } else if (conductorListRespVar.statusCode == 401) {
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, "Unauthenticated");
        } else if (conductorListRespVar.statusCode == 500) {
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, "Sever Not reached");
          // showLoginerror(context, 3);
        } else if (conductorListRespVar.statusCode == 408) {
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, "Connection time out");

          //showLoginerror(context, 4);
        } else {
          if (!context.mounted) return;

          Wklycollectfn.instance.showApierror(context, "Something went wrong");
          //showLoginerror(context, 5);
        }
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future fetchCondcutorEditDetails(
      String conductorId, int flag, BuildContext context) async {
    try {
      List<ConductorDetail>? conDetailslist = [];
      Response<dynamic>? getEditDet;
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      if (flag == 1) {
        ConductorEditRe conEditReq = ConductorEditRe(
            conductorId: conductorId,
            userId: sharedValue!.userId,
            userType: sharedValue.userType);
        getEditDet = await Busdata().fetchConEditDetails(conEditReq);
      } else if (flag == 2) {
        ConductorEditRe conEditReq = ConductorEditRe(
            driverId: conductorId,
            userId: sharedValue!.userId,
            userType: sharedValue.userType);
        getEditDet = await Busdata().fetchdriverEditDetails(conEditReq);
      }

      if (getEditDet == null) {
        conDetailslist = conDetailslist;
        return conDetailslist;
      } else if (getEditDet.statusCode == 200) {
        final resultJson = jsonDecode(getEditDet.toString());
        final details =
            ConductorEditResp.fromJson(resultJson as Map<String, dynamic>);
        if (details.status == 'success') {
          log('Conductor edit  data fetch success');
          final conlistDet = details.conductorDetails;
          conDetailslist = conlistDet;
          return conDetailslist;
        } else if (details.status == 'Failed') {
          log('Bus edit  data fetch failed');
          final conlistDet = details.conductorDetails;
          conDetailslist = conlistDet;
          return conDetailslist;
        }
      } else if (getEditDet.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (getEditDet.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (getEditDet.statusCode == 408) {
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
  }

  Future getAssignDetailsList(BuildContext context) async {
    try {
      Response<dynamic>? conductorListRespVar;
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      final condutorReq = MasterListReq(
          ownerId: sharedValue!.userId, usertype: sharedValue.userType);
      conductorListRespVar =
          await Busdata().fetchAssignDetailsList(condutorReq);
      if (conductorListRespVar == null) {
        getAssignDetailsNotifier.value.clear();
        getAssignDetailsNotifier.value.addAll([]);
        getAssignDetailsNotifier.notifyListeners();
      } else if (conductorListRespVar.statusCode == 200) {
        final resultAsJson = jsonDecode(conductorListRespVar.toString());
        final conductorListRespVal =
            EmployeeAssign.fromJson(resultAsJson as Map<String, dynamic>);
        if (conductorListRespVal.status == 'success') {
          //print('sucess');
          final itemDet = conductorListRespVal.tripDetails;
          //print(item_det.);
          getAssignDetailsNotifier.value.clear();
          getAssignDetailsNotifier.value.addAll(itemDet!);
          getAssignDetailsNotifier.notifyListeners();
        } else if (conductorListRespVal.status == 'Failed') {
          final itemDet = conductorListRespVal.tripDetails;
          getAssignDetailsNotifier.value.clear();
          getAssignDetailsNotifier.value.addAll(itemDet!);
          getAssignDetailsNotifier.notifyListeners();
        } else if (conductorListRespVar.statusCode == 401) {
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, "Unauthenticated");
        } else if (conductorListRespVar.statusCode == 500) {
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, "Sever Not reached");
          // showLoginerror(context, 3);
        } else if (conductorListRespVar.statusCode == 408) {
          if (!context.mounted) return;
          Wklycollectfn.instance.showApierror(context, "Connection time out");

          //showLoginerror(context, 4);
        } else {
          if (!context.mounted) return;

          Wklycollectfn.instance.showApierror(context, "Something went wrong");
          //showLoginerror(context, 5);
        }
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future employeeAssign(EmployeeReq val, BuildContext context) async {
    try {
      final  getEditDet = await Busdata().employeeAssgn(val);
      if (getEditDet == null) {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (getEditDet.statusCode == 200) {
        final resultJson = jsonDecode(getEditDet.toString());
        final details =
            ConductorEditResp.fromJson(resultJson as Map<String, dynamic>);
        if (details.status == 'success') {
          if (!context.mounted) return;

          Navigator.pushReplacement(context, Approutes().employeeAssign);
          
        Wklycollectfn.instance.showApierror(context, "Assigned Successfully");
        } else if (details.status == 'failure') {
          if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Can't be Assigned");
        }
      } else if (getEditDet.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (getEditDet.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (getEditDet.statusCode == 408) {
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
  }

   Future employeeStatus(MasterListReq val,BuildContext context) async {
    try {
      final  getEditDet = await Busdata().empStatus(val);
      if (getEditDet == null) {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (getEditDet.statusCode == 200) {
        final resultJson = jsonDecode(getEditDet.toString());
        final details =
            ConductorEditResp.fromJson(resultJson as Map<String, dynamic>);
        if (details.status == 'success') {
          if (!context.mounted) return;
          selectedEmployerNotifier.value = StatementType.conductor;

          Navigator.pushReplacement(context, Approutes().conductoscreen);
          
        Wklycollectfn.instance.showApierror(context, "Saved Successfully");
        } else if (details.status == 'failed') {
          if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Can't be Saved");
        Navigator.pop(context);
        }
      } else if (getEditDet.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (getEditDet.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (getEditDet.statusCode == 408) {
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
  }

  Future employeeUpdateStatus(MasterListReq val,int? flag,BuildContext context) async {
    try {
      final  getEditDet = await Busdata().empUpdtStatus(val);
      if (getEditDet == null) {
        if (!context.mounted) return;

        Wklycollectfn.instance.showApierror(context, "Something went wrong");
      } else if (getEditDet.statusCode == 200) {
        final resultJson = jsonDecode(getEditDet.toString());
        final details =
            ConductorEditResp.fromJson(resultJson as Map<String, dynamic>);
        if (details.status == 'success') {
          if (!context.mounted) return;
          if (flag == 1) {
            Navigator.pushReplacement(context, Approutes().conductorListScreen);
          } else if (flag == 2) {
            Navigator.pushReplacement(context, Approutes().screenDriverView);
          }
          
        Wklycollectfn.instance.showApierror(context, "Saved Successfully");
        } else if (details.status == 'failed') {
          if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Can't be Saved");
        Navigator.pop(context);
        }
      } else if (getEditDet.statusCode == 401) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Unauthenticated");
      } else if (getEditDet.statusCode == 500) {
        if (!context.mounted) return;
        Wklycollectfn.instance.showApierror(context, "Sever Not reached");
        // showLoginerror(context, 3);
      } else if (getEditDet.statusCode == 408) {
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
  }
}
