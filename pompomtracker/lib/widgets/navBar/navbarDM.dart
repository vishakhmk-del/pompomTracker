import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/screens/main/screenmainPage.dart';

class NavbarDM extends StatefulWidget {
  //final int? category;
  const NavbarDM({super.key});

  @override
  State<NavbarDM> createState() => _NavbarDMState();
}

class _NavbarDMState extends State<NavbarDM> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? username;

  String brname = '';
  bool isVisible = true;

  String? version;

  @override
  void initState() {
    buildversion();
    super.initState();
  }

  void buildversion() async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();

    final value = await SharedPrefManager.instance.getdeviceinfo();
    final devversion = value.appversion;
    final devicever = devversion!.split('+');
    final versionval = devicever[0];

    setState(() {
      version = versionval;
      username = sharedValue?.ownerName ?? '';
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ScreenMainPage(),
      ),
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          if (didPop) return;
          await popscreen(context);
        }
      },
      child: Drawer(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                '$username',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
                textScaler: TextScaler.noScaling,
                maxLines: 2, // Or any number you want
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
              accountEmail: Text(
                'Version:$version',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 14, color: Colors.white),
                textScaler: TextScaler.noScaling,
              ),
              // currentAccountPicture: CircleAvatar(
              //   child: ClipOval(
              //     child: Image.asset(
              //       'assets/home/bus_ad.png',
              //       width: 90,
              //       height: 90,
              //       fit: BoxFit.cover, //fit image in circle
              //     ),
              //   ),
              // ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    // Colors.orange,
                    //   Color.fromARGB(255, 204, 123, 2),
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary
                  ])),
            ),
            // ListTile(
            //     leading: const Icon(
            //       Icons.bus_alert,
            //       color: Color(0xff13bc91),
            //     ),
            //     title: Text(
            //       "Trip Details",
            //       style: Theme.of(context).textTheme.bodyLarge,
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().employeeAssign);
            //     }),
            // ListTile(
            //     leading: const Icon(
            //       Icons.directions_bus,
            //       color: Colors.black
            //     ),
            //     title: Text(
            //       "Bus List",
            //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().busListScreen);
            //     }),
            // ListTile(
            //     leading: const Icon(
            //       Icons.badge_outlined,
            //       color: Colors.black,
            //     ),
            //     title: Text(
            //       "Conductor List",
            //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().conductorListNewScreen);
            //     }),
            // ListTile(
            //     leading: const Icon(
            //       Icons.emoji_transportation,
            //       color: Colors.black,
            //     ),
            //     title: Text(
            //       "Driver List",
            //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().screenDriverNewView);
            //     }),
            // ListTile(
            //     leading: const Icon(
            //       Icons.trip_origin,
            //       color: Colors.black,
            //     ),
            //     title: Text(
            //       "Trip List",
            //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().tripListScreen);
            //     }),
            // ListTile(
            //     leading: const Icon(
            //       Icons.route,
            //       color: Colors.black,
            //     ),
            //     title: Text(
            //       "Bus-Route List",
            //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().busRouteListScreen);
            //     }),
            // ListTile(
            //     leading: const Icon(
            //       Icons.stop_circle_outlined,
            //       color: Colors.black,
            //     ),
            //     title: Text(
            //       "Stop List",
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyLarge
            //           ?.copyWith(color: Colors.black),
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().stopListScreenNew);
            //     }),
            // ListTile(
            //     leading: const Icon(
            //       Icons.announcement,
            //       color: Colors.black,
            //     ),
            //     title: Text(
            //       "Announcement",
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyLarge
            //           ?.copyWith(color: Colors.black),
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().announcement);
            //     }),
            ListTile(
                leading: const Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Privacy Policy",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    Approutes().privacyScreen,
                  );
                }),
            ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
                title: Text(
                  "About",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
                onTap: () {}),
            const Divider(
              color: Colors.black38,
            ),
            ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Sign Out",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
                onTap: () {
                  signout(context);
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void signout(BuildContext ctx) async {
    final sharedprf = await SharedPreferences.getInstance();
    await sharedprf.remove(savekeyname);
    Navigator.of(_scaffoldKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const ScreenLogin(),
        ),
        (Route<dynamic> route) => false);
  }
}
