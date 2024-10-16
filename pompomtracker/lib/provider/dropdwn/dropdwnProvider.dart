import 'package:pompomtracker/core/hook/hook.dart';

class DropdownProvider with ChangeNotifier {
  bool? _selectedVal ;

  bool? get selectedVal => _selectedVal;

  void changeSelectedVal(bool? value) {
    _selectedVal = value;
    notifyListeners();
  }
}