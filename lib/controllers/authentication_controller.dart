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
  var isLoading = false.obs;

  void getLoginAdmin() async {
    isLoading.value = true;
    int statusRepsonse = await _authenticationService
        .authenticationLogin(
            username: usernameTxt.text, password: passwordTxt.text)
        .catchError((onError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        isLoading.value = false;
      });
      const SnackBars().snackBarFail("Unable to login", "");
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
    if (statusRepsonse == 200) {
      //Get.offAllNamed(rootRoute);
      Get.offAll(() => SiteLayout());
    } else {
      const SnackBars().snackBarFail("Unable to login", "");
    }
  }
}
