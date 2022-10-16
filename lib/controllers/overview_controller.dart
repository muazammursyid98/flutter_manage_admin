import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/calendar_model.dart';
import '../service/overview_service.dart';

class OverviewController extends GetxController {
  final OverviewService _overviewService = OverviewService();

  RxBool isLoading = false.obs;

  RxList<dynamic> displayDateCalendar = [].obs;

  Rx<CalendarController> controller = CalendarController().obs;

  Rx<DateTime> dateTimeSelected = DateTime.now().obs;

  @override
  void onInit() {
    getCalendarOverview(DateTime.now());
    ever(dateTimeSelected, (value) {
      print("here");
      print(value);
      getCalendarOverview(DateTime.parse(value.toString()));
    });
    super.onInit();
  }

  getCalendarOverview(DateTime value) async {
    isLoading.value = true;
    var jsons = {
      "monthDate": DateFormat('yyyy-MM-dd').format(value),
    };
    List<Record>? statusRepsonse =
        await _overviewService.calendarOverview(jsons);

    var jsonsDateTime = [];

    String dateTimeFormat = "";
    for (var item in statusRepsonse!) {
      dateTimeFormat = DateFormat('yyyy-MM-dd').format(item.createdDate!);
      if (jsonsDateTime.isEmpty) {
        jsonsDateTime.add({
          "dateTimeCalendar": dateTimeFormat,
          "count": 1,
        });
      } else {
        bool isFoundMatched = false;
        for (var i = 0; i < jsonsDateTime.length; i++) {
          final valueOfArray = jsonsDateTime[i];
          if (valueOfArray["dateTimeCalendar"] == dateTimeFormat) {
            int getCount = valueOfArray["count"];
            valueOfArray["count"] = getCount + 1;
            isFoundMatched = true;
            break;
          }
        }
        if (!isFoundMatched) {
          jsonsDateTime.add({
            "dateTimeCalendar": dateTimeFormat,
            "count": 1,
          });
        }
      }
    }
    displayDateCalendar(jsonsDateTime);

    await Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }
}
