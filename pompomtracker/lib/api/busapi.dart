import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/model/employee/employee_req/employee_req.dart';
import 'package:pompomtracker/model/forget/frgtreq/frgtreq.dart';

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
  Future<Response<dynamic>?> driverMasterSave(MasterListReq value);

  Future<Response<dynamic>?> fetchBusList(BusListReq value);
  Future<Response<dynamic>?> fetchBusEditDetails(BusEditReq value);
  Future<Response<dynamic>?> updateBus(BusMasterReq value);

  Future<Response<dynamic>?> getTripdet(MasterListReq value);

  Future<Response<dynamic>?> getStopdet(MasterListReq value);

  Future<Response<dynamic>?> fetchConductorList(MasterListReq value);
  Future<Response<dynamic>?> conductorList(GetRouteReq value);
  Future<Response<dynamic>?> driverList(GetRouteReq value);

  Future<Response<dynamic>?> fetchdriverView(MasterListReq value);

  Future<Response<dynamic>?> fetchConEditDetails(ConductorEditRe value);
  Future<Response<dynamic>?> fetchdriverEditDetails(ConductorEditRe value);

  Future<Response<dynamic>?> updateConductortDetails(MasterListReq value);
  Future<Response<dynamic>?> updatedriverDetails(MasterListReq value);

  Future<Response<dynamic>?> fetchBusRouteList(MasterListReq value);

  Future<Response<dynamic>?> fetchAssignDetailsList(MasterListReq value);

  Future<Response<dynamic>?> updateBusRouteList(BusRouteLinkReq value);

  Future<Response<dynamic>?> fetchTripList(MasterListReq value);
  Future<Response<dynamic>?> fetchTripEdit(MasterListReq value);
  Future<Response<dynamic>?> tripMasterUpdate(TripMasterReq value);

  Future<Response<dynamic>?> stopNameChang(MasterListReq value);
  Future<Response<dynamic>?> deleteStop(MasterListReq value);
  Future<Response<dynamic>?> getStopname(MasterListReq value);
  Future<Response<dynamic>?> addNewStop(MasterListReq value);

  Future<Response<dynamic>?> linkConductorBus(MasterListReq value);

  Future<Response<dynamic>?> sortedRoute(MasterListReq value);
  Future<Response<dynamic>?> fromToStaton(MasterListReq value);
  Future<Response<dynamic>?> exstingStop(MasterListReq value);
  Future<Response<dynamic>?> editArvTime(MasterListReq value);
  Future<Response<dynamic>?> getNewTripdet(MasterListReq value);
  Future<Response<dynamic>?> frgtPswrd(Frgtreq value);
  Future<Response<dynamic>?> deviceinfo(Deviceinfo value);

  Future<Response<dynamic>?> employeeAssgn(EmployeeReq value);
  Future<Response<dynamic>?> empStatus(MasterListReq value);
  Future<Response<dynamic>?> empUpdtStatus(MasterListReq value);



  
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      if (ex.type == DioExceptionType.connectionTimeout) {
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408,
          statusMessage: "Connection Timeout",
        );
      }
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }
      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ?? 500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> driverMasterSave(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.driverSaveUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> conductorList(GetRouteReq value) async {
    try {
      final result = await dio.post(
        url.conductorLstUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> driverList(GetRouteReq value) async {
    try {
      final result = await dio.post(
        url.driverLstUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> fetchAssignDetailsList(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.busDetailsUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408,
          statusMessage: "Connection Timeout",
        );
      }
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ?? 500,
        statusMessage: ex.message,
        data: ex.response?.data,
      );
    }
  }

  @override
  Future<Response?> fetchdriverView(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.driverViewUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> getTripdet(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.getTripdetUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> fetchdriverEditDetails(ConductorEditRe value) async {
    try {
      final result = await dio.post(
        url.fetcheditDriverDetailsUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> getStopdet(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.getStopUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> updatedriverDetails(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.updateDriverUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> stopNameChang(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.stopNameChangeUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> deleteStop(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.deleteStopUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> getStopname(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.getStopNameUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> addNewStop(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.addNewStopUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> fetchTripList(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.fetchTripList,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> fetchTripEdit(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.fetchTripEdit,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> tripMasterUpdate(TripMasterReq value) async {
    try {
      final result = await dio.post(
        url.tripUpdate,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> linkConductorBus(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.linkConductorBus,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> sortedRoute(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.sortRouteUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> fromToStaton(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.fromtoStnUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> exstingStop(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.existingStpUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> editArvTime(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.editArrivingTmUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> getNewTripdet(MasterListReq value) async {
    try {
      final result = await dio.post(
        url.getnewTripUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> frgtPswrd(Frgtreq value) async {
    try {
      final result = await dio.post(
        url.frgetPswrdUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<Response?> deviceinfo(Deviceinfo value) async {
    try {
      final result = await dio.post(
        url.deviceInfoUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
  
  @override
  Future<Response?> employeeAssgn(EmployeeReq value)async {
   try {
      final result = await dio.post(
        url.employeeAsgnUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
  
  @override
  Future<Response?> empStatus(MasterListReq value) async{
   try {
      final result = await dio.post(
        url.empStatusUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
  
  @override
  Future<Response?> empUpdtStatus(MasterListReq value) async{
    try {
      final result = await dio.post(
        url.empUpdtStatusUrl,
        data: value.toJson(),
      );
      return result;
    } on DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
}
