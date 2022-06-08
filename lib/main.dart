import 'package:dext_expenditure_dashboard/constants/controllers.dart';
import 'package:dext_expenditure_dashboard/constants/style.dart';
import 'package:dext_expenditure_dashboard/layout.dart';
import 'package:dext_expenditure_dashboard/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/menu_controller.dart';
import 'controllers/navigation_controller.dart';

void main() {
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dashboard",
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primaryColor: Colors.blue,
      ),
      home: AuthenticationPage(),
    );
  }
}
