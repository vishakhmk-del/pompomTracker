import 'dart:developer';

import 'package:pompomtracker/core/hook/hook.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLogin(context);
    super.initState();
  }

  Future<void> checkUserLogin(BuildContext context) async {
    final sharedpref = await SharedPreferences.getInstance();
    final useLoggedin = sharedpref.getBool(savekeyname) ?? false;
    if (!useLoggedin) {
      if (!context.mounted) return;

      gotoLogin(context);
    } else {
      final value = await SharedPrefManager.instance.getSharedData();

      if (value!.userId != '') {
        await Future.delayed(const Duration(seconds: 3));

        final val = await SharedPrefManager.instance.getdeviceinfo();

        final shareddevice = Deviceinfo(
          userId: value.userId ?? '',
          phone: val.phone,
          deviceid: val.deviceid,
          phoneos: val.phoneos,
          androidid: val.androidid ?? '',
          osversion: val.osversion,
          appversion: val.appversion,
          buildnumber: val.buildnumber,
        );
        try {
          final deviceinforesp = await Busdata().deviceinfo(shareddevice);
          final resultAsjson = jsonDecode(deviceinforesp.toString());
          final deviceinfoval =
              Loginresp.fromJson(resultAsjson as Map<String, dynamic>);
          if (deviceinforesp == null) {
            log("deviceinfo response null");
          } else if (deviceinforesp.statusCode == 200) {
            if (deviceinfoval.status == 'success') {
              log("device details added");

              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                Approutes().mainScreen,
              );
              //await Future.delayed(const Duration(seconds: 3));
              //await Wklycollectfn.instance.wklycolctfn();
            } else {
              if (deviceinfoval.data == null) {
                if (!context.mounted) return;
                Navigator.pushReplacement(
                  context,
                  Approutes().mainScreen,
                );
                //await Wklycollectfn.instance.wklycolctfn();
              } else if (deviceinfoval.data?.errorCode == 'VERSION001') {
                if (!context.mounted) return;

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ScreenError(
                      message: deviceinfoval.message,
                    ),
                  ),
                );
              } else {
                if (!context.mounted) return;
                Navigator.pushReplacement(
                  context,
                  Approutes().mainScreen,
                );
                //await Future.delayed(const Duration(seconds: 3));
                //await Wklycollectfn.instance.wklycolctfn();
              }
            }
            log("device details ${deviceinforesp.statusCode}");
          } else {
            log("device details ${deviceinforesp.statusCode}");
            if (!context.mounted) return;

            Navigator.pushReplacement(
              context,
              Approutes().mainScreen,
            );

            // await Future.delayed(const Duration(seconds: 3));
           // await Wklycollectfn.instance.wklycolctfn();
          }
        } catch (e) {
          if (!context.mounted) return;

          Navigator.pushReplacement(context, Approutes().mainScreen);
          // await Future.delayed(const Duration(seconds: 3));
         // await Wklycollectfn.instance.wklycolctfn();
        }
      } else {
        if (!context.mounted) return;

        gotoLogin(context);
      }
    }
  }

  Future<void> gotoLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (!context.mounted) return;

    Navigator.pushReplacement(context, Approutes().loginscreen);
    getdeviceinform(context);
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
            'assets/animatedsplash/Bus_carga_trackMile.json',
            width: MediaQuery.of(context).size.width / 1.5,
            //height: MediaQuery.of(context).size.height/2
          ),
        ),
      ),
    );
  }

  Future<void> getdeviceinform(BuildContext context) async {
    try {
      /*************deviceinfo*****************/
      final device = await DeviceInformation.getdeviceinfo();
      log(device);
      final deviceid = await DeviceInformation.getdeviceid();
      log(deviceid);
      final deviceos = await DeviceInformation.getOSdetails();
      log(deviceos);
      final devicescreen = await DeviceInformation.getScreenResolution();
      log(devicescreen);
      final deviceversion = await DeviceInformation.getDeviceVersion();
      log(deviceversion);
      final packagename = await Appinfo.getpackageName();
      log(packagename);
      final appversion = await Appinfo.getappVersion();
      log(appversion);
      final appver = appversion.split('+');
      final version = appver[0];
      final buildno = appver[1];
      final platformId = await DeviceInformation.initPlatformId();
      log('android id: $platformId');
      // final buildtime = await DeviceInformation.getbuildTime();
      // log('buildtime: $buildtime');

      /*****************************************/

      final shareddevice = Deviceinfo(
        phone: device,
        deviceid: deviceid,
        //devicetoken: deviceTkn??'',
        phoneos: deviceos,
        screenresolution: devicescreen,
        androidid: platformId ?? '',
        osversion: deviceversion,
        packagename: packagename,
        appversion: version,
        buildnumber: buildno,
        // buildtime: buildtime
      );

      await SharedPrefManager.instance.setdeviceinfo(shareddevice);
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        Approutes().loginscreen,
      );
    }
  }
}
