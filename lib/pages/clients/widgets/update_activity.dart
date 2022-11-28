import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constants/condition_size.dart';
import '../../../controllers/activity_controller.dart';
import '../../../model/session_by_id_model.dart';
import '../../../model/session_model.dart';
import '../../../service/activity_service.dart';

class MyDialog extends StatefulWidget {
  final dynamic element;
  const MyDialog({this.element});
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController activityName = TextEditingController();
  TextEditingController shortDescription = TextEditingController();
  TextEditingController packageIclusive = TextEditingController();
  TextEditingController registerSlot = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController pricing = TextEditingController();
  Uint8List? bytesPhoto;
  String? base64Photo = "";
  String? photoName = "";
  bool checkBoxSlot = false;
  List<Session> listSession = [];
  bool isLoading = true;

  final ActivityController counterController = Get.put(ActivityController());

  final ActivityService _activityService = ActivityService();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    activityName = TextEditingController(text: widget.element.activityName);
    registerSlot =
        TextEditingController(text: widget.element.activityAvailable ??= 'N/A');
    location = TextEditingController(text: widget.element.activityLocation);
    pricing = TextEditingController(
      text: double.parse(widget.element.activityPrice).toStringAsFixed(2),
    );
    shortDescription =
        TextEditingController(text: widget.element.shortDescription);
    packageIclusive =
        TextEditingController(text: widget.element.packageIclusive);

    if (registerSlot.text == 'N/A') {
      checkBoxSlot = true;
    }
    callApiSession();
    setState(() {});
  }

  callApiSession() async {
    isLoading = true;
    setState(() {});
    List<Session>? statusRepsonse = await _activityService.getSession();
    listSession = statusRepsonse;
    callApiSessionById();
  }

  callApiSessionById() async {
    List<ListSessionRecord>? statusRepsonse =
        await _activityService.getSessionById(widget.element.activityId);
    for (var item in listSession) {
      List<ListSessionRecord> listSessionSelected = statusRepsonse!
          .where((element) =>
              element.shiftActivitiesId.toString() == item.shiftId.toString())
          .toList();
      if (listSessionSelected.isNotEmpty) {
        item.descriptionTableTime!.text =
            listSessionSelected[0].timeDescription!;
        item.isSelected = true;
        setState(() {});
      }
    }
    print(listSession);
    isLoading = false;
    setState(() {});
  }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  @override
  Widget build(BuildContext context) {
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
        "Edit ${widget.element.activityName} ",
        style: const TextStyle(fontSize: 24.0),
      ),
      content: Obx(
        () => counterController.isLoading.value == true || isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height / 1,
                width: MediaQuery.of(context).size.width / 1.5,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            // const Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Text(
                            //     "Image",
                            //   ),
                            // ),
                            ElevatedButton(
                                onPressed: () async {
                                  var picked =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowMultiple: false,
                                    allowCompression: false,
                                    allowedExtensions: ['jpg', 'png'],
                                  );
                                  if (picked == null) return;
                                  photoName = picked.files.first.name;
                                  bytesPhoto = picked.files.first.bytes;
                                  base64Photo = uint8ListTob64(bytesPhoto!);
                                  setState(() {});
                                  // PlatformFile file = picked.files.first;
                                  // File? convertToFile = File(file.path!);
                                },
                                child: const Text("Upload new image")),
                          ],
                        ),
                        bytesPhoto != null
                            ? Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: MemoryImage(
                                    bytesPhoto!,
                                  ),
                                )),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width / 4,
                              )
                            : Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    'https://rentasadventures.com/listActivityAsset/${widget.element.activityAsset}',
                                  ),
                                )),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width / 4,
                              ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: activityName,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Activity Name',
                                labelText: 'Activity Name'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: shortDescription,
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some value';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Short Description',
                                labelText: 'Short Description'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: packageIclusive,
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some value';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Package Inclusive',
                                labelText: 'Package Inclusive'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            readOnly: checkBoxSlot,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: registerSlot,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Registered Slot',
                                labelText: 'Registered Slot'),
                          ),
                        ),
                        CheckboxListTile(
                          title: const Text("Registered want to be empty ?"),
                          value: checkBoxSlot,
                          onChanged: (newValue) {
                            checkBoxSlot = newValue!;
                            if (checkBoxSlot == true) {
                              registerSlot.text = "N/A";
                            } else {
                              registerSlot.text = "0";
                            }
                            setState(() {});
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: location,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Location',
                                labelText: 'Location'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            controller: pricing,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Price',
                                labelText: 'Price (RM)'),
                          ),
                        ),
                        Column(
                          children: [
                            ...listSession.map((element) {
                              return Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: element.isSelected,
                                        onChanged: ((value) {
                                          element.isSelected = value;
                                          setState(() {});
                                        }),
                                      ),
                                      Text(element.shiftName!),
                                    ],
                                  ),
                                  element.isSelected == false
                                      ? const SizedBox()
                                      : Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller:
                                                element.descriptionTableTime,
                                            maxLines: 5,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some value';
                                              }
                                              return null;
                                            },
                                            onSaved: ((newValue) {
                                              element.descriptionTableTime!
                                                  .text = newValue!;
                                              setState(() {});
                                            }),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Enter Time Table',
                                                labelText: 'Time Table'),
                                          ),
                                        ),
                                ],
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 30),
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
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }

                                  List listCheckEmpty = listSession
                                      .where((element) =>
                                          element.isSelected == true)
                                      .toList();

                                  if (listCheckEmpty.isEmpty) {
                                    AwesomeDialog(
                                      width: checkConditionWidth(context),
                                      bodyHeaderDistance: 60,
                                      context: context,
                                      animType: AnimType.SCALE,
                                      dialogType: DialogType.INFO,
                                      body: const Center(
                                        child: Text(
                                          'Please select a session time',
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
                                    return;
                                  }

                                  List sessionToApi = [];

                                  for (var item in listSession) {
                                    if (item.isSelected == true) {
                                      var jsonsListSession = {
                                        "sessionId": item.shiftId,
                                        "timeDescription": Uri.encodeComponent(
                                            item.descriptionTableTime!.text),
                                      };
                                      sessionToApi.add(jsonsListSession);
                                    }
                                  }

                                  var jsons = {
                                    "authKey": "key123",
                                    "activityName": activityName.text,
                                    "shortDescription": Uri.encodeComponent(
                                        shortDescription.text),
                                    "packageIclusive": Uri.encodeComponent(
                                        packageIclusive.text),
                                    "available": registerSlot.text == "N/A"
                                        ? ""
                                        : registerSlot.text,
                                    "locationName": location.text,
                                    "imageName": photoName!,
                                    "imageBase64": base64Photo,
                                    "price": double.parse(pricing.text)
                                        .toStringAsFixed(2),
                                    "activityId": widget.element.activityId,
                                    "sessionActivities": sessionToApi,
                                  };

                                  int statusResponse = await counterController
                                      .updateTheActivity(jsons);
                                  if (statusResponse == 200) {
                                    AwesomeDialog(
                                      width: checkConditionWidth(context),
                                      bodyHeaderDistance: 60,
                                      context: context,
                                      animType: AnimType.SCALE,
                                      dialogType: DialogType.SUCCES,
                                      body: const Center(
                                        child: Text(
                                          'Update Successfully',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      title: 'Update for ${activityName.text}',
                                      desc: '',
                                      btnOkOnPress: () {
                                        Navigator.of(context).pop();
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
                                          'Failed to update',
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
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  // fixedSize: Size(250, 50),
                                ),
                                child: const Text(
                                  "Save",
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
    );
  }
}
