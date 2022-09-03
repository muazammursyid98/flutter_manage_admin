import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../layout.dart';
import '../model/users_model.dart';
import '../routing/routes.dart';
import '../service/authentication_service.dart';
import '../widgets/snackbars.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService _authenticationService = AuthenticationService();

  TextEditingController usernameTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();

  void getLoginAdmin() async {
    int statusRepsonse = await _authenticationService
        .authenticationLogin(
            username: usernameTxt.text, password: passwordTxt.text)
        .catchError((onError) {
      const SnackBars().snackBarFail("Unable to login", "");
    });
    if (statusRepsonse == 200) {
      //Get.offAllNamed(rootRoute);
      Get.offAll(() => SiteLayout());
    } else {
      const SnackBars().snackBarFail("Unable to login", "");
    }
  }
}
