import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/main.dart';
import 'package:pompomtracker/model/sharedpref/sharedpref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static const _key = 'Login';

  Future<void> addSharedData(Sharedpref value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLogedIn, true);
    final List<String> login = prefs.getStringList(_key) ?? [];
    login.add(json.encode(value.toJson()));
    //final jsonString = json.encode(value.toJson());
    await prefs.setStringList(_key, login);
  }

  Future<List<Sharedpref>> getSharedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> login = prefs.getStringList(_key) ?? [];
    return login.map((loginJson) {
      //   final logindata = json.decode(loginjson);
      final Map<String, dynamic> logindata =
          json.decode(loginJson) as Map<String, dynamic>;
      return Sharedpref.fromJson(logindata);
      //status, userId, userType, userName, ownerName
    }).toList();
  }
}
