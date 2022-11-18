import 'package:dext_expenditure_dashboard/service/sales_service.dart';
import 'package:get/get.dart';

import '../model/sales_model.dart';

class SalesController extends GetxController {
  final SalesService _salesService = SalesService();

  Rx<bool> isLoading = true.obs;
  Rx<SalesSummary?> salesDisplay = (null as SalesSummary?).obs;

  @override
  void onInit() {
    getSales();
    super.onInit();
  }

  void getSales() async {
    isLoading.value = true;
    SalesSummary? statusRepsonse = await _salesService.getSales();
    salesDisplay.value = statusRepsonse!;

    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }
}
