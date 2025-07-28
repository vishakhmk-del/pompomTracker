import 'package:pompomtracker/core/hook/hook.dart';

class AssignEmployeeProvider with ChangeNotifier {
  List<TripDetail> assignedEmployees = [];

  Future<void> fetchData(context) async {
    // Fetch the latest data
    assignedEmployees =
        await ConductorListFunctions.instance.getAssignDetailsList(context);
    notifyListeners(); // Notify the UI
  }
}
