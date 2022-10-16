import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/custom_text.dart';
import '../overview/widgets/available_drivers.dart';
import '../overview/widgets/overview_cards_large.dart';
import '../overview/widgets/overview_cards_medium.dart';
import '../overview/widgets/overview_cards_small.dart';
import '../overview/widgets/revenue_section_large.dart';
import '../overview/widgets/revenue_section_small.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            )),
        Expanded(
          child: ListView(
            children: [
              // if (ResponsiveWidget.isLargeScreen(context) ||
              //     ResponsiveWidget.isMediumScreen(context))
              //   if (ResponsiveWidget.isCustomSize(context))
              //     const SizedBox()
              //   //  OverviewCardsMediumScreen()
              //   else
              //     const SizedBox()
              // //  OverviewCardsLargeScreen()
              // else
              //  OverviewCardsSmallScreen(),
              if (!ResponsiveWidget.isSmallScreen(context))
                RevenueSectionLarge()
              else
                RevenueSectionSmall(),
              Container(
                height: 600,
                width: double.infinity,
                child: AvailableDriversTable(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
