import 'package:dext_expenditure_dashboard/constants/style.dart';
import 'package:dext_expenditure_dashboard/layout.dart';
import 'package:dext_expenditure_dashboard/pages/authentication/authentication.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constants/size_config.dart';
import 'controllers/menu_controller.dart' as menuController;
import 'controllers/navigation_controller.dart';
import 'pages/404/error.dart';
import 'routing/routes.dart';

void main() {
  Get.put(menuController.MenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        initialRoute: authenticationPageRoute,
        unknownRoute: GetPage(
            name: '/not-found',
            page: () => PageNotFound(),
            transition: Transition.fadeIn),
        getPages: [
          GetPage(
              name: rootRoute,
              page: () {
                return SiteLayout();
              }),
          GetPage(
              name: authenticationPageRoute, page: () => AuthenticationPage()),
        ],

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

        // home: AuthenticationPage(),
      );
    });
  }
}
