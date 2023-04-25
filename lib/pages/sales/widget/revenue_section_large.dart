import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/style.dart';
import '../../../controllers/sales_controller.dart';
import '../../../widgets/custom_text.dart';
import 'bar_chart.dart';
import '../../overview/widgets/revenue_info.dart';

class RevenueSectionLarge extends StatelessWidget {
  final SalesController counterController = Get.put(SalesController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Sales Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: lightGrey,
                ),
                Container(
                    width: 600,
                    height: 200,
                    child: SimpleBarChart.withSampleData()),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Obx(
                      () => RevenueInfo(
                        title: "Today's sales",
                        amount:
                            counterController.salesDisplay.value!.salesToday,
                      ),
                    ),
                    Obx(
                      () => RevenueInfo(
                        title: "This week sales",
                        amount:
                            counterController.salesDisplay.value!.salesWeekly,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Obx(
                      () => RevenueInfo(
                        title: "This month sales",
                        amount:
                            counterController.salesDisplay.value!.salesMonthly,
                      ),
                    ),
                    Obx(
                      () => RevenueInfo(
                        title: "This year sales",
                        amount:
                            counterController.salesDisplay.value!.salesYearly,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
