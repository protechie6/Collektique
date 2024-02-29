import 'package:flutter/material.dart';
import 'package:watch_vault/models/serial_check_model.dart';

class SerialCheckDataSource extends DataTableSource{

  final List<SerialCheckModel> docs;

  SerialCheckDataSource({
    required this.docs,
  });


  @override
  DataRow? getRow(int index) {

    return DataRow(cells: [
      DataCell(Text(docs[index].year,
      style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.5 /*PERCENT not supported*/
                            ))),
      DataCell(Text(docs[index].serialNumber,
      style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.5 /*PERCENT not supported*/
                            ))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => docs.length;

  @override
  int get selectedRowCount => 0;

} 