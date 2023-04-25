import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/controllers.dart';
import '../../../constants/style.dart';
import '../../../controllers/transaction_controller.dart';
import '../../../model/transaction_model.dart';
import '../../../widgets/custom_text.dart';
import 'change_date.dart';

class DriversTable extends StatelessWidget {
  DriversTable();
  final TransactionController counterController =
      Get.put(TransactionController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...counterController.listActivity.value.map(
                        (element) {
                          List newListDisplay = counterController
                              .statusRepsonseDisplay.value
                              .where(((item) =>
                                  item.activityId == element.activityId))
                              .toList();

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: Text(element.activityName,
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                newListDisplay.isEmpty
                                    ? Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  5.0) //                 <--- border radius here
                                              ),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width: double.infinity,
                                        child: DataTable2(
                                          columnSpacing: 10,
                                          horizontalMargin: 12,
                                          minWidth: 1500,
                                          columns: const [
                                            DataColumn2(
                                              fixedWidth: 40,
                                              label: Text('Num'),
                                              size: ColumnSize.L,
                                            ),
                                            DataColumn2(
                                              fixedWidth: 100,
                                              label: Text('Order ID'),
                                              size: ColumnSize.L,
                                            ),
                                            DataColumn2(
                                              fixedWidth: 200,
                                              label: Text('Name'),
                                              size: ColumnSize.L,
                                            ),
                                            DataColumn2(
                                              fixedWidth: 200,
                                              label: Text('Phone Number'),
                                            ),
                                            DataColumn2(
                                              fixedWidth: 200,
                                              label: Text('Email'),
                                            ),
                                            DataColumn2(
                                              fixedWidth: 200,
                                              label: Text('Activity Name'),
                                            ),
                                            DataColumn(
                                              label: Text('Total Person'),
                                            ),
                                            DataColumn(
                                              label: Text('Total Price (RM)'),
                                            ),
                                            DataColumn(
                                              label: Text('Shift Slot'),
                                            ),
                                            DataColumn(
                                              label: Text('Status'),
                                            ),
                                            DataColumn(
                                              label: Text('Order Time'),
                                            ),
                                            DataColumn(
                                              label: Text('Change Date'),
                                            ),
                                          ],
                                          rows: const [
                                            DataRow(
                                              cells: [
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                // DataCell(Container(
                                                //   decoration: BoxDecoration(
                                                //       border: Border.all(color: active, width: 5),
                                                //       color: light,
                                                //       borderRadius: BorderRadius.circular(20)),
                                                //   padding: const EdgeInsets.symmetric(
                                                //       horizontal: 12, vertical: 6),
                                                //   child: const CustomText(
                                                //     text: "User Options",
                                                //   ),
                                                // )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                                DataCell(CustomText(
                                                  text: "N/A",
                                                )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  5.0) //                 <--- border radius here
                                              ),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width: double.infinity,
                                        child: DataTable2(
                                          columnSpacing: 10,
                                          horizontalMargin: 12,
                                          minWidth: 1800,
                                          columns: const [
                                            DataColumn2(
                                              fixedWidth: 40,
                                              label: Text('Num'),
                                              size: ColumnSize.L,
                                            ),
                                            DataColumn2(
                                              fixedWidth: 100,
                                              label: Text('Order ID'),
                                              size: ColumnSize.L,
                                            ),
                                            DataColumn2(
                                              fixedWidth: 200,
                                              label: Text('Name'),
                                              size: ColumnSize.L,
                                            ),
                                            DataColumn2(
                                              fixedWidth: 200,
                                              label: Text('Phone Number'),
                                            ),
                                            DataColumn2(
                                              fixedWidth: 200,
                                              label: Text('Email'),
                                            ),
                                            DataColumn2(
                                              fixedWidth: 200,
                                              label: Text('Activity Name'),
                                            ),
                                            DataColumn2(
                                              label: Text('Total Person'),
                                            ),
                                            DataColumn2(
                                              label: Text('Total Price (RM)'),
                                            ),
                                            DataColumn2(
                                              label: Text('Shift Slot'),
                                            ),
                                            DataColumn2(
                                              label: Text('Status'),
                                            ),
                                            DataColumn(
                                              label: Text('Order Time'),
                                            ),
                                            DataColumn(
                                              label: Text('Change Date'),
                                            ),
                                          ],
                                          rows: [
                                            ...newListDisplay
                                                .asMap()
                                                .map((i, element) => MapEntry(
                                                      i,
                                                      DataRow(
                                                        cells: [
                                                          DataCell(CustomText(
                                                            text: (i + 1)
                                                                .toString(),
                                                          )),
                                                          DataCell(CustomText(
                                                            text:
                                                                element.orderId,
                                                          )),
                                                          DataCell(CustomText(
                                                            text: element.name,
                                                          )),
                                                          DataCell(CustomText(
                                                            text: element
                                                                .phoneNumber,
                                                          )),
                                                          DataCell(CustomText(
                                                            text: element.email,
                                                          )),
                                                          DataCell(CustomText(
                                                            text: element
                                                                .activityName,
                                                          )),
                                                          DataCell(CustomText(
                                                            text: element
                                                                .totalBookedSlot,
                                                          )),
                                                          DataCell(CustomText(
                                                            text: double.parse(
                                                                    element
                                                                        .totalPrice)
                                                                .toStringAsFixed(
                                                                    2),
                                                          )),
                                                          DataCell(CustomText(
                                                            text: element
                                                                .shiftName,
                                                          )),
                                                          DataCell(
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Chip(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0),
                                                                  backgroundColor: element
                                                                              .statusId ==
                                                                          "Success"
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                                  label:
                                                                      CustomText(
                                                                    text: element
                                                                        .statusId,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          DataCell(CustomText(
                                                            text: DateFormat(
                                                                    'dd/MM/yyyy hh:mm a')
                                                                .format(element
                                                                    .createdDate),
                                                          )),
                                                          DataCell(
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) {
                                                                        return ChangeDateScreen(
                                                                          clientName: element
                                                                              .name
                                                                              .toString(),
                                                                          idOrder:
                                                                              element.registrantOrderId,
                                                                        );
                                                                      }).then((value) {});
                                                                },
                                                                child: const Text(
                                                                    "Change")),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                .values
                                                .toList()
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
