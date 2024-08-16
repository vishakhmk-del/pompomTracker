import 'package:pompomtracker/core/hook/hook.dart';

class LoadingProvider with ChangeNotifier {
  bool isloading = false;
  bool get isLoading => isloading;

  void toggleLoading() {
    isloading = !isloading;
    notifyListeners();
  }
}