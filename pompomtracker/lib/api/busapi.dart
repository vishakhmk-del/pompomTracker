import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/bus_master/bus_edit/bus_edit_req/bus_edit_req.dart';
import 'package:pompomtracker/model/bus_master/bus_list_req/bus_list_req.dart';
import 'package:pompomtracker/model/conductor_master/conductor_list/conductor_ist_resp/conductor_ist_resp.dart';
import 'package:pompomtracker/model/conductor_master/conductor_list/conductor_list_req/conductor_list_req.dart';
import 'package:pompomtracker/model/conductor_master/conductor_req/conductor_req.dart';

abstract class Apicalls {
  Future<Response<dynamic>?> login(Loginreq value);
  Future<Response<dynamic>?> weeklycollection(Weeklycollectionreq value);
  Future<Response<dynamic>?> getBusList();
  Future<Response<dynamic>?> busMasterSave(BusMasterReq value);
  Future<Response<dynamic>?> routeMasterSave(RouteMasterReq value);
  Future<Response<dynamic>?> getBusRegistartionList(RegistrationReq value);
  Future<Response<dynamic>?> getRouteList(GetRouteReq value);

  Future<Response<dynamic>?> tripMasterSave(TripMasterReq value);

  Future<Response<dynamic>?> getDatewiseStmnt(Datewisereq value);
  Future<Response<dynamic>?> getBuswiseStmnt(Datewisereq value);

  Future<Response<dynamic>?> getCashStmnt(Datewisereq value);
  Future<Response<dynamic>?> getExpenseStmnt(Datewisereq value);

  Future<Response<dynamic>?> stopMasterSave(StopMasterReq value);
  Future<Response<dynamic>?> busRouteLinkMasterSave(BusRouteLinkReq value);
  Future<Response<dynamic>?> conductorMasterSave(ConductorReq value);

  Future<Response<dynamic>?> fetchBusList(BusListReq value);
  Future<Response<dynamic>?> fetchBusEditDetails(BusEditReq value);
  Future<Response<dynamic>?> updateBus(BusMasterReq value);
  Future<Response<dynamic>?> fetchConductorList(ConductorListReq value);
}

class Busdata extends Apicalls {
  final dio = Dio();
  final url = Url();

  Busdata() {
    //dio.options.headers=Options(headers: {'"Authorization":"Bearer $token"'});
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }
  @override
  Future<Response<dynamic>?> login(Loginreq value) async {
    try {
      final result = await dio.post(
        url.loginUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response<dynamic>?> getBusList() async {
    try {
      final result = await dio.post(
        url.getBusUrl,
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response<dynamic>?> busMasterSave(BusMasterReq value) async {
    try {
      final result = await dio.post(
        url.busSave,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response<dynamic>?> weeklycollection(Weeklycollectionreq value) async {
    try {
      final result = await dio.post(
        url.weeklyUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response<dynamic>?> routeMasterSave(RouteMasterReq value) async {
    try {
      final result = await dio.post(
        url.routeSave,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response<dynamic>?> getBusRegistartionList(
      RegistrationReq value) async {
    try {
      final result = await dio.post(
        url.getBusList,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response<dynamic>?> getRouteList(GetRouteReq value) async {
    try {
      final result = await dio.post(
        url.getRoute,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response<dynamic>?> tripMasterSave(TripMasterReq value) async {
    try {
      final result = await dio.post(
        url.tripSave,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> getDatewiseStmnt(Datewisereq value) async {
    try {
      final result = await dio.post(
        url.dateWiseUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> getBuswiseStmnt(Datewisereq value) async {
    try {
      final result = await dio.post(
        url.busWiseUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> getCashStmnt(Datewisereq value) async {
    try {
      final result = await dio.post(
        url.getCashstmntUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> stopMasterSave(StopMasterReq value) async {
    try {
      final result = await dio.post(
        url.stopSave,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> getExpenseStmnt(Datewisereq value) async {
    try {
      final result = await dio.post(
        url.getExpenseUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> busRouteLinkMasterSave(BusRouteLinkReq value) async {
    try {
      final result = await dio.post(
        url.linkBusRouteSave,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> conductorMasterSave(ConductorReq value) async {
    try {
      final result = await dio.post(
        url.conductorSave,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> fetchBusList(BusListReq value) async {
    try {
      final result = await dio.post(
        url.fetchBusList,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> fetchBusEditDetails(BusEditReq value) async {
    try {
      final result = await dio.post(
        url.fetchBusEditList,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> updateBus(BusMasterReq value) async {
    try {
      final result = await dio.post(
        url.updateBus,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> fetchConductorList(ConductorListReq value) async {
    try {
      final result = await dio.post(
        url.fetchCondutorList,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }
}
