import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class CustomDatatable extends StatelessWidget {
  final List<DataColumn2> columns;
  final List<DataRow2> rows;
  final double? headingRowHeight;
  final double? dataRowHeight;
  const CustomDatatable({super.key, required this.columns, required this.rows, this.headingRowHeight, this.dataRowHeight});

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      border: TableBorder.all(color: Colors.black, width: .5),
      columnSpacing: 0,
      horizontalMargin: 0,
      headingRowHeight: headingRowHeight??40,
      dataRowHeight: dataRowHeight??40,
      headingRowColor: WidgetStatePropertyAll(Colors.blue.shade100),
      headingTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      columns: columns,
      rows: rows,
    );
  }
}
