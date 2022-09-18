import 'package:dext_expenditure_dashboard/service/users_service.dart';
import 'package:get/get.dart';

import '../model/all_users_model.dart';

class UsersController extends GetxController {
  final UsersService _usersService = UsersService();

  var statusRepsonseDisplay = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getAllUsers();
    super.onInit();
  }

  void getAllUsers() async {
    statusRepsonseDisplay.value = [];
    isLoading.value = true;
    List<Record>? statusRepsonse = await _usersService.getAllUsers();

    statusRepsonseDisplay.value = statusRepsonse ??= [];
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }
}
