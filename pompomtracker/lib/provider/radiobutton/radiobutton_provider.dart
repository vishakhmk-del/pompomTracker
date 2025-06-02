import 'package:pompomtracker/core/hook/hook.dart';

class RadiobuttonProvider with ChangeNotifier {
  StatementType _selectedType = StatementType.collectionType;

  StatementType _selectedMode = StatementType.both;

  StatementType _selectedFormat = StatementType.before;

  StatementType _selectedEmployee = StatementType.conductor;

  StatementType get selectedType => _selectedType;
  StatementType get selectedMode => _selectedMode;
  StatementType get selectedFormat => _selectedFormat;
  StatementType get selectedEmployer => _selectedEmployee;

  void changeSelectedType(StatementType type) {
    _selectedType = type;
    notifyListeners();
  }

  void changeSelectedMode(StatementType type) {
    _selectedMode = type;
    notifyListeners();
  }

  void changeSelectedFormat(StatementType type) {
    _selectedFormat = type;
    notifyListeners();
  }

  void changeSelectedEmployee(StatementType type) {
    _selectedEmployee = type;
    notifyListeners();
  }

  void reset() {
    _selectedMode = StatementType.both;
    _selectedType = StatementType.collectionType;
    _selectedFormat = StatementType.before;
    _selectedEmployee = StatementType.conductor;

    notifyListeners();
  }
}
