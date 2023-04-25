import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/condition_size.dart';
import '../../../constants/controllers.dart';
import '../../../service/activity_service.dart';

class ChangeDateScreen extends StatefulWidget {
  final String clientName;
  final String idOrder;
  const ChangeDateScreen({
    super.key,
    required this.clientName,
    required this.idOrder,
  });

  @override
  State<ChangeDateScreen> createState() => _ChangeDateScreenState();
}

class _ChangeDateScreenState extends State<ChangeDateScreen> {
  final _formKey = GlobalKey<FormState>();
  final chooseDate = TextEditingController();
  DateTime? chooseDateApi;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: Colors.purple[800],
    );
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.0,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 10.0,
      ),
      title: Text(
        "Change Date for ${widget.clientName}",
        style: const TextStyle(fontSize: 24.0),
      ),
      content: SizedBox(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter date';
                        }
                        return null;
                      },
                      onTap: () async {
                        var values = await showCalendarDatePicker2Dialog(
                          context: context,
                          config: config,
                          dialogSize: const Size(325, 400),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          initialValue: [DateTime.now()],
                          dialogBackgroundColor: Colors.white,
                        );
                        if (values != null) {
                          chooseDate.text =
                              DateFormat('dd/MM/yyyy').format(values[0]!);
                          chooseDateApi = values[0];
                        }
                      },
                      readOnly: true,
                      controller: chooseDate,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Change Booking Date',
                          labelText: 'Booking Change Date'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            // fixedSize: Size(250, 50),
                          ),
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var jsons = {
                                "orderId": widget.idOrder,
                                "dateSlot": chooseDateApi.toString(),
                              };
                              int status = await ActivityService()
                                  .goToUpdateDateBooking(jsons);
                              if (status == 200) {
                                AwesomeDialog(
                                  width: checkConditionWidth(context),
                                  bodyHeaderDistance: 60,
                                  context: context,
                                  animType: AnimType.SCALE,
                                  dialogType: DialogType.SUCCES,
                                  body: const Center(
                                    child: Text(
                                      'Update Booking Date Successfully',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  title:
                                      'Update Date Booking for ${widget.clientName}',
                                  desc: '',
                                  btnOkOnPress: () {
                                    Navigator.of(context).pop();
                                    navigationController
                                        .navigateTo('/overview');
                                    menuController
                                        .changeActiveItemTo('Overview');
                                  },
                                ).show();
                              } else {
                                AwesomeDialog(
                                  width: checkConditionWidth(context),
                                  bodyHeaderDistance: 60,
                                  context: context,
                                  animType: AnimType.SCALE,
                                  dialogType: DialogType.ERROR,
                                  body: const Center(
                                    child: Text(
                                      'Failed to update special booking please try again.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  title: 'Failed',
                                  desc: '',
                                  btnOkOnPress: () {},
                                ).show();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            // fixedSize: Size(250, 50),
                          ),
                          child: const Text(
                            "Submit",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
