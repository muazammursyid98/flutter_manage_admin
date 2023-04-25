import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dext_expenditure_dashboard/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../controllers/overview_controller.dart';
import '../../controllers/transaction_controller.dart';
import '../../helpers/responsiveness.dart';
import '../clients/widgets/special_booking.dart';
import '../overview/overview.dart';
import 'widgets/drivers_table.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.purple[800],
    );

    final TransactionController counterController =
        Get.put(TransactionController());
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
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6,
                      left: 0),
                  child: CustomText(
                    text:
                        " for ${counterController.dateTimeSelectedDisplay.value}",
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            )),
        const SizedBox(height: 10),
        Row(
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       counterController.refreshList();
            //     },
            //     child: const Text("Refresh List")),
            // const SizedBox(width: 9),
            // ElevatedButton(
            //     onPressed: () {
            //       counterController.getTransactionToday();
            //     },
            //     child: const Text("Sort By Today")),
            // const SizedBox(width: 9),
            // ElevatedButton(
            //     onPressed: () {
            //       counterController.getTransaction();
            //     },
            //     child: const Text("Default Weekly List")),
            const SizedBox(width: 9),
            ElevatedButton(
                onPressed: () async {
                  var values = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: config,
                    dialogSize: const Size(325, 400),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    initialValue: [],
                    dialogBackgroundColor: Colors.white,
                  );
                  if (values != null) {
                    counterController.getValueText(
                      config.calendarType,
                      values,
                    );
                  }
                },
                child: const Text("Select Date By Range")),
            const SizedBox(width: 9),
            // ElevatedButton(
            //     onPressed: () {
            //       showDialog(
            //           context: context,
            //           builder: (_) {
            //             return const DialogSpecialBooking();
            //           }).then((value) {
            //         counterController.dateTimeSelectedDisplay.value = "-";
            //         counterController.statusRepsonseDisplay.value = [];
            //         if (!menuController.isActive('Overview')) {
            //           menuController.changeActiveItemTo('Overview');
            //           if (ResponsiveWidget.isSmallScreen(context)) Get.back();
            //           navigationController.navigateTo('/overview');
            //         }
            //       });
            //     },
            //     child: const Text("Special Booking")),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: DriversTable(),
        ),
      ],
    );
  }
}
