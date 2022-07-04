import 'package:dext_expenditure_dashboard/screens/other.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controllers/counter_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("Clicks: ${counterController.counter.value}")),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(OtherScreen());
                    },
                    child: Text("Open other screen")),
              )
            ],
          ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
