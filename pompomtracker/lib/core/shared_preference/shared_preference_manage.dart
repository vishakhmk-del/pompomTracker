import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pompomtracker/core/hook/hook.dart';

class SharedPrefManager {
  //---singleton-----
  SharedPrefManager._internal();
  static SharedPrefManager instance = SharedPrefManager._internal();
  SharedPrefManager factory() {
    return instance;
  }
  //----end singleton
final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> addSharedData(Sharedpref value) async {
    final sharedprefes = await SharedPreferences.getInstance();
    await sharedprefes.setBool(savekeyname, true);
    // await sharedprefes.setString('USERID', value.userId!);
    await _secureStorage.write(key: 'USERID', value: value.userId ?? '');

    await sharedprefes.setString('USERTYPE', value.userType??'');
    await sharedprefes.setString('USERNAME', value.userName??'');
    await sharedprefes.setString('OWNERNAME', value.ownerName??'');
    // await sharedprefes.setString('TOKEN', value.token??'');
        await _secureStorage.write(key: 'TOKEN', value: value.token ?? '');


    //final jsonString = json.encode(value.toJson());
    // await prefs.setStringList(_key, login);
  }

  Future<Sharedpref?> getSharedData() async {
    final sharedprefs = await SharedPreferences.getInstance();

    // final userid = sharedprefs.getString('USERID') ?? '';
    final userid = await _secureStorage.read(key: 'USERID') ?? '';


    final usertype = sharedprefs.getString('USERTYPE') ?? '';

    final username = sharedprefs.getString('USERNAME') ?? '';

    final ownername = sharedprefs.getString('OWNERNAME') ?? '';

    // final token = sharedprefs.getString('TOKEN') ?? '';
    final token = await _secureStorage.read(key: 'TOKEN') ?? '';


    final valshared = Sharedpref.value(
        userId: userid,
        userType: usertype,
        userName: username,
        ownerName: ownername,
        token: token);
    return valshared;
  }

  Future<void> setdeviceinfo(Deviceinfo value) async {
    final sharedprefes = await SharedPreferences.getInstance();
    await sharedprefes.setBool(savedeviceinfo, true);
    await sharedprefes.setString('DEVICE', value.phone ?? '');
    await sharedprefes.setString('DEVICEOS', value.phoneos ?? '');
    await sharedprefes.setString('DEVICEID', value.deviceid ?? '');
    // await sharedprefes.setString('DEVICETOKEN', value.devicetoken ?? '');
    await sharedprefes.setString('PLATFORMID', value.androidid ?? '');
    await sharedprefes.setString(
        'SCREENRESOLUTION', value.screenresolution ?? '');
    await sharedprefes.setString('DEVICEVERSION', value.osversion ?? '');
    await sharedprefes.setString('PACKAGENAME', value.packagename ?? '');
    await sharedprefes.setString('APPVERSION', value.appversion ?? '');
    await sharedprefes.setString('BUILDNUMBER', value.buildnumber ?? '');
    // await sharedprefes.setString('BUILDTIME', value.buildtime ?? '');
  }

  Future<Deviceinfo> getdeviceinfo() async {
    final sharedprefs = await SharedPreferences.getInstance();
    bool checkValue = sharedprefs.containsKey('DEVICE');
    log('$checkValue');
    final device = sharedprefs.getString('DEVICE') ?? '';
    final deviceos = sharedprefs.getString('DEVICEOS') ?? '';
    final deviceid = sharedprefs.getString('DEVICEID') ?? '';
    // final devicetkn = sharedprefs.getString('DEVICETOKEN') ?? '';
    final platformid = sharedprefs.getString('PLATFORMID') ?? '';
    final screenres = sharedprefs.getString('SCREENRESOLUTION') ?? '';
    final deviceversion = sharedprefs.getString('DEVICEVERSION') ?? '';
    final packagename = sharedprefs.getString('PACKAGENAME') ?? '';
    final appversion = sharedprefs.getString('APPVERSION') ?? '';
    final buildno = sharedprefs.getString('BUILDNUMBER') ?? '';
    // final buildtime = sharedprefs.getString('BUILDTIME') ?? '';

    final infoshared = Deviceinfo(
      phone: device,
      phoneos: deviceos,
      deviceid: deviceid,
      // devicetoken: devicetkn,
      androidid: platformid,
      screenresolution: screenres,
      osversion: deviceversion,
      packagename: packagename,
      appversion: appversion,
      buildnumber: buildno,
      // buildtime: buildtime
    );

    return infoshared;
  }
}
