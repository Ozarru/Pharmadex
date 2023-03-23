// import 'package:flutter/material.dart';

// class ProdsTable extends StatefulWidget {
//   const ProdsTable({Key? key}) : super(key: key);

//   @override
//   State<ProdsTable> createState() => _ProdsTableState();
// }

// class _ProdsTableState extends State<ProdsTable> {
//   late List<Product> prods;
//   int? sortIndex;

//   @override
//   void initState() {
//     super.initState();
//     prods = List.of(testProducts);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(child: buildDataTable());
//   }

//   Widget buildDataTable() {
//     final columns = [
//       'SKU',
//       'Label',
//       'Net Cost',
//       'Net Price',
//       'Date Added',
//       'Favorite'
//     ];
//     return DataTable(columns: getColumns(columns), rows: getRows(prods));
//   }

//   List<DataColumn> getColumns(List<String> columns) {
//     return columns.map((column) => DataColumn(label: Text(column))).toList();
//   }

//   List<DataCell> getCells(List<dynamic> cells) {
//     return cells.map((data) => DataCell(Text('$data'))).toList();
//   }

//   List<DataRow> getRows(List<Product> prods) => prods.map((Product product) {
//         final cells = [
//           product.sku,
//           product.label,
//           product.netCost,
//           product.netPrice,
//           product.dateIn,
//           product.isFav,
//         ];
//         return DataRow(cells: getCells(cells));
//       }).toList();
// }
