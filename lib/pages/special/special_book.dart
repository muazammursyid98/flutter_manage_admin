import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/nanoid.dart';

import '../../../constants/condition_size.dart';
import '../../../controllers/transaction_controller.dart';
import '../../../model/activity_model.dart';
import '../../../model/session_model.dart';
import '../../../service/activity_service.dart';
import '../../constants/controllers.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/custom_text.dart';

class SpecialBook extends StatefulWidget {
  const SpecialBook({super.key});

  @override
  State<SpecialBook> createState() => _SpecialBookState();
}

class _SpecialBookState extends State<SpecialBook> {
  final ActivityService _activityService = ActivityService();

  final TransactionController counterController =
      Get.put(TransactionController());

  final chooseDate = TextEditingController();

  final personName = TextEditingController();

  final phoneNumber = TextEditingController();

  final emailPerson = TextEditingController();

  final totalPerson = TextEditingController();

  final totalPrice = TextEditingController(text: '0');

  final discountPrice = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = true;

  List<Record> listActivity = [];

  List<Session> listSession = [];

  var _selectedActivity;

  var _selectedSession;

  DateTime? chooseDateApi;

  bool? isDiscount = false;

  String totalPriceOri = "";

  @override
  void initState() {
    getTheActivity();
    super.initState();
  }

  void getTheActivity() async {
    List<Record>? statusRepsonse = await _activityService.getActivity();
    listActivity = statusRepsonse ?? [];
    Future.delayed(const Duration(milliseconds: 500), () {
      getSession();
    });
  }

  void getSession() async {
    List<Session>? statusRepsonse = await _activityService.getSession();
    listSession = statusRepsonse;
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: Colors.purple[800],
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            )),
        const SizedBox(height: 30),
        Expanded(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                labelText: 'Activity',
                                errorStyle: const TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                hintText: 'Please select activity',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            isEmpty: _selectedActivity == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (_selectedActivity == null ||
                                      _selectedActivity.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                hint: const Text('Please select activity'),
                                value: _selectedActivity,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    totalPrice.text = "";
                                    totalPerson.text = "";
                                    discountPrice.text = "";
                                    isDiscount = false;
                                    _selectedActivity = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: listActivity.map((Record value) {
                                  return DropdownMenuItem<String>(
                                    value: value.activityId,
                                    child: Text(value.activityName!),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                labelText: 'Session',
                                errorStyle: const TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                hintText: 'Please select session',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            isEmpty: _selectedSession == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (_selectedSession == null ||
                                      _selectedSession.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                hint: const Text('Please select session'),
                                value: _selectedSession,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedSession = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: listSession.map((Session value) {
                                  return DropdownMenuItem<String>(
                                    value: value.shiftId.toString(),
                                    child: Text(
                                      "${value.shiftName!} ${value.startTime!} - ${value.endTime!}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
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
                            hintText: 'Enter Booking Date',
                            labelText: 'Booking Date'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: personName,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Person\'s Name',
                            labelText: 'Person Name'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: phoneNumber,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Phone Number',
                            labelText: 'Phone Number'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: emailPerson,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Person\'s Email',
                            labelText: 'Email'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        onChanged: (value) {
                          try {
                            if (value == "") {
                              totalPrice.text = "0";
                              return;
                            }
                            Record recordValue = listActivity.singleWhere(
                                (element) =>
                                    element.activityId == _selectedActivity);
                            double totalCalculated = double.parse(value) *
                                double.parse(recordValue.activityPrice!);
                            totalPrice.text =
                                totalCalculated.toStringAsFixed(2);
                            totalPriceOri = totalCalculated.toStringAsFixed(2);
                            isDiscount = false;
                            discountPrice.text = "";
                            setState(() {});
                          } catch (e) {
                            totalPrice.text = "0";
                          }
                        },
                        controller: totalPerson,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Total Person',
                            labelText: 'Total Person'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        readOnly: true,
                        controller: totalPrice,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Total Price',
                            labelText: 'Total Price'),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Checkbox(
                              value: isDiscount,
                              onChanged: (value) {
                                isDiscount = value!;
                                if (value == false) {
                                  discountPrice.text = "";
                                }
                                setState(() {});
                              }),
                          const CustomText(text: "Have a discount ?"),
                        ],
                      ),
                    ),
                    isDiscount == false
                        ? SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (value) {
                                try {
                                  if (value != "") {
                                    double discountValue =
                                        double.parse(totalPriceOri) *
                                            (100 - double.parse(value)) /
                                            100;
                                    totalPrice.text =
                                        discountValue.toStringAsFixed(2);
                                  } else {
                                    totalPrice.text = totalPriceOri;
                                  }
                                } catch (e) {
                                  totalPrice.text = totalPriceOri;
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}')),
                              ],
                              readOnly: false,
                              controller: discountPrice,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'How many (%) ?',
                                  labelText: 'Discount (%)'),
                            ),
                          ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
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
                          width: MediaQuery.of(context).size.width / 3,
                          height: 60,
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var customLengthId = nanoid(10);
                                var jsons = {
                                  "activitiesId": _selectedActivity.toString(),
                                  "totalBookedSlot": totalPerson.text,
                                  "dateSlot": chooseDateApi.toString(),
                                  "shiftSlotId": _selectedSession.toString(),
                                  "firstNameRegister": personName.text,
                                  "firstPhoneNumberRegister": phoneNumber.text,
                                  "firstEmailRegister": emailPerson.text,
                                  "temporaryUnique": customLengthId,
                                  "totalPrice": totalPrice.text,
                                  "remark": isDiscount == true
                                      ? "discount"
                                      : "special",
                                };
                                print(jsons);
                                int status = await _activityService
                                    .goToInsertSpecialBooking(jsons);
                                if (status == 200) {
                                  AwesomeDialog(
                                    width: checkConditionWidth(context),
                                    bodyHeaderDistance: 60,
                                    context: context,
                                    animType: AnimType.SCALE,
                                    dialogType: DialogType.SUCCES,
                                    body: const Center(
                                      child: Text(
                                        'Insert Successfully for special booking.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    title: 'Booking for ${personName.text}',
                                    desc: '',
                                    btnOkOnPress: () {
                                      navigationController
                                          .navigateTo('/overview');
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
                                        'Failed to special booking please try again.',
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
