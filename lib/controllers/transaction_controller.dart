import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/transaction_model.dart';

import '../service/activity_service.dart';
import '../service/transaction_service.dart';

class TransactionController extends GetxController {
  final TransactionService _transactionService = TransactionService();
  final ActivityService _activityService = ActivityService();

  var statusRepsonseDisplay = [].obs;
  var isLoading = true.obs;
  String nowCalled = "";
  RxString dateTimeSelectedDisplay = "".obs;

  var listActivity = [].obs;

  @override
  void onInit() {
    getTransactionToday();
    getTheActivity();

    super.onInit();
  }

  @override
  void dispose() {
    Get.delete<TransactionService>();
    super.dispose();
  }

  void getTheActivity() async {
    isLoading.value = true;
    var statusRepsonse = await _activityService.getActivity();

    listActivity.value = statusRepsonse ??= [];
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void getTransaction() async {
    nowCalled = "transaction";
    statusRepsonseDisplay.value = [];
    isLoading.value = true;
    List<Record>? statusRepsonse = await _transactionService.getTransaction();

    statusRepsonseDisplay.value = statusRepsonse ??= [];
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void getTransactionToday() async {
    nowCalled = "todayTransaction";
    String firstDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dateTimeSelectedDisplay.value = "-";
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
    // statusRepsonseDisplay.value = [];
    // isLoading.value = true;
    // List<Record>? statusRepsonse =
    //     await _transactionService.getTransactionToday();

    // statusRepsonseDisplay.value = statusRepsonse ??= [];
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   isLoading.value = false;
    // });
  }

  void getTransactionByDateRange(
      {required String firstDate, required String endDate}) async {
    endDate == 'null' ? endDate = firstDate : endDate = endDate;
    nowCalled = "transaction";
    statusRepsonseDisplay.value = [];
    isLoading.value = true;
    print(firstDate);
    print(endDate);
    List<Record>? statusRepsonse = await _transactionService
        .getTransactionByDateRange(startDate: firstDate, endDate: endDate);

    statusRepsonseDisplay.value = statusRepsonse ??= [];
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  refreshList() {
    if (nowCalled == "transaction") {
      getTransaction();
    } else {
      getTransactionToday();
    }
  }

  String getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      if (values.isNotEmpty) {
        var startDate = values[0].toString().replaceAll('00:00:00.000', '');
        var endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        if (endDate == 'null') {
          valueText = dateFormat.format(values[0]!);
        } else {
          valueText =
              '${dateFormat.format(values[0]!)} to ${dateFormat.format(values[1]!)}';
        }
        dateTimeSelectedDisplay.value = valueText;
        getTransactionByDateRange(firstDate: startDate, endDate: endDate);
      } else {
        return 'null';
      }
    }
    return valueText;
  }
}
