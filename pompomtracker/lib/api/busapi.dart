import 'package:pompomtracker/core/hook/hook.dart';


import 'package:pompomtracker/model/conductor_master/conductor_edit/conductor_edit_req/conductor_edit_re.dart';


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
  Future<Response<dynamic>?> conductorMasterSave(MasterListReq value);

  Future<Response<dynamic>?> fetchBusList(BusListReq value);
  Future<Response<dynamic>?> fetchBusEditDetails(BusEditReq value);
  Future<Response<dynamic>?> updateBus(BusMasterReq value);


  Future<Response<dynamic>?> getTripdet(MasterListReq value);

  Future<Response<dynamic>?> getStopdet(MasterListReq value);

  Future<Response<dynamic>?> fetchConductorList(MasterListReq value);
  Future<Response<dynamic>?> fetchConEditDetails(ConductorEditRe value);
  Future<Response<dynamic>?> updateConductortDetails(MasterListReq value);
  Future<Response<dynamic>?> fetchBusRouteList(MasterListReq value);
  Future<Response<dynamic>?> updateBusRouteList(BusRouteLinkReq value);
  Future<Response<dynamic>?> stopNameChang(MasterListReq value);
  Future<Response<dynamic>?> deleteStop(MasterListReq value);
  Future<Response<dynamic>?> getStopname(MasterListReq value);
  Future<Response<dynamic>?> addNewStop(MasterListReq value);

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
  Future<Response?> conductorMasterSave(MasterListReq value) async {
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
  Future<Response?> fetchConductorList(MasterListReq value) async {
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

  
  @override
  Future<Response?> getTripdet(MasterListReq value) async{
   try {
      final result = await dio.post(
        url.getTripdetUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }


  @override
  Future<Response?> fetchConEditDetails(ConductorEditRe value) async {
    try {
      final result = await dio.post(
        url.fetchCondutorEditList,

        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  
  @override
  Future<Response?> getStopdet(MasterListReq value) async{
   try {
      final result = await dio.post(
        url.getStopUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }


  @override
  Future<Response?> updateConductortDetails(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.updateCon,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> fetchBusRouteList(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.fetchBusRouteList,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<Response?> updateBusRouteList(BusRouteLinkReq value) async {
    try {
      final result = await dio.post(
        url.updateBusRouteList,

        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }
  
  @override
  Future<Response?> stopNameChang(MasterListReq value)async {
    try {
      final result = await dio.post(
        url.stopNameChangeUrl,

        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }
  
  @override
  Future<Response?> deleteStop(MasterListReq value) async{
   try {
      final result = await dio.post(
        url.deleteStopUrl,

        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }
  
  @override
  Future<Response?> getStopname(MasterListReq value) async{
    try {
      final result = await dio.post(
        url.getStopNameUrl,

        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }
  
  @override
  Future<Response?> addNewStop(MasterListReq value) async{
    try {
      final result = await dio.post(
        url.addNewStopUrl,

        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      return ex.response;
    }
  }
}

