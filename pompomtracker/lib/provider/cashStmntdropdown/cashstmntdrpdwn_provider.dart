import 'package:pompomtracker/core/hook/hook.dart';

class CashstmntDrpDwnProvider with ChangeNotifier {
  String? _selectedVal = exStatmnt;

  String? get selectedVal => _selectedVal;

  void changeSelectedVal(String? value) {
    _selectedVal = value;
    notifyListeners();
  }
}
