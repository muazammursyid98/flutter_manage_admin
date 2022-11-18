import 'package:dext_expenditure_dashboard/controllers/sales_controller.dart';
import 'package:dext_expenditure_dashboard/pages/sales/widget/revenue_section_large.dart';
import 'package:dext_expenditure_dashboard/pages/sales/widget/revenue_section_small.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/custom_text.dart';
import 'widget/available_drivers.dart';
import '../overview/widgets/overview_cards_large.dart';
import '../overview/widgets/overview_cards_medium.dart';
import '../overview/widgets/overview_cards_small.dart';

class SalesPage extends StatelessWidget {
  SalesPage({Key? key}) : super(key: key);
  final SalesController counterController = Get.put(SalesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
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
          ),
        ),
        Expanded(
          child: Obx(
            () => counterController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView(
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
        ),
      ],
    );
  }
}
