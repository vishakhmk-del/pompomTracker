import 'package:pompomtracker/core/hook/hook.dart';

class CollectionDrpDwnProvider with ChangeNotifier {
  String? _selectedVal = dailyCollectn;

  String? get selectedVal => _selectedVal;

  void changeSelectedVal(String? value) {
    _selectedVal = value;
    notifyListeners();
  }
}
