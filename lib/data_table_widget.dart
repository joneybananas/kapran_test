import 'dart:developer';

import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final Map<String, Map<String, dynamic>> data;

  const DataTableWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<String> columns = data.values.first.keys.toList();
    List<String> rows = data.keys.toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: columns.map((col) => DataColumn(label: Text(col))).toList(),
          rows: rows.map((row) {
            return DataRow(
              cells: columns.map((col) {
                return DataCell(Text(data[row]?[col]?.toString() ?? ''));
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
