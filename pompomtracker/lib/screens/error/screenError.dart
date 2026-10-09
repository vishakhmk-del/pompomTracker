import 'dart:io';

import 'package:pompomtracker/core/hook/hook.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenError extends StatefulWidget {
  const ScreenError({super.key, this.version});
  final Loginresp? version;

  @override
  State<ScreenError> createState() => _ScreenErrorState();
}

class _ScreenErrorState extends State<ScreenError> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? version;
  String? buildnumber;
  @override
  void initState() {
    super.initState();
    verisoninfo();
  }

  void verisoninfo() async {
    final value = await SharedPrefManager.instance.getdeviceinfo();
    setState(() {
      version = value.appversion;
      buildnumber = value.buildnumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(key: _scaffoldKey, children: [
      // const Backgroundsplash(),
      Scaffold(
        backgroundColor: const Color(0xff98c1d9),
        body: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage("assets/error/alekseyvanin200701168.jpg"),
                  ),
                  //Text("Loading")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE1E1E1),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  backgroundImage: const AssetImage('assets/home/bus_ad.png'),
                ),
              ),
              Text(
                "Buildnumber : $buildnumber",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Version : $version",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.update_outlined,
                      color: Colors.red,
                      size: 35,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Update Available",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${widget.version?.message}",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    widget.version?.mandatory == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  backgroundColor: const Color(0xffffa600),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    Approutes().mainScreen,
                                  );
                                },
                                child: Text(
                                  "Skip",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  backgroundColor: const Color(0xffffa600),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  _openStore();
                                },
                                child: Text(
                                  "Update Now",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 2,
                                backgroundColor: const Color(0xffffa600),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                _openStore();
                              },
                              child: Text(
                                "Update Now",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                  ],
                ),
                // Text(
                //   "${widget.message}",
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodyLarge
                //       ?.copyWith(color: const Color.fromARGB(255, 220, 29, 16)),
                //   textAlign: TextAlign.center,
                // ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  static Future<void> _openStore() async {
    final Uri androidUrl =
        Uri.parse("https://play.google.com/store/apps/details?id=your.package");

    final Uri iosUrl = Uri.parse("https://apps.apple.com/app/idXXXXXXXXX");

    if (Platform.isAndroid) {
      if (await canLaunchUrl(androidUrl)) {
        await launchUrl(androidUrl, mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isIOS) {
      if (await canLaunchUrl(iosUrl)) {
        await launchUrl(iosUrl, mode: LaunchMode.externalApplication);
      }
    }
  }
}
