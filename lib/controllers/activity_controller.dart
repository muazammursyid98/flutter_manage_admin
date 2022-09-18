import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../model/activity_model.dart';
import '../service/activity_service.dart';

class ActivityController extends GetxController {
  final ActivityService _activityService = ActivityService();

  var statusRepsonseDisplay = [].obs;
  var isLoading = true.obs;

  var memoryBytes;

  @override
  void onInit() {
    getTheActivity();
    super.onInit();
  }

  void getTheActivity() async {
    isLoading.value = true;
    List<Record>? statusRepsonse = await _activityService.getActivity();

    statusRepsonseDisplay.value = statusRepsonse ??= [];
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  Future updateTheActivity(jsons) async {
    isLoading.value = true;
    int statusRepsonse = await _activityService.updateActivity(jsons);
    isLoading.value = false;
    return statusRepsonse;
  }

  Future insertTheActivity(jsons) async {
    isLoading.value = true;
    int statusRepsonse = await _activityService.insertActivity(jsons);
    isLoading.value = false;
    return statusRepsonse;
  }

  Future deleteTheActivity(jsons) async {
    isLoading.value = true;
    int statusRepsonse = await _activityService.deleteActivity(jsons);
    isLoading.value = false;
    return statusRepsonse;
  }
}
