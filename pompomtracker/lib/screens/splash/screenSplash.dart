import 'package:pompomtracker/core/hook/hook.dart';

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
    final useLoggedin = sharedpref.getBool(savekeyname);
    if (useLoggedin == null && useLoggedin == false) {
      gotoLogin();
    } else {
      final value = await SharedPrefManager.instance.getSharedData();

      if (value!.userId != '') {
        await Future.delayed(const Duration(seconds: 3));
        await Wklycollectfn.instance.wklycolctfn();
        Navigator.pushReplacement(
            _scaffoldKey.currentContext!, Approutes().homescreen);
      } else {
        gotoLogin();
      }
    }
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        _scaffoldKey.currentContext!, Approutes().loginscreen);
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
