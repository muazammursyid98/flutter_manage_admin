import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

import '../model/calendar_model.dart';
import '../service/overview_service.dart';

class OverviewController extends GetxController {
  final OverviewService _overviewService = OverviewService();

  var isLoading = true.obs;

  List<dynamic> displayDateCalendar = [].obs;

  @override
  void onInit() {
    getCalendarOverview();
    super.onInit();
  }

  getCalendarOverview() async {
    isLoading.value = true;
    var jsons = {
      "monthDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
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

    displayDateCalendar = jsonsDateTime;

    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }
}
