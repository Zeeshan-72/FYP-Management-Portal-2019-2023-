// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_application_1/convenor_screens/pdf_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

// import 'package:pdf/widgets.dart';
import 'package:universal_html/html.dart';

class PDF extends StatefulWidget {
  const PDF({Key? key}) : super(key: key);

  @override
  State<PDF> createState() => _PDFState();
}

class _PDFState extends State<PDF> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    final pdfFile = await PdfApi.generateTable();

                    PdfApi.openFile(pdfFile);
                  },
                  child: Text('Generate Tables')))
        ],
      ),
    );
  }
}













// class PDFApi {
//   static Future<File> generateTable() async{

//     final pdf  = Document();

//     return saveDocument(name: 'notification.pdf', pdf: pdf);
//   }
  
//   static Future<File> saveDocument({required String name, required Document pdf}) async {

//     final bytes = await pdf.save();

//     final dir = await getApplicationDocumentDirectory();



//   }
// }
