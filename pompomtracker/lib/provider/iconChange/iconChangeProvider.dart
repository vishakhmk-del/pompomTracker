import 'package:pompomtracker/core/hook/hook.dart';

class IconChangeProvider with ChangeNotifier {
  Map<String?, bool> _iconStates = {};

  bool isVerified(String? taskId) {
    return _iconStates[taskId] ?? false; // Default to false if no state exists
  }

  void setVerified(String? taskId, bool value) {
    _iconStates[taskId] = value;
    notifyListeners(); // Notify listeners when state changes
  }

  void clearAll() {
    _iconStates.clear();
    notifyListeners(); // Notify listeners after clearing
  }
}

