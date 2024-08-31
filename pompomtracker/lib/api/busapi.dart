import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/Registration_List/registration_req/registration_req.dart';
import 'package:pompomtracker/model/Trip_master/trip_master_req/trip_master_req.dart';
import 'package:pompomtracker/model/bus_master/bus_master_req/bus_master_req.dart';
import 'package:pompomtracker/model/getRoute/get_route_req/get_route_req.dart';
import 'package:pompomtracker/model/route_master/route_master_req/route_master_req.dart';

abstract class Apicalls {
  Future<Response<dynamic>?> login(Loginreq value);
  Future<Response<dynamic>?> weeklycollection(Weeklycollectionreq value);
  Future<Response<dynamic>?> getBusList();
  Future<Response<dynamic>?> busMasterSave(BusMasterReq value);
  Future<Response<dynamic>?> routeMasterSave(RouteMasterReq value);
  Future<Response<dynamic>?> getBusRegistartionList(RegistrationReq value);
  Future<Response<dynamic>?> getRouteList(GetRouteReq value);
  Future<Response<dynamic>?> tripMasterSave(TripMasterReq value);
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
}
