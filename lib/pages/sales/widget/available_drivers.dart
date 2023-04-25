import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:dext_expenditure_dashboard/model/expenditure_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../constants/globals.dart' as global;

import '../../../constants/style.dart';
import '../../../controller/expenditure_controller.dart';
import '../../../controllers/users_controller.dart';
import '../../../widgets/custom_text.dart';

/// Example without a datasource
class AvailableDriversTable extends StatefulWidget {
  @override
  State<AvailableDriversTable> createState() => _AvailableDriversTableState();
}

class _AvailableDriversTableState extends State<AvailableDriversTable> {
  // AvailableDriversTable({Key? key}) : super(key: key);
  final ExpenditureController _expenditureController = ExpenditureController();

  int userId = global.userId;

  Future<Expenditure?> getexpenditure() async {
    final expenditure = await _expenditureController.getExpenditures();

    return expenditure;
  }

  final UsersController counterController = Get.put(UsersController());

  Widget build(BuildContext context) {
    /*Future<Expenditure?> exp = _expenditureController.getUncompleteExpenditure(
      "stage",
      '"pending"',
      "stage",
      '"approved"',
      "requester",
      userId.toString(),
    ); */

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            const SizedBox(
              width: 10,
            ),
            CustomText(
              text: "Top of Users Purchased Ticket",
              color: lightGrey,
              weight: FontWeight.bold,
            )
          ]),
          Expanded(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.55),
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
                              label: Text('Name'),
                              size: ColumnSize.L,
                            ),
                            DataColumn(
                              label: Text('Phone Number'),
                            ),
                            DataColumn(
                              label: Text('Email'),
                            ),
                            DataColumn(
                              label: Text('Purchased Count'),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                              counterController
                                  .statusRepsonseDisplay.value.length, (index) {
                            final item =
                                counterController.statusRepsonseDisplay[index];
                            return DataRow(
                              cells: [
                                DataCell(CustomText(text: item.name)),
                                DataCell(CustomText(
                                  text: item.phoneNumber,
                                )),
                                DataCell(Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // const Icon(Icons.star,
                                    //     color: Colors.deepOrange,
                                    //     size: 18),
                                    // const SizedBox(width: 5),
                                    CustomText(text: item.email),
                                  ],
                                )),
                                DataCell(Container(
                                  /* decoration: BoxDecoration(
                                  border: Border.all(color: active, width: 5),
                                  color: light,
                                  borderRadius: BorderRadius.circular(20)), */
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: CustomText(
                                    text: item.count,
                                  ),
                                )),
                              ],
                            );
                          }),
                        ),
                )),
          ),
        ],
      ),
    );
  }
}

Color colorCode(String stage) {
  Color color;
  if (stage == "pending") {
    color = const Color.fromARGB(255, 216, 102, 9);
  } else if (stage == "approved") {
    color = const Color.fromARGB(255, 231, 228, 10);
  } else {
    color = const Color.fromARGB(255, 18, 177, 18);
  }
  return color;
}


/* 


rows: List<DataRow>.generate(_dessertsDataSource.rowCount,
                      (index) => _dessertsDataSource.getRow(index))),



 */