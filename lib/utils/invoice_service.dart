import 'dart:io';
import 'dart:typed_data';
import 'package:drift/drift.dart';
import 'package:get/get.dart';
// import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:pdf/widgets.dart' as pw;

import '../controllers/controllers.dart';
import '../models/models.dart';

class TableRow {
  final String prodLabel;
  final String prodPrice;
  final String prodQuantity;
  final String prodTotal;

  TableRow(this.prodLabel, this.prodPrice, this.prodQuantity, this.prodTotal);
}

class InvoiceService {
  InvoiceService(this.soldproducts);
  late final CartController controller = Get.find();
  final List<Product> soldproducts;

  static Future<Uint8List> createInvoice(List<Product> soldproducts) {
    final pdf = pw.Document();
    // final List<TableRow> elements = [
    //   TableRow('Label', 'Price', 'Quantity', 'Total'),
    //   for (var product in soldProducts) {
    //      TableRow('${product.label}', '${product.price}', '${product.quantity}', '${(product.price * product.quantity)}')
    //      TableRow('Total', '', '', product.total)
    //   }
    // ];
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(child: pw.Text('Holla el mundo'));
        },
      ),
    );
    return pdf.save();
  }

  Future<void> savePdf(String filename, Uint8List bytes) async {
    final output = await getTemporaryDirectory();
    var filePath = '${output.path}/$filename.pdf';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    // await OpenDocument.openDocument(filePath: filePath);
  }
}
