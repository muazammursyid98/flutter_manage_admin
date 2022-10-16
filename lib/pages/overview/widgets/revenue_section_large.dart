import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import 'bar_chart.dart';
import 'revenue_info.dart';

class RevenueSectionLarge extends StatelessWidget {
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
                  children: const [
                    RevenueInfo(
                      title: "Today's sales",
                      amount: "0",
                    ),
                    RevenueInfo(
                      title: "This week sales",
                      amount: "0",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    RevenueInfo(
                      title: "This month sales",
                      amount: "0",
                    ),
                    RevenueInfo(
                      title: "This year sales",
                      amount: "0",
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
