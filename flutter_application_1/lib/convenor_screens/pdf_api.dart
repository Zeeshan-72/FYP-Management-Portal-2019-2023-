import 'dart:io';

import 'package:flutter/material.dart';

import 'package:open_file_plus/open_file_plus.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfApi {
  static Future<File> generateTable() async {
    final pdf = pw.Document();
    final headers = ['Name', 'Age'];
    final data = ['Zeeshan', '22'];

    pdf.addPage(pw.Page(
        build: (Context) => pw.Text(
              'Zeeshan JAVED',
              style: pw.TextStyle(
                fontSize: 10.0,
                fontWeight: pw.FontWeight.bold,
              ),
            )));

    return saveDocument(name: 'notification.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required pw.Document pdf}) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
