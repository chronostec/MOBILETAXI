import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/sales_model.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
class SalesDataSource extends DataGridSource {
  SalesDataSource({required List<Sales> sales}) {
    dataGridRows = sales
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'date',
                  value: ctlReport.chooseperiod.value == 1
                      ? DateFormat.yMMMd()
                              .format(DateTime.parse(dataGridRow.createdat))
                              .toString()
                              .toLowerCase() +
                          ' ' +
                          TimeOfDay.fromDateTime(
                                  DateTime.parse(dataGridRow.createdat))
                              .toString()
                              .substring(10, 15)
                      : DateFormat.yMMMd()
                          .format(ctlReport.correctDateTime(dataGridRow.createdat))
                          .toString()
                          .toLowerCase()),
              DataGridCell<String>(columnName: 'cars', value: dataGridRow.cars),
              DataGridCell<String>(
                  columnName: 'price', value: dataGridRow.price),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    // print('OK ' + row.getCells().first.columnName);
    return DataGridRowAdapter(
        cells: row
            .getCells()
            .map((datagridcell) => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  datagridcell.value.toString(), softWrap: true,
                  // overflow: TextOverflow.ellipsis,
                )))
            .toList());
  }
}
