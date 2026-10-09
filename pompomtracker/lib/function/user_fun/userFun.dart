import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pompomtracker/core/hook/hook.dart';
import 'package:pompomtracker/function/common_fun/commonFun.dart';
import 'package:pompomtracker/model/userModel/user_cmn_req/user_cmn_req.dart';
import 'package:pompomtracker/model/userModel/user_cmn_resp/user_cmn_resp.dart';

class UserFun {
  UserFun._internal();
  static UserFun instance = UserFun._internal();
  UserFun factory() {
    return instance;
  }

  Future<String?> resndotp(UserCmnReq val, BuildContext context) async {
    try {
      final loadingProvider = context.read<LoadingProvider>();
      loadingProvider.toggleLoading();
      final chngresp = await Busdata().resndOtp(val);
      final resultAsjson = jsonDecode(chngresp.toString());
      final changeval = UserCmnResp.fromJson(
        resultAsjson as Map<String, dynamic>,
      );

      loadingProvider.reset();
      if (chngresp == null) {
        if (!context.mounted) return '';
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (chngresp.statusCode == 200 && changeval.status == 'success') {
        //int refid = changeval.data?.refId ?? 0;
        if (!context.mounted) return '';

        CommonFun.instance.showApierror(
          context,
          "Otp resend on your registered mobile No",
        );

        return changeval.status;
      } else if (changeval.status == 'failed') {
        if (!context.mounted) return '';

        CommonFun.instance.showApierror(context, "OTP can't resend");
        return changeval.status;
      } else if (chngresp.statusCode == 500) {
        if (!context.mounted) return '';
        CommonFun.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (chngresp.statusCode == 408) {
        if (!context.mounted) return '';
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return '';
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return '';

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }
}
