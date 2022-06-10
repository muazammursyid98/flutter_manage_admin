import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';

/// Example without a datasource
class AvailableDriversTable extends StatelessWidget {
  const AvailableDriversTable();

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
          DataTable2(
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
              rows: List<DataRow>.generate(
                  17,
                  (index) => DataRow(cells: [
                        const DataCell(CustomText(
                          text: "User Name",
                        )),
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
                      ]))),
        ],
      ),
    );
  }
}
