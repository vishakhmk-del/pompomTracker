import 'package:pompomtracker/core/hook/hook.dart';

class IconChangeProvider with ChangeNotifier {
  //bool _selectedVal = false;
   Map<String?, bool> _iconStates = {};

  // bool get selectedVal => _selectedVal;
  bool isVerified(String? taskId) {
    return _iconStates[taskId] ?? false; // Default to false if no state exists
  }
  void setVerified(String? taskId, bool value) {
    _iconStates[taskId] = value;
    notifyListeners(); // Notify listeners when state changes
  }
  // void changeSelectedVal(bool value) {
  //   _selectedVal = value;
  //   notifyListeners();
  // }
}
