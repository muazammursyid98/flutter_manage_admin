import 'package:dext_expenditure_dashboard/controllers/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherScreen extends StatelessWidget {
  OtherScreen({Key? key}) : super(key: key);

  final CounterController _counterController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("Screen was clicked ${_counterController.counter.value} times"),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Open other screen"))
      ]),
    );
  }
}
