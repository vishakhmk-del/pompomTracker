import 'package:pompomtracker/core/hook/hook.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
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
                colors: [Colors.orange.shade100, Colors.orange])),
        child: Center(
          child: Lottie.asset(
            'assets/animatedsplash/Animation - bus.json',
            width: MediaQuery.of(context).size.width / 2,
            //height: MediaQuery.of(context).size.height/2
          ),
        ),
      ),
    );
  }
}
