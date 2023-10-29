import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file_plus/open_file_plus.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

var firebaseUser = FirebaseAuth.instance.currentUser;
String get path => ConvenorPath(firebaseUser!.uid);
String get section => ConvenorPath(firebaseUser!.uid);
ConvenorPath(String value) {
  String path = '';
  String section;
  if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
    return [
      path = '/Convenor/classes/BS Information Technology/groups/group-members',
      'BSITT'
    ];
  } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
    return path = '/Convenor/classes/BS Computer Science/groups/group-members';
  } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
    return path =
        '/Convenor/classes/BS Software Engineering/groups/group-members';
  } else {
    return null;
  }
}

Convenorclass(String value) {
  String section = '';
  if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
    return section = 'BSIT';
  } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
    return section = 'BSCS';
  } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
    return section = 'BSSE';
  } else {
    return null;
  }
}

Convenorname(String value) {
  String convenorname = '';
  if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
    return convenorname = 'Shahbaz Ahmad Sahi';
  } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
    return convenorname = 'Haseeb Ahmad';
  } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
    return convenorname = 'Muhammad Shahid';
  } else {
    return null;
  }
}

final Stream<QuerySnapshot> studentsStream =
    FirebaseFirestore.instance.collection(path).snapshots();

class _PDFScreenState extends State<PDFScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: studentsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print('Something went Wrong');
                  }

                  final List storedocs = [];
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map a = document.data() as Map<String, dynamic>;
                    storedocs.add(a);
                    a['id'] = document.id;
                  }).toList();

                  return _createPDF(storedocs);
                })));
  }
}

_createPDF(List value) {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection(path).snapshots();

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  final doc = pw.Document();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          margin: const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
          child: pw.Column(children: [
            pw.Text(
              'National Textile Univeristy, Faisalabad',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text(
              'Department of Computer Science',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text(
                'CCC, Final Year Project (FYP) supervisory committee notification (Tentative*)',
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(
              height: 30,
            ),
            pw.Table(
                border: pw.TableBorder.all(),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(children: [
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'FYP ID',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Main Supervisor',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Co-Supervisor',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Name',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Reg No',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
                  for (var i = 0; i < value.length; i++) ...[
                    pw.TableRow(children: [
                      pw.Column(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6.0),
                          alignment: pw.Alignment.center,
                          child: pw.Center(
                            child: pw.Text(
                              value[i]['fyp-id'],
                              // value[i]['fyp-id'],
                              style: const pw.TextStyle(
                                fontSize: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6.0),
                          alignment: pw.Alignment.center,
                          child: pw.Center(
                            child: pw.Text(
                              value[i]['main-supervisor'],
                              style: const pw.TextStyle(
                                fontSize: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6.0),
                          child: pw.Text(
                            value[i]['main-supervisor'],
                            style: const pw.TextStyle(
                              fontSize: 8.0,
                            ),
                          ),
                        ),
                      ]),
                      pw.Container(
                        padding: pw.EdgeInsets.all(6.0),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                value[i]['mem1'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                value[i]['mem2'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                value[i]['mem3'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              )
                            ]),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(6.0),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                value[i]['regno1'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                value[i]['regno2'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                value[i]['regno3'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                            ]),
                      )
                    ]),
                  ]
                ]),
            pw.SizedBox(height: 30),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Dated: ${getCurrentDate()}',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 10)),
                pw.Column(children: [
                  pw.Text('Shahabaz Ahmad Sahi',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 10)),
                  pw.Text('Convener, Information Technology, FYP Committee',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 10)),
                ])
              ],
            )
          ]),
        ); // Center
      }));

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());

  return SafeArea(
    child: Center(
      child: Column(
        children: [
          const Text('zeeshan'),
          ElevatedButton(
              onPressed: () {
                _createPDF(value);
              },
              child: const Text("Print"))
        ],
      ),
    ),
  );
}
