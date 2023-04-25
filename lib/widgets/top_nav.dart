import 'package:dext_expenditure_dashboard/helpers/responsiveness.dart';
import 'package:flutter/material.dart';

import '../constants/style.dart';
import 'custom_text.dart';

AppBar topNaigatorBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 14),
                  child: Image.asset("assets/icons/logo.png", width: 28),
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu),
              color: Colors.black,
            ),
      elevation: 0,
      title: Container(
        child: Row(
          children: [
            Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: CustomText(
                  text: "",
                  color: lightGrey,
                  size: 20,
                  weight: FontWeight.bold,
                )),
            Expanded(child: Container()),
            // IconButton(
            //     icon: Icon(
            //       Icons.settings,
            //       color: dark,
            //     ),
            //     onPressed: () {}),
            // Stack(
            //   children: [
            //     IconButton(
            //         icon: Icon(
            //           Icons.notifications,
            //           color: dark.withOpacity(.7),
            //         ),
            //         onPressed: () {}),
            //     Positioned(
            //       top: 7,
            //       right: 7,
            //       child: Container(
            //         width: 12,
            //         height: 12,
            //         padding: const EdgeInsets.all(4),
            //         decoration: BoxDecoration(
            //             color: active,
            //             borderRadius: BorderRadius.circular(30),
            //             border: Border.all(color: light, width: 2)),
            //       ),
            //     )
            //   ],
            // ),
            // Container(
            //   width: 1,
            //   height: 22,
            //   color: lightGrey,
            // ),
            const SizedBox(
              width: 24,
            ),
            // CustomText(
            //   text: 'Admin',
            //   color: lightGrey,
            // ),
            const SizedBox(
              width: 16,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //       color: active.withOpacity(.5),
            //       borderRadius: BorderRadius.circular(30)),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(30)),
            //     padding: EdgeInsets.all(2),
            //     margin: EdgeInsets.all(2),
            //     child: CircleAvatar(
            //       backgroundColor: light,
            //       child: Icon(
            //         Icons.person_outline,
            //         color: dark,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.transparent,
    );
