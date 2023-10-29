// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';

class FinalInternalEvaluatorList extends StatelessWidget {
  const FinalInternalEvaluatorList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                "/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups")
            .orderBy(
              "fyp-id",
            )
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return Center(
                child: Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "No groups allocated yet! ",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ));
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: SafeArea(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              padding: EdgeInsets.only(top: 30, left: 25),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Internal Evaluators',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              fontSize: 20, fontWeight: FontWeight.w800)),
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              _createPDF();
                            },
                            icon: Icon(
                              Icons.print_sharp,
                              size: 20,
                            ),
                            label: Text('Print',
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600))),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Container(
                      // decoration: BoxDecoration(
                      //     color: Color.fromARGB(255, 252, 252, 252)),
                      child: DataTable(
                        columnSpacing: 50.0,
                        border: TableBorder.all(color: Colors.grey, width: 1),
                        columns: [
                          DataColumn(
                              label: Text("FYP ID",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),
                          DataColumn(
                              label: Text("Supervisor",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),
                          DataColumn(
                              label: Text("Evaluator 1",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),
                          DataColumn(
                              label: Text("Evaluator 2",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),
                          DataColumn(
                              label: Text("Project Title",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),
                        ],
                        rows: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          return DataRow(
                            cells: [
                              DataCell(Container(
                                width: 70,
                                child: Text(document['fyp-id'],
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              )),
                              DataCell(Container(
                                width: 100,
                                child: Text(document['main-supervisor'],
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              )),
                              DataCell(
                                Container(
                                  width: 100,
                                  child: Text(document['8-evaluator1'],
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                              DataCell(
                                Container(
                                  width: 100,
                                  child: Text(document['8-evaluator2'],
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      )),
                                ),
                              ),
                              DataCell(
                                Text(document['accepted-idea'],
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
        });
  }

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  _createPDF() async {
    String getCurrentDate() {
      var date = DateTime.now().toString();

      var dateParse = DateTime.parse(date);

      var formattedDate =
          "${dateParse.day}-${dateParse.month}-${dateParse.year}";
      return formattedDate.toString();
    }

    final FirebaseFirestore _db = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await _db
        .collection(
            "/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups")
        .orderBy('fyp-id')
        .get();
    List<DocumentSnapshot> documents = snapshot.docs;

    final doc = pw.Document();

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin:
                const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
            child: pw.Column(children: [
              pw.Text(
                'National Textile University, Faisalabad',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Text(
                'Department of Computer Science',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Text(
                  'BSIT Final Year Project (FYP) Internal Evaluation notification (Tentative*)',
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(
                height: 30,
              ),
              pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(1),
                    2: pw.FlexColumnWidth(1),
                    3: pw.FlexColumnWidth(2),
                  },
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
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
                              'Reg No',
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
                              'Evaluators',
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
                              'Project title',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ]),
                    for (var i = 0; i < 14; i++) ...[
                      pw.TableRow(children: [
                        pw.Column(children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.all(6.0),
                            alignment: pw.Alignment.center,
                            child: pw.Center(
                              child: pw.Text(
                                documents[i]['fyp-id'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
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
                                  documents[i]['regno1'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                                pw.Text(
                                  documents[i]['regno2'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                                pw.Text(
                                  documents[i]['regno3'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                              ]),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.all(6.0),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  documents[i]['8-evaluator1'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                                pw.SizedBox(height: 1),
                                pw.Text(
                                  documents[i]['8-evaluator2'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                              ]),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.all(6.0),
                          child: pw.Text(
                            documents[i]['accepted-idea'],
                            style: const pw.TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
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
                    pw.Text('Shahbaz Ahmad Sahi',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    pw.Text('Convener, BSIT, FYP Committee',
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
                  _createPDF();
                },
                child: const Text("Print"))
          ],
        ),
      ),
    );
  }
}
