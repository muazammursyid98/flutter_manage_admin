import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:dext_expenditure_dashboard/model/expenditure_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../constants/globals.dart' as global;

import '../../../constants/style.dart';
import '../../../controller/expenditure_controller.dart';
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
              text: "Requests",
              color: lightGrey,
              weight: FontWeight.bold,
            )
          ]),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.51),
              child: FutureBuilder(
                future: _expenditureController.getExpenditures(
                    /* 
                  "stage",
                  '"pending"',
                  "stage",
                  '"approved"',
                  "requester",
                  userId.toString(), */
                    ),
                builder: (context, snapshot) {
                  //Checks if data is available
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data == null) {
                    return const Text(
                      'Something went Wrong',
                      style: TextStyle(fontSize: 30),
                    );
                  }

                  Expenditure expenditure = snapshot.data as Expenditure;

                  return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                            child: DataTable2(
                                columnSpacing: 12,
                                horizontalMargin: 12,
                                minWidth: 600,
                                columns: const [
                                  DataColumn2(
                                    label: Text('Name'),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn(
                                    label: Text('Purpose'),
                                  ),
                                  DataColumn(
                                    label: Text('Stage'),
                                  ),
                                  DataColumn(
                                    label: Text('Amount'),
                                  ),
                                ],
                                rows:
                                    /*  List<DataRow>.generate(getexpenditure().
                            (index) => _dessertsDataSource.getRow(index))), */

                                    List<DataRow>.generate(
                                        expenditure.data!.length,
                                        (index) => DataRow(cells: [
                                              const DataCell(CustomText(
                                                  text: "User Name")),
                                              DataCell(CustomText(
                                                text: expenditure
                                                    .data![index].purpose!,
                                              )),
                                              DataCell(Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(Icons.star,
                                                      color: Colors.deepOrange,
                                                      size: 18),
                                                  const SizedBox(width: 5),
                                                  CustomText(
                                                      text: expenditure
                                                          .data![index].stage!),
                                                ],
                                              )),
                                              DataCell(Container(
                                                /* decoration: BoxDecoration(
                                    border: Border.all(color: active, width: 5),
                                    color: light,
                                    borderRadius: BorderRadius.circular(20)), */
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                child: CustomText(
                                                  text: expenditure
                                                      .data![index].amount!,
                                                ),
                                              )),
                                            ]))));

                        /* ListTile(
                          leading: Icon(
                            Icons.monetization_on,
                            color: colorCode(expenditure.data![index].stage!),
                          ),
                          trailing: Text(
                            expenditure.data![index].amount!,
                            style: const TextStyle(
                                color: Colors.green, fontSize: 15),
                          ),
                          title: Text(
                            expenditure.data![index].purpose!,
                          ),
                          onTap: () {
                            /* 
                                                    int tappedIndex = int.parse(
                                                        expenditure
                                                            .data![index].id);
            
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) => details(
                                                          context,
                                                          tappedIndex,
                                                          userId),
                                                    )); */
                          },
                        ); */
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                            height: 5,
                          ),
                      itemCount: 1);
                },

                /*  child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: Text('Name'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('Purpose'),
                      ),
                      DataColumn(
                        label: Text('Stage'),
                      ),
                      DataColumn(
                        label: Text('Amount'),
                      ),
                    ],
                    rows: 
                        /*  List<DataRow>.generate(getexpenditure().
                            (index) => _dessertsDataSource.getRow(index))), */
              
                        List<DataRow>.generate(
                            17,
                            (index) => DataRow(cells: [
                                  const DataCell(CustomText(text: "User Name")),
                                  const DataCell(CustomText(
                                    text: "Lorem Ipsum Loret Lorem Ipsum Loret",
                                  )),
                                  DataCell(Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.star,
                                          color: Colors.deepOrange, size: 18),
                                      SizedBox(width: 5),
                                      CustomText(text: "Pending"),
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
                                      text: " ${index}432${index + 2}",
                                    ),
                                  )),
                                ]))), */
              ),
            ),
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