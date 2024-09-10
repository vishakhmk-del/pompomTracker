import 'package:pompomtracker/core/hook/hook.dart';

class Navbar extends StatefulWidget {
  //final int? category;
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = '';
  String brname = '';
  bool isVisible = true;
  String? version;
  @override
  void initState() {
    //checkUserLoggedIn();
    super.initState();
  }
  // void buildversion() async {
  //   final value = await Sharedata.instance.getdeviceinfo();

  //  final devversion=value.appversion;
  //  final devicever=devversion!.split('+');
  //  final versionval=devicever[0];

  //   setState(() {
  //     version=versionval;
  //   });
  // }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Screenhome(),
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
        key: _scaffoldKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'PomPomTracker',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              accountEmail: Text('Version:$version'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/home/bus_ad.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover, //fit image in circle
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Theme.of(context).colorScheme.onPrimaryFixed,
                    Theme.of(context).colorScheme.onPrimary
                  ])),
            ),
            ListTile(
                leading: const Icon(
                  Icons.bus_alert,
                  color: Color(0xff13bc91),
                ),
                title: Text(
                  "Bus List",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().busListScreen);
                }),
            ListTile(
                leading: const Icon(
                  Icons.person_2_outlined,
                  //color: Appcolors.labelclr,
                ),
                title: Text(
                  "Conductor List",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().conductorListScreen);
                }),
            const Divider(),
            ListTile(
                leading: const Icon(
                  Icons.trip_origin,
                  //color: Appcolors.labelclr,
                ),
                title: Text(
                  "Trip List",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().tripListScreen);
                }),
            ListTile(
                leading: const Icon(
                  Icons.route,
                  //color: Appcolors.labelclr,
                ),
                title: Text(
                  "Bus-Route List",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().busRouteListScreen);
                }),
            ListTile(
                leading: const Icon(
                  Icons.stop_circle_outlined,
                  //color: Appcolors.labelclr,
                ),
                title: Text(
                  "Stop List",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().stopListScreen);
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
}
