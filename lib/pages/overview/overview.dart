import 'package:dext_expenditure_dashboard/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../constants/controllers.dart';
import '../../controllers/overview_controller.dart';
import '../../controllers/transaction_controller.dart';
import '../../helpers/responsiveness.dart';

class OverviewPage extends StatelessWidget {
  OverviewPage({Key? key}) : super(key: key);

  final OverviewController counterController = Get.put(OverviewController());

  @override
  Widget build(BuildContext context) {
    counterController.dateTimeSelected.value = DateTime.now();
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
        Obx(() => counterController.isLoading.value
            ? const Expanded(child: Center(child: CircularProgressIndicator()))
            : Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1 - 100,
                margin:const EdgeInsets.only(bottom: 10),
                child: SfCalendar(
                  controller: counterController.controller.value,
                  initialDisplayDate: DateTime.now(),
                  onViewChanged: ((viewChangedDetails) {
                    SchedulerBinding.instance.addPostFrameCallback((duration) {
                      counterController.dateTimeSelected.value =
                          viewChangedDetails.visibleDates[
                              viewChangedDetails.visibleDates.length ~/ 2];
                      // counterController.getCalendarOverview(
                      //     viewChangedDetails.visibleDates[
                      //         viewChangedDetails.visibleDates.length ~/ 2]);
                    });
                    // if (_controller.displayDate != null) {
                    //   int getMiddleArray =
                    //       (viewChangedDetails.visibleDates.length / 2).floor();
                    //   // counterController
                    //   //     .getCalendarOverview(_controller.displayDate!);
                    //   counterController.getCalendarOverview(
                    //       viewChangedDetails.visibleDates[getMiddleArray]);
                    // }
                  }),

                  onSelectionChanged: (((viewChangedDetails) {
                    if (viewChangedDetails.date != null) {
                      final TransactionController transactionController =
                          Get.put(TransactionController());

                      transactionController.dateTimeSelectedDisplay.value =
                          DateFormat('dd/MM/yyyy')
                              .format(viewChangedDetails.date!);
                      transactionController.getTransactionByDateRange(
                          firstDate: DateFormat('yyyy-MM-dd')
                              .format(viewChangedDetails.date!),
                          endDate: 'null');
                      if (!menuController.isActive('Transaction')) {
                        menuController.changeActiveItemTo('Transaction');
                        if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                        navigationController.navigateTo('/transaction');
                      }
                    }
                  })),

                  allowAppointmentResize: true,
                  showNavigationArrow: true,
                  showDatePickerButton: true,
                  view: CalendarView.month,
                  headerHeight: 100,
                  dataSource: MeetingDataSource(_getDataSource()),
                  // by default the month appointment display mode set as Indicator, we can
                  // change the display mode as appointment using the appointment display
                  // mode property
                  monthViewSettings: const MonthViewSettings(
                      monthCellStyle:
                          MonthCellStyle(backgroundColor: Colors.white),
                      agendaStyle: AgendaStyle(backgroundColor: Colors.white),
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                ),
              )),

        // Expanded(
        //     child: ListView(
        //   children: [
        //     if (ResponsiveWidget.isLargeScreen(context) ||
        //         ResponsiveWidget.isMediumScreen(context))
        //       if (ResponsiveWidget.isCustomSize(context))
        //         OverviewCardsMediumScreen()
        //       else
        //         OverviewCardsLargeScreen()
        //     else
        //       OverviewCardsSmallScreen(),
        //     if (!ResponsiveWidget.isSmallScreen(context))
        //       RevenueSectionLarge()
        //     else
        //       RevenueSectionSmall(),
        //     AvailableDriversTable(),
        //   ],
        // ))
      ],
    );
  }

  List<Meeting> _getDataSource() {
    counterController.isLoading.value = true;
    final List<Meeting> meetings = <Meeting>[];
    // final DateTime today = DateTime.now();
    // final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));

    // final DateTime startTimeOne =
    //     DateTime(today.year, today.month, today.day + 2, 9);
    // final DateTime endTimeOne = startTime.add(const Duration(days: 2));
    // meetings.add(Meeting(
    //     '10 Purchased', startTime, endTime, const Color(0xFF0F8644), false));
    // meetings.add(Meeting('5 Purchased', startTimeOne, endTimeOne,
    //     const Color(0xFF0F8644), false));
    // counterController.isLoading(true);
    for (var item in counterController.displayDateCalendar) {
      DateTime dateTimeDisplay = DateTime.parse(item["dateTimeCalendar"]);
      meetings.add(Meeting('- ${item["count"]} Purchases Ticket',
          dateTimeDisplay, dateTimeDisplay, const Color(0xFF0F8644), false));
    }
    counterController.isLoading.value = false;
    // Future.delayed(const Duration(seconds: 1), () {
    //   counterController.isLoading(false);
    // });
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
