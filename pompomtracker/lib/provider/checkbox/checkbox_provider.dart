import 'package:pompomtracker/core/hook/hook.dart';

class CheckProvider extends ChangeNotifier {
  bool? _isAccepted = false;
  bool? get isAccepted => _isAccepted;
  
  bool _isNeeded = false;
  bool get isNeeded => _isNeeded;

  int? _notificationDays;
  int? get notificationDays => _notificationDays;

  void setAccepted(bool? value) {
    _isAccepted = value;
    notifyListeners();
  }

  void setNeeded(bool value) {
    _isNeeded = value;
    if (!value) {
      _notificationDays = null;
    }
    notifyListeners();
  }

void setNotificationDays(int? value) {
    _notificationDays = value;
    notifyListeners();
  }

  void reset() {
    _isAccepted = false;
    _isNeeded = false;
    _notificationDays = null;

    notifyListeners();
  }
}
