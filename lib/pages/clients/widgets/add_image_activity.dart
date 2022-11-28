import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/condition_size.dart';
import '../../../model/activity_model.dart';
import '../../../model/image_details_model.dart';
import '../../../service/activity_service.dart';

class AddImageActivity extends StatefulWidget {
  const AddImageActivity({Key? key}) : super(key: key);

  @override
  _AddImageActivityState createState() => _AddImageActivityState();
}

class _AddImageActivityState extends State<AddImageActivity> {
  final ActivityService _activityService = ActivityService();

  bool isLoading = true;
  List<Record> listActivity = [];
  List<ImageDetail> listDetailsImage = [];

  final _formKey = GlobalKey<FormState>();

  var _selectedActivity;

  List<Uint8List?> bytesPhoto = [];
  List<String?> base64Photo = [];
  List<String?> photoName = [];

  List<String?> networkImageDelete = [];

  @override
  void initState() {
    getTheActivity();
    super.initState();
  }

  void getTheActivity() async {
    List<Record>? statusRepsonse = await _activityService.getActivity();
    listActivity = statusRepsonse ?? [];
    isLoading = false;
    setState(() {});
  }

  void getDetailsImage(idActivity) async {
    listDetailsImage = [];
    bytesPhoto = [];
    base64Photo = [];
    photoName = [];

    isLoading = true;
    setState(() {});
    List<ImageDetail>? statusRepsonse =
        await _activityService.getImageDetails(idActivity);
    listDetailsImage = statusRepsonse;

    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading = false;
      setState(() {});
    });
  }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  deleteNetwork(elementNetwork) {
    int index = listDetailsImage.indexWhere((item) =>
        item.activitiesDetailsId == elementNetwork.activitiesDetailsId);
    listDetailsImage.removeAt(index);
    networkImageDelete.add(elementNetwork.activitiesDetailsId);
    setState(() {});
  }

  deleteByte(elementBytes) {
    int index = bytesPhoto.indexWhere((item) => item == elementBytes);
    photoName.removeAt(index);
    bytesPhoto.removeAt(index);
    base64Photo.removeAt(index);
    setState(() {});
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
      title: const Text(
        "Add New Image Activity ",
        style: const TextStyle(fontSize: 24.0),
      ),
      content: isLoading == true
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
                    children: [
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
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
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
                                    _selectedActivity = newValue;
                                    getDetailsImage(
                                        _selectedActivity.toString());
                                    setState(() {});
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
                      _selectedActivity == null
                          ? SizedBox()
                          : Container(
                              padding: const EdgeInsets.all(8.0),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        labelText: 'Add Image',
                                        errorStyle: const TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16.0),
                                        hintText: 'Please enter image',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    isEmpty: _selectedActivity == '',
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            var picked = await FilePicker
                                                .platform
                                                .pickFiles(
                                              type: FileType.custom,
                                              allowMultiple: false,
                                              allowCompression: false,
                                              allowedExtensions: ['jpg', 'png'],
                                            );
                                            if (picked == null) return;
                                            photoName
                                                .add(picked.files.first.name);
                                            bytesPhoto
                                                .add(picked.files.first.bytes);
                                            Uint8List bytesPhotoPass =
                                                picked.files.first.bytes!;
                                            base64Photo.add(
                                                uint8ListTob64(bytesPhotoPass));

                                            setState(() {});
                                            // PlatformFile file = picked.files.first;
                                            // File? convertToFile = File(file.path!);
                                          },
                                          child: const Text(
                                              "Upload details image"),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 40.h,
                                          child: GridView.count(
                                            crossAxisCount: 4,
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              ...listDetailsImage
                                                  .map(
                                                    (elementNetwork) => Stack(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                            fit: BoxFit.contain,
                                                            image: NetworkImage(
                                                              'https://rentasadventures.com/listActivityAsset/${elementNetwork.imageName}',
                                                            ),
                                                          )),
                                                          width:
                                                              double.infinity,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                        ),
                                                        Positioned(
                                                            right: 0,
                                                            child: InkWell(
                                                              onTap: () {
                                                                deleteNetwork(
                                                                    elementNetwork);
                                                              },
                                                              child: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                                  .toList(),
                                              ...bytesPhoto
                                                  .map(
                                                    (elementBytes) => Stack(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                            fit: BoxFit.contain,
                                                            image: MemoryImage(
                                                              elementBytes!,
                                                            ),
                                                          )),
                                                          width:
                                                              double.infinity,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                        ),
                                                        Positioned(
                                                            right: 0,
                                                            child: InkWell(
                                                              onTap: () {
                                                                deleteByte(
                                                                    elementBytes);
                                                              },
                                                              child: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                                  .toList()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                      const SizedBox(height: 100),
                      _selectedActivity == null
                          ? SizedBox()
                          : Row(
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
                                      try {
                                        isLoading = true;
                                        setState(() {});
                                        
                                        var jsons = {
                                          'authKey': "key123",
                                          "activitiesId":
                                              _selectedActivity.toString(),
                                          "imageName": photoName,
                                          "imageBase64": base64Photo,
                                          "imageRemove": networkImageDelete,
                                        };
                                        int status = await _activityService
                                            .goToInsertDetailsImage(jsons);
                                        if (status == 200) {
                                          AwesomeDialog(
                                            width: checkConditionWidth(context),
                                            bodyHeaderDistance: 60,
                                            context: context,
                                            animType: AnimType.SCALE,
                                            dialogType: DialogType.SUCCES,
                                            body: const Center(
                                              child: Text(
                                                'Insert Successfully for details image.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            title: 'Successfully Insert',
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
                                                'Failed to insert details image',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            title: 'Failed',
                                            desc: '',
                                            btnOkOnPress: () {},
                                          ).show();
                                        }
                                        isLoading = false;
                                        setState(() {});
                                      } catch (e) {
                                        isLoading = false;
                                        setState(() {});
                                        print(e);
                                        AwesomeDialog(
                                          width: checkConditionWidth(context),
                                          bodyHeaderDistance: 60,
                                          context: context,
                                          animType: AnimType.SCALE,
                                          dialogType: DialogType.ERROR,
                                          body: const Center(
                                            child: Text(
                                              'Failed to insert details image',
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
    );
  }
}
