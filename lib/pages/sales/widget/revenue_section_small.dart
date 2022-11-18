import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/style.dart';
import '../../../controllers/sales_controller.dart';
import '../../../widgets/custom_text.dart';
import 'bar_chart.dart';
import '../../overview/widgets/revenue_info.dart';

class RevenueSectionSmall extends StatelessWidget {
  RevenueSectionSmall({Key? key}) : super(key: key);

  final SalesController counterController = Get.put(SalesController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          Container(
            height: 260,
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
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueInfo(
                      title: "Today's sales",
                      amount: counterController.salesDisplay.value!.salesToday,
                    ),
                    RevenueInfo(
                      title: "This week sales",
                      amount: counterController.salesDisplay.value!.salesWeekly,
                    ),
                  ],
                ),
                Row(
                  children: [
                    RevenueInfo(
                      title: "This month sales",
                      amount:
                          counterController.salesDisplay.value!.salesMonthly,
                    ),
                    RevenueInfo(
                      title: "This year sales",
                      amount: counterController.salesDisplay.value!.salesYearly,
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
