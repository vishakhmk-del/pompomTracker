import 'package:pompomtracker/core/hook/hook.dart';

class DropdownProvider with ChangeNotifier {
  bool? _selectedVal;
  int? _selectnum;

  bool? get selectedVal => _selectedVal;
  int? get selectedNum => _selectnum;


  void changeSelectedVal(bool? value,int? val) {
    _selectedVal = value;
    _selectnum=val;
    notifyListeners();
  }
}
