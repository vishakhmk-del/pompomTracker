import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/main.dart';
import 'package:pompomtracker/model/sharedpref/sharedpref.dart';
import 'package:pompomtracker/provider/shared_preference/shared_preference_manage.dart';
import 'package:pompomtracker/screens/Bus/ScreenBusMaster.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLogin();
    // gotoLogin();
    super.initState();
  }

  Future<void> checkUserLogin() async {
    final sharedpref = await SharedPreferences.getInstance();
    final useLoggedin = sharedpref.getBool(userLogedIn);
    if (useLoggedin == null && useLoggedin == false) {
      gotoLogin();
    } else {
      final getLoginData = await SharedPrefManager().getSharedData();
      // print(getLoginData);

      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(_scaffoldKey.currentContext!).push(
        MaterialPageRoute(
          builder: (context) => const ScreenBusMater(),
        ),
      );
    }
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        _scaffoldKey.currentContext!, Approutes().loginscreen);
    //  Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) =>const Screenhome(),
    //   ),
    // );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ])),
        child: Center(
          child: Lottie.asset(
            'assets/animatedsplash/Animation - bus.json',
            width: MediaQuery.of(context).size.width / 2.5,
            //height: MediaQuery.of(context).size.height/2
          ),
        ),
      ),
    );
  }
}
