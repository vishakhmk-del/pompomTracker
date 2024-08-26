import 'package:pompomtracker/core/hook/hook.dart';


class RadiobuttonProvider with ChangeNotifier {
  StatementType _selectedType = StatementType.collectionType;

  StatementType get selectedType => _selectedType;

  void changeSelectedType(StatementType type) {
    _selectedType = type;
    notifyListeners();
  }
}