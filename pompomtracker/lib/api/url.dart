class Url {
  // String baseUrl = 'http://10.160.100.53/Qrpay/index.php';

  String baseUrl = 'http://117.221.68.183:81/Qrpay/index.php';

  String loginUrl = '/Home_C/owner_login';

  String getBusUrl = '/Master_C/get_bustype';
  String busSave = '/Master_C/bus_save';
  String routeSave = '/Master_C/route_save';
  String getBusList = '/Master_C/get_buslist';
  String getRoute = '/Master_C/get_route_name';
  String tripSave = '/Owner_C/save_trip';
  String weeklyUrl = '/Owner_C/rep_datewise';
  String dateWiseUrl = '/Master_C/get_datewise';
  String busWiseUrl = '/Master_C/get_buswise';
  String getCashstmntUrl = '/Master_C/get_cash_statement';
  String getExpenseUrl = '/Master_C/expense_report';
  String stopSave = '/Owner_C/save_stop';
  String linkBusRouteSave = '/Master_C/bus_route_link';
  String conductorSave = '/Master_C/conductor_save';

  String fetchBusList = '/Owner_C/bus_view';
  String fetchBusEditList = '/Owner_C/bus_details';
  String updateBus = '/Owner_C/update_bus';
  String fetchCondutorList = '/Owner_C/conductor_view';

  String getTripdetUrl = '/RouteMaster_C/get_trip_name_list';

  String getStopUrl = '/Master_C/get_stop_details';

  String fetchCondutorEditList = '/Owner_C/conductor_details';
  String updateCon = '/Owner_C/update_conductor';
  String fetchBusRouteList = '/Owner_C/bus_route_view';
  String updateBusRouteList = '/Master_C/bus_route_link_update';

  String fetchTripList = '/Owner_C/trip_view';
  String fetchTripEdit = '/Master_C/get_routeTripEdit';
  String tripUpdate = '/Owner_C/update_trip';

  String stopNameChangeUrl = '/RouteMaster_C/get_stop_name_update';
  String deleteStopUrl = '/RouteMaster_C/get_stop_delete';
  String getStopNameUrl = '/RouteMaster_C/get_stop_name';
  String addNewStopUrl = '/RouteMaster_C/get_stop_adding';

  String linkConductorBus = '/Master_C/conductor_bus_link';

  String sortRouteUrl = '/Master_C/get_linked_route';
  String fromtoStnUrl = '/Master_C/get_existing_tripname';
  String existingStpUrl = '/Owner_C/get_existing_stop';
  String editArrivingTmUrl = '/Owner_C/add_existing_stop';
  String getnewTripUrl = '/Owner_C/get_new_trip';

}
