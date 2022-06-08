import 'package:dext_expenditure_dashboard/helpers/responsiveness.dart';
import 'package:dext_expenditure_dashboard/widgets/small_screen.dart';
import 'package:dext_expenditure_dashboard/widgets/top_nav.dart';
import 'package:flutter/material.dart';

import 'widgets/large_screen.dart';
import 'widgets/side_menu.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNaigatorBar(context, scaffoldKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
