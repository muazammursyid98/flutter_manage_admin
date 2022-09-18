import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:get/get.dart';

import '../model/transaction_model.dart';
import '../service/transaction_service.dart';

class TransactionController extends GetxController {
  final TransactionService _transactionService = TransactionService();

  var statusRepsonseDisplay = [].obs;
  var isLoading = true.obs;
  String nowCalled = "";

  @override
  void onInit() {
    getTransactionToday();
    super.onInit();
  }

  @override
  void dispose() {
    Get.delete<TransactionService>();
    super.dispose();
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
    statusRepsonseDisplay.value = [];
    isLoading.value = true;
    List<Record>? statusRepsonse =
        await _transactionService.getTransactionToday();

    statusRepsonseDisplay.value = statusRepsonse ??= [];
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void getTransactionByDateRange(
      {required String firstDate, required String endDate}) async {
    nowCalled = "transaction";
    statusRepsonseDisplay.value = [];
    isLoading.value = true;
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
      if (values.isNotEmpty) {
        var startDate = values[0].toString().replaceAll('00:00:00.000', '');
        var endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
        getTransactionByDateRange(firstDate: startDate, endDate: endDate);
      } else {
        return 'null';
      }
    }
    return valueText;
  }
}
