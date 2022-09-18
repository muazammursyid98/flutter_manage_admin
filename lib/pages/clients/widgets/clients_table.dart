import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dext_expenditure_dashboard/controllers/activity_controller.dart';
import 'package:dext_expenditure_dashboard/pages/clients/widgets/update_activity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/condition_size.dart';
import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';

class ClientsTable extends StatefulWidget {
  const ClientsTable({super.key});

  @override
  State<ClientsTable> createState() => _ClientsTableState();
}

class _ClientsTableState extends State<ClientsTable> {
  final ActivityController counterController = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => counterController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 1200,
                columns: const [
                    DataColumn2(
                      label: Text('Activity Name'),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('Registered Slot'),
                    ),
                    DataColumn(
                      label: Text('Location'),
                    ),
                    DataColumn(
                      label: Text('Image'),
                    ),
                    DataColumn(
                      label: Text('Price'),
                    ),
                    DataColumn(
                      label: Text('Action'),
                    ),
                  ],
                rows: [
                    ...counterController.statusRepsonseDisplay.map(
                      (element) => DataRow(
                        cells: [
                          DataCell(CustomText(
                            text: element.activityName,
                          )),
                          DataCell(CustomText(
                            text: element.activityAvailable ??= 'N/A',
                          )),
                          DataCell(CustomText(
                            text: element.activityLocation,
                          )),
                          DataCell(Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://rentasadventures.com/listActivityAsset/${element.activityAsset}',
                              ),
                            )),
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 4,
                          )),
                          DataCell(CustomText(
                            text:
                                'RM${double.parse(element.activityPrice).toStringAsFixed(2)}',
                          )),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return MyDialog(
                                            element: element,
                                          );
                                        }).then((value) {
                                      counterController.onInit();
                                    });
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                            width: checkConditionWidth(context),
                                            bodyHeaderDistance: 60,
                                            context: context,
                                            animType: AnimType.SCALE,
                                            dialogType: DialogType.WARNING,
                                            body: const Center(
                                              child: Text(
                                                'Are you sure want to delete ?',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            title: 'Are you sure? ',
                                            desc: '',
                                            btnOkText: 'Yes',
                                            btnOkOnPress: () async {
                                              var jsons = {
                                                "activityId": element.activityId
                                              };
                                              int statusResponse =
                                                  await counterController
                                                      .deleteTheActivity(jsons);
                                              if (statusResponse == 200) {
                                                AwesomeDialog(
                                                  width: checkConditionWidth(
                                                      context),
                                                  bodyHeaderDistance: 60,
                                                  context: context,
                                                  animType: AnimType.SCALE,
                                                  dialogType: DialogType.SUCCES,
                                                  body: const Center(
                                                    child: Text(
                                                      'Delete Successfully',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  title:
                                                      'Delete for ${element.activityName}',
                                                  desc: '',
                                                  btnOkOnPress: () {
                                                    counterController.onInit();
                                                  },
                                                ).show();
                                              } else {
                                                AwesomeDialog(
                                                  width: checkConditionWidth(
                                                      context),
                                                  bodyHeaderDistance: 60,
                                                  context: context,
                                                  animType: AnimType.SCALE,
                                                  dialogType: DialogType.ERROR,
                                                  body: const Center(
                                                    child: Text(
                                                      'Failed to update',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  title: 'Failed',
                                                  desc: '',
                                                  btnOkOnPress: () {
                                                    counterController.onInit();
                                                  },
                                                ).show();
                                              }
                                            },
                                            btnCancelText: 'No',
                                            btnCancelOnPress: () {})
                                        .show();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
      ),
    );
  }
}
