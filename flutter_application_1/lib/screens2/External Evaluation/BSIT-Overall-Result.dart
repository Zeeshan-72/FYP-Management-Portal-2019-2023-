// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io' as io;
import 'dart:async';

import 'package:universal_html/html.dart' show AnchorElement;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as ios;
import 'dart:convert';

class BSITOverallResults extends StatefulWidget {
  @override
  _BSITOverallResultsState createState() => _BSITOverallResultsState();
}

class _BSITOverallResultsState extends State<BSITOverallResults> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  var snap;
  var results2;
  var mem1_result;
  var mem2_result;
  var mem3_result;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collectionGroup('8-Internal-Evaluation')
            .orderBy('fyp-id')
            // .where('fyp-id', isEqualTo: '23-FYP-301')
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
                    "No group evaluated yet! ",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ));
          }
          // length = snapshot.data!.docs.length;
          return SafeArea(
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 30,
                        ),
                        child: Text('Marks Sheet',
                            style: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 30,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 13),
                              ),
                              onPressed: GroupwiseResult,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Export Results',
                                    style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.download_sharp,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 30,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 13),
                              ),
                              onPressed: createExcel,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Print',
                                    style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.download_sharp,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot groupdocument =
                          snapshot.data!.docs[index];

                      bool isFieldEmpty2 = groupdocument['regno2'] == null ||
                          groupdocument['regno2'] == '';
                      bool isFieldEmpty3 = groupdocument['regno3'] == null ||
                          groupdocument['regno3'] == '';

                      var total_marks_mem1 =
                          groupdocument['supervisor_mem1'].round() +
                              groupdocument['internal_mem1'].round() +
                              groupdocument['external-results-mem1'].round();

                      var total_marks_mem2 =
                          groupdocument['supervisor_mem2'].round() +
                              groupdocument['internal_mem2'].round() +
                              groupdocument['external-results-mem2'].round();

                      var total_marks_mem3 =
                          groupdocument['supervisor_mem3'].round() +
                              groupdocument['internal_mem3'].round() +
                              groupdocument['external-results-mem3'].round();

                      String getGrade(int totalMarks) {
                        if (totalMarks >= 90) {
                          return 'A+';
                        } else if (totalMarks >= 85) {
                          return 'A';
                        } else if (totalMarks >= 80) {
                          return 'A-';
                        } else if (totalMarks >= 75) {
                          return 'B+';
                        } else if (totalMarks >= 71) {
                          return 'B';
                        } else if (totalMarks >= 68) {
                          return 'B-';
                        } else if (totalMarks >= 64) {
                          return 'C+';
                        } else if (totalMarks >= 61) {
                          return 'C';
                        } else if (totalMarks >= 58) {
                          return 'C-';
                        } else if (totalMarks >= 54) {
                          return 'D+';
                        } else if (totalMarks >= 50) {
                          return 'D';
                        } else {
                          return 'F';
                        }
                      }

                      String gradeMem1 = getGrade(total_marks_mem1);
                      String gradeMem2 = getGrade(total_marks_mem2);
                      String gradeMem3 = getGrade(total_marks_mem3);

                      return Column(
                        children: [
                          Container(
                            height: 300,
                            margin: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 35),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 3),
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              'FYP id ',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                groupdocument['fyp-id'],
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              'Supervisor ',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              groupdocument['main-supervisor'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              'Title',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                groupdocument['accepted-idea'],
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  DataTable(
                                    // border: Border.all(1),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        "Sr No.",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Student Name",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Student Reg No.",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Supervisor (40%)",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Internal (30%)",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "External (30%)",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Total",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Grade",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text(
                                          '1',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )),
                                        DataCell(Text(
                                          groupdocument['mem1'],
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )),
                                        DataCell(Text(
                                          groupdocument['regno1'],
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )),
                                        DataCell(Text(
                                            groupdocument['supervisor_mem1']
                                                .toStringAsFixed(0))),
                                        DataCell(Text(
                                            groupdocument['internal_mem1']
                                                .toStringAsFixed(0))),
                                        DataCell(
                                          Text(
                                            groupdocument['external-results-mem1'] ==
                                                        null ||
                                                    groupdocument[
                                                            'external-results-mem1'] ==
                                                        0
                                                ? '-'
                                                : groupdocument[
                                                        'external-results-mem1']
                                                    .toStringAsFixed(0),
                                          ),
                                        ),
                                        DataCell(Text('$total_marks_mem1')),
                                        DataCell(
                                          Text(
                                            groupdocument['external-results-mem1'] ==
                                                        null ||
                                                    groupdocument[
                                                            'external-results-mem1'] ==
                                                        0
                                                ? 'Pending'
                                                : '$gradeMem1',
                                          ),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty2,
                                          child: Text(
                                            '2',
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty2,
                                          child: Text(
                                            groupdocument['mem2'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty2,
                                          child: Text(
                                            groupdocument['regno2'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                        DataCell(Visibility(
                                            visible: !isFieldEmpty2,
                                            child: Text(
                                                groupdocument['supervisor_mem2']
                                                    .toStringAsFixed(0)))),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty2,
                                          child: Visibility(
                                            visible: !isFieldEmpty2,
                                            child: Visibility(
                                                visible: !isFieldEmpty2,
                                                child: Text(groupdocument[
                                                        'internal_mem2']
                                                    .toStringAsFixed(0))),
                                          ),
                                        )),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty2,
                                          child: Text(
                                            groupdocument['external-results-mem2'] ==
                                                        null ||
                                                    groupdocument[
                                                            'external-results-mem2'] ==
                                                        0
                                                ? '-'
                                                : '${groupdocument['external-results-mem2'].toStringAsFixed(0)}',
                                          ),
                                        )),
                                        DataCell(Visibility(
                                            visible: !isFieldEmpty2,
                                            child: Text('$total_marks_mem2'))),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty2,
                                          child: Text(
                                            groupdocument['external-results-mem2'] ==
                                                        null ||
                                                    groupdocument[
                                                            'external-results-mem2'] ==
                                                        0
                                                ? 'Pending'
                                                : '$gradeMem2',
                                          ),
                                        )),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty3,
                                          child: Text(
                                            '3',
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty3,
                                          child: Text(
                                            groupdocument['mem3'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty3,
                                          child: Text(
                                            groupdocument['regno3'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                        DataCell(Visibility(
                                            visible: !isFieldEmpty3,
                                            child: Text(
                                                groupdocument['supervisor_mem3']
                                                    .toStringAsFixed(0)))),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty3,
                                          child: Text(
                                              groupdocument['internal_mem3']
                                                  .toStringAsFixed(0)),
                                        )),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty3,
                                          child: Text(
                                            groupdocument['external-results-mem3'] ==
                                                        null ||
                                                    groupdocument[
                                                            'external-results-mem3'] ==
                                                        0
                                                ? '-'
                                                : '${groupdocument['external-results-mem3'].toStringAsFixed(0)}',
                                          ),
                                        )),
                                        DataCell(Visibility(
                                            visible: !isFieldEmpty3,
                                            child: Text('$total_marks_mem3'))),
                                        DataCell(Visibility(
                                          visible: !isFieldEmpty3,
                                          child: Text(
                                            groupdocument['external-results-mem3'] ==
                                                        null ||
                                                    groupdocument[
                                                            'external-results-mem3'] ==
                                                        0
                                                ? 'Pending'
                                                : '$gradeMem3',
                                          ),
                                        )),
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )),
                ]),
          );
        },
      ),
    );
  }

  static Future<void> GroupwiseResult() async {
    final evenColor = "#9CC2E5";
    final oddColor = "#FFFFFF";

    final QuerySnapshot<Object?> querySnapshot = await FirebaseFirestore
        .instance
        .collection(
            '/Convenor/classes/BS Information Technology/groups/8-Internal-Evaluation')
        .orderBy('fyp-id')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final List<DocumentSnapshot<Object?>> supervisorDocuments =
          querySnapshot.docs;

      final ios.Workbook workbook = ios.Workbook();
      final ios.Worksheet sheet = workbook.worksheets[0];
      int rowIndex = 6; // Start from row 6

      for (int i = 0; i < supervisorDocuments.length; i++) {
        final DocumentSnapshot<Object?> supervisorDocument =
            supervisorDocuments[i];
        Map<String, dynamic>? supervisorData =
            supervisorDocument.data() as Map<String, dynamic>?;

        if (supervisorData != null) {
          // var results = supervisorData['group-intro'] +
          //     supervisorData['group-SRS'] +
          //     supervisorData['group-design'] +
          //     supervisorData['group-objectives'] +
          //     supervisorData['group-GUI'] +
          //     supervisorData['group-security'] +
          //     supervisorData['group-testing'] +
          //     supervisorData['group-video'];

          // var results_mem1 = supervisorData['group-intro'] +
          //     supervisorData['group-SRS'] +
          //     supervisorData['group-design'] +
          //     supervisorData['group-objectives'] +
          //     supervisorData['group-GUI'] +
          //     supervisorData['group-security'] +
          //     supervisorData['group-testing'] +
          //     supervisorData['group-video'] +
          //     supervisorData['individual-code-understanding-mem1'] +
          //     supervisorData['individual-presentation-mem1'] +
          //     supervisorData['overall-attendance-mem1'];

          // var results_mem2 = supervisorData['group-intro'] +
          //     supervisorData['group-SRS'] +
          //     supervisorData['group-design'] +
          //     supervisorData['group-objectives'] +
          //     supervisorData['group-GUI'] +
          //     supervisorData['group-security'] +
          //     supervisorData['group-testing'] +
          //     supervisorData['group-video'] +
          //     supervisorData['individual-code-understanding-mem2'] +
          //     supervisorData['individual-presentation-mem2'] +
          //     supervisorData['overall-attendance-mem2'];

          // var results_mem3 = supervisorData['group-intro'] +
          //     supervisorData['group-SRS'] +
          //     supervisorData['group-design'] +
          //     supervisorData['group-objectives'] +
          //     supervisorData['group-GUI'] +
          //     supervisorData['group-security'] +
          //     supervisorData['group-testing'] +
          //     supervisorData['group-video'] +
          //     supervisorData['individual-code-understanding-mem3'] +
          //     supervisorData['individual-presentation-mem3'] +
          //     supervisorData['overall-attendance-mem3'];

          // double mid_percentage_mem1 = (40 / 100) * results_mem1;
          // double mid_percentage_mem2 = (40 / 100) * results_mem2;
          // double mid_percentage_mem3 = (40 / 100) * results_mem3;

          ios.Range range = sheet.getRangeByName('A$rowIndex:K$rowIndex');

          range.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;

          ios.Range range2 =
              sheet.getRangeByName('A${rowIndex + 1}:K${rowIndex + 1}');

          range2.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;

          ios.Range range3 =
              sheet.getRangeByName('A${rowIndex + 2}:K${rowIndex + 2}');

          range3.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;

          // range.cellStyle.borders.all.color = '#0000000';

          if (rowIndex % 2 == 0) {
            sheet.getRangeByName('A$rowIndex:K$rowIndex').cellStyle.backColor =
                evenColor;
          } else {
            sheet.getRangeByName('A$rowIndex:K$rowIndex').cellStyle.backColor =
                oddColor;
          }

          if (rowIndex % 2 == 0) {
            sheet
                .getRangeByName('A${rowIndex + 1}:K${rowIndex + 1}')
                .cellStyle
                .backColor = evenColor;
          } else {
            sheet
                .getRangeByName('A${rowIndex + 1}:K${rowIndex + 1}')
                .cellStyle
                .backColor = oddColor;
          }

          if (rowIndex % 2 == 0) {
            sheet
                .getRangeByName('A${rowIndex + 2}:K${rowIndex + 2}')
                .cellStyle
                .backColor = evenColor;
          } else {
            sheet
                .getRangeByName('A${rowIndex + 2}:K${rowIndex + 2}')
                .cellStyle
                .backColor = oddColor;
          }

          // Merge and format cells
          sheet.getRangeByName('A$rowIndex:A${rowIndex + 2}').merge();
          sheet.getRangeByName('A$rowIndex').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('A$rowIndex').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('B$rowIndex:B${rowIndex + 2}').merge();
          sheet.getRangeByName('B$rowIndex').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('B$rowIndex').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('C$rowIndex:C${rowIndex + 2}').merge();
          sheet.getRangeByName('C$rowIndex').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('C$rowIndex').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('D$rowIndex:D${rowIndex + 2}').merge();
          sheet.getRangeByName('D$rowIndex').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('D$rowIndex').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('E$rowIndex:E${rowIndex + 2}').merge();

          sheet.getRangeByName('E$rowIndex').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('E$rowIndex').cellStyle.vAlign =
              ios.VAlignType.center;

          sheet.getRangeByName('F$rowIndex').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('F${rowIndex + 1}').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('F${rowIndex + 1}').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('G$rowIndex').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('G$rowIndex').cellStyle.vAlign =
              ios.VAlignType.center;

          sheet.getRangeByName('G${rowIndex + 1}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('G${rowIndex + 1}').cellStyle.vAlign =
              ios.VAlignType.center;

          sheet.getRangeByName('G${rowIndex + 2}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('G${rowIndex + 2}').cellStyle.vAlign =
              ios.VAlignType.center;

          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('F${rowIndex}:F${rowIndex + 2}').merge();
          } else if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('F${rowIndex + 1}:F${rowIndex + 2}').merge();
          } else {}

          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('G${rowIndex}:G${rowIndex + 2}').merge();
          } else if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('G${rowIndex + 1}:G${rowIndex + 2}').merge();
          } else {}

          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('H${rowIndex}:H${rowIndex + 2}').merge();
          } else if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('H${rowIndex + 1}:H${rowIndex + 2}').merge();
          } else {}

          sheet.getRangeByName('H${rowIndex}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('H${rowIndex}').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('H${rowIndex + 1}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('H${rowIndex + 1}').cellStyle.vAlign =
              ios.VAlignType.center;

          sheet.getRangeByName('H${rowIndex + 2}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('H${rowIndex + 2}').cellStyle.vAlign =
              ios.VAlignType.center;

          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('I${rowIndex}:I${rowIndex + 2}').merge();
          } else if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('I${rowIndex + 1}:I${rowIndex + 2}').merge();
          } else {}

          sheet.getRangeByName('I${rowIndex + 2}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('I${rowIndex + 1}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('I${rowIndex}').cellStyle.hAlign =
              ios.HAlignType.center;

          sheet.getRangeByName('I${rowIndex + 2}').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('I${rowIndex + 1}').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('I${rowIndex}').cellStyle.vAlign =
              ios.VAlignType.center;

          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('J${rowIndex}:J${rowIndex + 2}').merge();
          } else if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('J${rowIndex + 1}:J${rowIndex + 2}').merge();
          } else {}
          sheet.getRangeByName('J${rowIndex + 2}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('J${rowIndex + 1}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('J${rowIndex}').cellStyle.hAlign =
              ios.HAlignType.center;

          sheet.getRangeByName('J${rowIndex + 2}').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('J${rowIndex + 1}').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('J${rowIndex}').cellStyle.vAlign =
              ios.VAlignType.center;
          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('K${rowIndex}:K${rowIndex + 2}').merge();
          } else if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('K${rowIndex + 1}:K${rowIndex + 2}').merge();
          } else {}

          sheet.getRangeByName('K${rowIndex + 2}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('K${rowIndex + 1}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('K${rowIndex}').cellStyle.hAlign =
              ios.HAlignType.center;

          sheet.getRangeByName('K${rowIndex + 2}').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('K${rowIndex + 1}').cellStyle.vAlign =
              ios.VAlignType.center;
          sheet.getRangeByName('K${rowIndex}').cellStyle.vAlign =
              ios.VAlignType.center;

          // Set data from supervisorData in Excel cells
          sheet.getRangeByName('A$rowIndex').setText((i + 1).toString());
          sheet.getRangeByName('B$rowIndex').setText(supervisorData['fyp-id']);
          sheet
              .getRangeByName('C$rowIndex')
              .setText(supervisorData['accepted-idea']);
          sheet
              .getRangeByName('D$rowIndex')
              .setText(supervisorData['main-supervisor']);
          sheet
              .getRangeByName('E$rowIndex')
              .setText(supervisorData['co-supervisor']);
          sheet.getRangeByName('F$rowIndex').setText(supervisorData['regno1']);
          sheet
              .getRangeByName('F${rowIndex + 1}')
              .setText(supervisorData['regno2']);
          sheet
              .getRangeByName('F${rowIndex + 2}')
              .setText(supervisorData['regno3']);

          double roundedValue1 =
              supervisorData['supervisor_mem1'].round().toDouble();
          sheet.getRangeByName('G${rowIndex}').setNumber(roundedValue1);

          double roundedValue2;
          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('G${rowIndex + 1}').setText("");
          } else {
            roundedValue2 =
                supervisorData['supervisor_mem2'].round().toDouble();
            sheet.getRangeByName('G${rowIndex + 1}').setNumber(roundedValue2);
          }

          double roundedValue3;
          if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('G${rowIndex + 2}').setText("");
          } else {
            roundedValue3 =
                supervisorData['supervisor_mem3'].round().toDouble();
            sheet.getRangeByName('G${rowIndex + 2}').setNumber(roundedValue3);
          }

          double I_roundedValue1 =
              supervisorData['internal_mem1'].round().toDouble();
          sheet.getRangeByName('H${rowIndex}').setNumber(I_roundedValue1);

          double IroundedValue2;
          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('H${rowIndex + 1}').setText("");
          } else {
            IroundedValue2 = supervisorData['internal_mem2'].round().toDouble();
            sheet.getRangeByName('H${rowIndex + 1}').setNumber(IroundedValue2);
          }

          double IroundedValue3;
          if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('H${rowIndex + 2}').setText("");
          } else {
            IroundedValue3 = supervisorData['internal_mem3'].round().toDouble();
            sheet.getRangeByName('H${rowIndex + 2}').setNumber(IroundedValue3);
          }

          double E_roundedValue1 =
              supervisorData['external-results-mem1'].round().toDouble();
          sheet.getRangeByName('I${rowIndex}').setNumber(E_roundedValue1);

          double EroundedValue2;
          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('I${rowIndex + 1}').setText("");
          } else {
            EroundedValue2 =
                supervisorData['external-results-mem2'].round().toDouble();
            sheet.getRangeByName('I${rowIndex + 1}').setNumber(EroundedValue2);
          }

          double EroundedValue3;
          if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('I${rowIndex + 2}').setText("");
          } else {
            EroundedValue3 =
                supervisorData['external-results-mem3'].round().toDouble();
            sheet.getRangeByName('I${rowIndex + 2}').setNumber(EroundedValue3);
          }

          sheet
              .getRangeByName('J$rowIndex')
              .setFormula('=G$rowIndex + H$rowIndex + I$rowIndex');
          sheet.getRangeByName('J$rowIndex').cellStyle.hAlign =
              ios.HAlignType.center;

          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('J${rowIndex + 1}').setText("");
          } else {
            sheet.getRangeByName('J${rowIndex + 1}').setFormula(
                '=G${rowIndex + 1} + H${rowIndex + 1} + I${rowIndex + 1} ');
            sheet.getRangeByName('J${rowIndex + 1}').cellStyle.hAlign =
                ios.HAlignType.center;
          }

          if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('J${rowIndex + 2}').setText("");
          } else {
            sheet.getRangeByName('J${rowIndex + 2}').setFormula(
                '=G${rowIndex + 2} + H${rowIndex + 2} + I${rowIndex + 2}');
            sheet.getRangeByName('J${rowIndex + 2}').cellStyle.hAlign =
                ios.HAlignType.center;
          }

          if (supervisorData['supervisor_mem1'] == 0 ||
              supervisorData['internal_mem1'] == 0 ||
              supervisorData['external-results-mem1'] == 0) {
            sheet.getRangeByName('K$rowIndex').setText('I');
            sheet.getRangeByName('K$rowIndex').cellStyle.hAlign =
                ios.HAlignType.center;
          } else {
            sheet.getRangeByName('K$rowIndex').setFormula(
                '=IF(J$rowIndex>=90,"A+",IF(J$rowIndex>=85,"A",IF(J$rowIndex>=80,"A-",IF(J$rowIndex>=75,"B+",IF(J$rowIndex>=71,"B",IF(J$rowIndex>=68,"B-",IF(J$rowIndex>=64,"C+",IF(J$rowIndex>=61,"C",IF(J$rowIndex>=58,"C-",IF(J$rowIndex>=54,"D+",IF(J$rowIndex>=50,"D", IF(J$rowIndex=0,"-",  "F"))))))))))))');
            sheet.getRangeByName('K$rowIndex').cellStyle.bold = true;
            sheet.getRangeByName('K$rowIndex').cellStyle.hAlign =
                ios.HAlignType.center;
            sheet.getRangeByName('K$rowIndex').cellStyle.vAlign =
                ios.VAlignType.center;
          }

          if (supervisorData['supervisor_mem2'] == 0 ||
              supervisorData['internal_mem2'] == 0 ||
              supervisorData['external-results-mem2'] == 0) {
            sheet.getRangeByName('K${rowIndex + 1}').setText('I');
            sheet.getRangeByName('K${rowIndex + 1}').cellStyle.hAlign =
                ios.HAlignType.center;
          } else {
            sheet.getRangeByName('K${rowIndex + 1}').setFormula(
                '=IF(J${rowIndex + 1}  >=90,"A+",IF(J${rowIndex + 1} >=85,"A",IF(J${rowIndex + 1}>=80,"A-",IF(J${rowIndex + 1}>=75,"B+",IF(J${rowIndex + 1}>=71,"B",IF(J${rowIndex + 1}>=68,"B-",IF(J${rowIndex + 1}>=64,"C+",IF(J${rowIndex + 1}>=61,"C",IF(J${rowIndex + 1} >=58,"C-",IF(J${rowIndex + 1}>=54,"D+",IF(J${rowIndex + 1}>=50,"D", IF(J${rowIndex + 1}=0,"-",  "F"))))))))))))');
            sheet.getRangeByName('K${rowIndex + 1}').cellStyle.bold = true;
            sheet.getRangeByName('K${rowIndex + 1}').cellStyle.hAlign =
                ios.HAlignType.center;
            sheet.getRangeByName('K${rowIndex + 1}').cellStyle.vAlign =
                ios.VAlignType.center;
          }

          if (supervisorData['supervisor_mem3'] == 0 ||
              supervisorData['internal_mem3'] == 0 ||
              supervisorData['external-results-mem3'] == 0) {
            sheet.getRangeByName('K${rowIndex + 2}').setText('I');
            sheet.getRangeByName('K${rowIndex + 2}').cellStyle.hAlign =
                ios.HAlignType.center;
          } else {
            sheet.getRangeByName('K${rowIndex + 2}').setFormula(
                '=IF(J${rowIndex + 2}  >=90,"A+",IF(J${rowIndex + 2} >=85,"A",IF(J${rowIndex + 2}>=80,"A-",IF(J${rowIndex + 2}>=75,"B+",IF(J${rowIndex + 2}>=71,"B",IF(J${rowIndex + 2}>=68,"B-",IF(J${rowIndex + 2}>=64,"C+",IF(J${rowIndex + 2}>=61,"C",IF(J${rowIndex + 2} >=58,"C-",IF(J${rowIndex + 2}>=54,"D+",IF(J${rowIndex + 2}>=50,"D", IF(J${rowIndex + 2}=0,"-",  "F"))))))))))))');
            sheet.getRangeByName('K${rowIndex + 2}').cellStyle.bold = true;
            sheet.getRangeByName('K${rowIndex + 2}').cellStyle.hAlign =
                ios.HAlignType.center;
            sheet.getRangeByName('K${rowIndex + 2}').cellStyle.vAlign =
                ios.VAlignType.center;
          }

          rowIndex += 3; // Increment row index for the next set of data
        }
      }
      sheet.getRangeByName('D1:G1').merge();

      sheet.getRangeByName('D1').setText('BSIT FYP Results');
      sheet.getRangeByName('D1').cellStyle.fontColor = '#004d99';
      sheet.getRangeByName('D1').cellStyle.fontSize = 18;
      sheet.getRangeByName('D1').columnWidth = 32.43;

      sheet.getRangeByName('D1').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('D1').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('D1').cellStyle.bold = true;

      sheet.getRangeByName('D2:G2').merge();

      sheet.getRangeByName('D2').setText('Session 2019-2023');
      sheet.getRangeByName('D2').cellStyle.fontColor = '#000d33';
      sheet.getRangeByName('D2').cellStyle.fontSize = 14;

      sheet.getRangeByName('D2').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('D2').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('D2').cellStyle.bold = true;

      sheet.getRangeByName('A3:K3').merge();

// -------------------------------------------- Sr# ------------------------------ //
      sheet.getRangeByName('A4:A5').merge();
      sheet.getRangeByName('A4').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('A4').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('A4').setText('Sr#');
      sheet.getRangeByName('A4').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('A4').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('A4').columnWidth = 5;
      sheet.getRangeByName('A4').cellStyle.bold = true;
      sheet.getRangeByName('A4').cellStyle.fontSize = 12;

// -------------------------------------------- Reg No ------------------------------ //

      sheet.getRangeByName('B4:B5').merge();
      sheet.getRangeByName('B4').setText('Group Id');
      sheet.getRangeByName('B4').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('B4').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('B4').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('B4').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('B4').columnWidth = 17;
      sheet.getRangeByName('B4').cellStyle.bold = true;
      sheet.getRangeByName('B4').cellStyle.fontSize = 12;

// -------------------------------------------- Name ------------------------------ //
      sheet.getRangeByName('C4').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('C4').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('C4:C5').merge();
      sheet.getRangeByName('C4').setText('Project Title');
      sheet.getRangeByName('C4').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('C4').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('C4').columnWidth = 40;
      sheet.getRangeByName('C4').cellStyle.bold = true;
      sheet.getRangeByName('C4').cellStyle.fontSize = 12;

// -------------------------------------------- MARKS ------------------------------ //
      sheet.getRangeByName('D4:D5').merge();
      sheet.getRangeByName('D4').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('D4').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('D4').setText('Main Supervisor');
      sheet.getRangeByName('D4').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('D4').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('D4').columnWidth = 22;
      sheet.getRangeByName('D4').cellStyle.bold = true;
      sheet.getRangeByName('D4').cellStyle.fontSize = 12;

// -------------------------------------------- Co Supervisor ------------------------------ //

      sheet.getRangeByName('E4:E5').merge();
      sheet.getRangeByName('E4').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('E4').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('E4').setText('Co-Supervisor');
      sheet.getRangeByName('E4').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('E4').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('E4').cellStyle.bold = true;
      sheet.getRangeByName('E4').cellStyle.fontSize = 12;
      sheet.getRangeByName('E4').columnWidth = 22;

// -------------------------------------------- Group Members ------------------------------ //
      sheet.getRangeByName('F4:F5').merge();
      sheet.getRangeByName('F4:F5').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('F4').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('F4').setText('Group Members');
      sheet.getRangeByName('F4').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('F4').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('F4').cellStyle.bold = true;
      sheet.getRangeByName('F4').columnWidth = 23;
      sheet.getRangeByName('F4').cellStyle.fontSize = 12;

// // -------------------------------------------- Total ------------------------------ //
//     sheet.getRangeByName('F5').cellStyle.backColor = '#4472C4';
//     sheet.getRangeByName('F5').cellStyle.fontColor = '#ffffff';
//     sheet.getRangeByName('F5').setText('Total');
//     sheet.getRangeByName('F5').cellStyle.hAlign = ios.HAlignType.center;
//     sheet.getRangeByName('F5').cellStyle.vAlign = ios.VAlignType.center;
//     sheet.getRangeByName('F5').cellStyle.bold = true;
//     sheet.getRangeByName('F5').cellStyle.fontSize = 12;

// -------------------------------------------- Grade ------------------------------ //

      sheet.getRangeByName('G4:J4').merge();
      sheet.getRangeByName('G4').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('G4').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('G4').setText('Marks');
      sheet.getRangeByName('G4').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('G4').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('G4').cellStyle.bold = true;
      sheet.getRangeByName('G4').cellStyle.fontSize = 12;

// -------------------------------------------- Supervisor ------------------------------ //
      sheet.getRangeByName('G5').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('G5').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('G5').setText('Supervisor');
      sheet.getRangeByName('G5').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('G5').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('G5').cellStyle.bold = true;
      sheet.getRangeByName('G5').cellStyle.fontSize = 12;
      sheet.getRangeByName('G5').columnWidth = 12.43;

      sheet.getRangeByName('H5').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('H5').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('H5').setText('Internal');
      sheet.getRangeByName('H5').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('H5').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('H5').cellStyle.bold = true;
      sheet.getRangeByName('H5').cellStyle.fontSize = 12;

// -------------------------------------------- External ------------------------------ //
      sheet.getRangeByName('I5').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('I5').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('I5').setText('External');
      sheet.getRangeByName('I5').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('I5').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('I5').cellStyle.bold = true;
      sheet.getRangeByName('I5').cellStyle.fontSize = 12;

// -------------------------------------------- Total ------------------------------ //
      sheet.getRangeByName('J5').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('J5').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('J5').setText('Total');
      sheet.getRangeByName('J5').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('J5').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('J5').cellStyle.bold = true;
      sheet.getRangeByName('J5').cellStyle.fontSize = 12;

      // -------------------------------------------- Grade ------------------------------ //

      sheet.getRangeByName('K4:K5').merge();
      sheet.getRangeByName('K4:K5').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('K4').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('K4').setText('Grade');
      sheet.getRangeByName('K4').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('K4').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('K4').cellStyle.bold = true;
      sheet.getRangeByName('K4').cellStyle.fontSize = 12;

// -------------------------------------------- Set Data ------------------------------ //

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      if (kIsWeb) {
        AnchorElement(
            href:
                'data:application/octet-stream;charset=utf-16le;base64, ${base64.encode(bytes)}')
          ..setAttribute('download', 'BSIT-FYP-Results.xlsx')
          ..click();
      } else {
        final String path = (await getApplicationDocumentsDirectory()).path;
        final String fileName = '$path/Results.xlsx';

        final io.File file = io.File(fileName);

        await file.writeAsBytes(bytes, flush: true);

        OpenFile.open(fileName);
      }
    }
  }

  Future<void> createExcel() async {
    final evenColor = "#9CC2E5";
    final oddColor = "#FFFFFF";

    final ios.Workbook workbook = ios.Workbook();

    final ios.Worksheet sheet = workbook.worksheets[0];

    // sheet.getRangeByName('C1').setText('BSIT FYP Results (7th Semester)');

    final CollectionReference users = FirebaseFirestore.instance.collection(
        '/Convenor/classes/BS Information Technology/groups/8th-Semester-Results');
    QuerySnapshot querySnapshot = await users.get();

    int rowIndex = 6;
    int count = 1;
    for (QueryDocumentSnapshot userSnapshot in querySnapshot.docs) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      if (rowIndex % 2 == 0) {
        sheet.getRangeByName('A$rowIndex:H$rowIndex').cellStyle.backColor =
            evenColor;
      } else {
        sheet.getRangeByName('A$rowIndex:H$rowIndex').cellStyle.backColor =
            oddColor;
      }

      ios.Range range = sheet.getRangeByName('A$rowIndex:H$rowIndex');

      range.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;
      //  range.cellStyle.borders.all.color =  '#0000000';

      sheet.getRangeByName('A$rowIndex').setNumber(count as double?);
      sheet.getRangeByName('A$rowIndex').cellStyle.hAlign =
          ios.HAlignType.center;

      sheet.getRangeByName('B$rowIndex').setText(userData['regno']);
      sheet.getRangeByName('C$rowIndex').setText(userData['name']);

      if (userData['supervisor-result'] == '0') {
        sheet.getRangeByName('D$rowIndex').setText('pending');
        sheet.getRangeByName('D$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      } else {
        double number = userData['supervisor-result'];
        int roundedNumber = number.round();

        sheet
            .getRangeByName('D$rowIndex')
            .setNumber((userData['supervisor-result']).round().toDouble());
        sheet.getRangeByName('D$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      }

      if (userData['internal-result'] == '0') {
        sheet.getRangeByName('E$rowIndex').setText('pending');
        sheet.getRangeByName('E$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      } else {
        sheet
            .getRangeByName('E$rowIndex')
            .setNumber(userData['internal-result'].round().toDouble());
        sheet.getRangeByName('E$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      }

      if (userData['external-result'] == '0') {
        sheet.getRangeByName('F$rowIndex').setText('pending');
        sheet.getRangeByName('F$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      } else {
        sheet
            .getRangeByName('F$rowIndex')
            .setNumber(userData['external-result'].round().toDouble());
        sheet.getRangeByName('F$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      }

      if (userData['supervisor-result'] == '0' ||
          userData['internal-result'] == '0') {
        sheet.getRangeByName('G$rowIndex').setText('-');
        sheet.getRangeByName('G$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      } else {
        sheet
            .getRangeByName('G$rowIndex')
            .setFormula('=D$rowIndex + E$rowIndex + F$rowIndex');
        sheet.getRangeByName('G$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      }

      if (userData['supervisor-result'] == 0 ||
          userData['internal-result'] == 0 ||
          userData['external-result'] == 0) {
        sheet.getRangeByName('H$rowIndex').setText('I');
        sheet.getRangeByName('H$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      } else {
        sheet.getRangeByName('H$rowIndex').setFormula(
            '=IF(G$rowIndex>=90,"A+",IF(G$rowIndex>=85,"A",IF(G$rowIndex>=80,"A-",IF(G$rowIndex>=75,"B+",IF(G$rowIndex>=71,"B",IF(G$rowIndex>=68,"B-",IF(G$rowIndex>=64,"C+",IF(G$rowIndex>=61,"C",IF(G$rowIndex>=58,"C-",IF(G$rowIndex>=54,"D+",IF(G$rowIndex>=50,"D", IF(G$rowIndex=0,"-",  "F"))))))))))))');
        sheet.getRangeByName('H$rowIndex').cellStyle.bold = true;
        sheet.getRangeByName('H$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
        sheet.getRangeByName('H$rowIndex').cellStyle.vAlign =
            ios.VAlignType.center;
      }

      // sheet
      //     .getRangeByName('D$rowIndex')
      //     .setNumber(int.parse(userData['supervisory-evaluation']) as double?);
      // sheet.getRangeByName('D$rowIndex').cellStyle.hAlign = ios.HAlignType.center;
      // sheet
      //     .getRangeByName('E$rowIndex')
      //     .setNumber(int.parse(userData['internal-evaluation']) as double?);
      // sheet.getRangeByName('E$rowIndex').cellStyle.hAlign = ios.HAlignType.center;

      // sheet.getRangeByName('F$rowIndex').setFormula('=D$rowIndex + E$rowIndex');
      // sheet.getRangeByName('F$rowIndex').cellStyle.hAlign = HAlignType.center;

      // sheet.getRangeByName('G$rowIndex').setFormula(
      //     '=IF(F$rowIndex>=90,"A+",IF(F$rowIndex>=85,"A",IF(F$rowIndex>=80,"A-",IF(F$rowIndex>=75,"B+",IF(F$rowIndex>=71,"B",IF(F$rowIndex>=68,"B-",IF(F$rowIndex>=64,"C+",IF(F$rowIndex>=61,"C",IF(F$rowIndex>=58,"C-",IF(F$rowIndex>=54,"D+",IF(F$rowIndex>=50,"D", IF(F$rowIndex=0,"-",  "F"))))))))))))');
      // sheet.getRangeByName('G$rowIndex').cellStyle.bold = true;
      // sheet.getRangeByName('G$rowIndex').cellStyle.hAlign = HAlignType.center;
      // sheet.getRangeByName('G$rowIndex').cellStyle.vAlign = VAlignType.center;
      rowIndex++;
      count++;
    }

    sheet.getRangeByName('C1:F1').merge();

    sheet.getRangeByName('C1').setText('BSIT FYP Results (8th Semester)');
    sheet.getRangeByName('C1').cellStyle.fontColor = '#004d99';
    sheet.getRangeByName('C1').cellStyle.fontSize = 18;
    sheet.getRangeByName('C1').columnWidth = 32.43;

    sheet.getRangeByName('C1').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('C1').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('C1').cellStyle.bold = true;

    sheet.getRangeByName('C2:F2').merge();

    sheet.getRangeByName('C2').setText('Session 2019-2023');
    sheet.getRangeByName('C2').cellStyle.fontColor = '#000d33';
    sheet.getRangeByName('C2').cellStyle.fontSize = 14;

    sheet.getRangeByName('C2').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('C2').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('C2').cellStyle.bold = true;

    sheet.getRangeByName('A3:H3').merge();

// -------------------------------------------- Sr# ------------------------------ //
    sheet.getRangeByName('A4:A5').merge();
    sheet.getRangeByName('A4').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('A4').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('A4').setText('Sr#');
    sheet.getRangeByName('A4').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('A4').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('A4').columnWidth = 5;
    sheet.getRangeByName('A4').cellStyle.bold = true;
    sheet.getRangeByName('A4').cellStyle.fontSize = 12;

// -------------------------------------------- Reg No ------------------------------ //

    sheet.getRangeByName('B4:B5').merge();
    sheet.getRangeByName('B4').setText('Reg. No');
    sheet.getRangeByName('B4').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('B4').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('B4').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('B4').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('B4').columnWidth = 17;
    sheet.getRangeByName('B4').cellStyle.bold = true;
    sheet.getRangeByName('B4').cellStyle.fontSize = 12;

// -------------------------------------------- Name ------------------------------ //
    sheet.getRangeByName('C4').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('C4').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('C4:C5').merge();
    sheet.getRangeByName('C4').setText('Name');
    sheet.getRangeByName('C4').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('C4').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('C4').cellStyle.bold = true;
    sheet.getRangeByName('C4').cellStyle.fontSize = 12;

// -------------------------------------------- MARKS ------------------------------ //
    sheet.getRangeByName('D4:G4').merge();
    sheet.getRangeByName('D4').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('D4').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('D4').setText('Marks');
    sheet.getRangeByName('D4').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('D4').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('D4').cellStyle.bold = true;
    sheet.getRangeByName('D4').cellStyle.fontSize = 12;

// -------------------------------------------- Supervisor ------------------------------ //
    sheet.getRangeByName('D5').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('D5').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('D5').setText('Supervisor');
    sheet.getRangeByName('D5').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('D5').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('D5').cellStyle.bold = true;
    sheet.getRangeByName('D5').cellStyle.fontSize = 12;
    sheet.getRangeByName('D5').columnWidth = 12.43;

// -------------------------------------------- Internal ------------------------------ //
    sheet.getRangeByName('E5').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('E5').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('E5').setText('Internal');
    sheet.getRangeByName('E5').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('E5').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('E5').cellStyle.bold = true;
    sheet.getRangeByName('E5').cellStyle.fontSize = 12;

// -------------------------------------------- External ------------------------------ //
    sheet.getRangeByName('F5').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('F5').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('F5').setText('External');
    sheet.getRangeByName('F5').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('F5').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('F5').cellStyle.bold = true;
    sheet.getRangeByName('F5').cellStyle.fontSize = 12;

// -------------------------------------------- Total ------------------------------ //
    sheet.getRangeByName('G5').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('G5').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('G5').setText('Total');
    sheet.getRangeByName('G5').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('G5').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('G5').cellStyle.bold = true;
    sheet.getRangeByName('G5').cellStyle.fontSize = 12;

// -------------------------------------------- Grade ------------------------------ //

    sheet.getRangeByName('H4:H5').merge();
    sheet.getRangeByName('H4').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('H4').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('H4').setText('Grade');
    sheet.getRangeByName('H4').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('H4').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('H4').cellStyle.bold = true;
    sheet.getRangeByName('H4').cellStyle.fontSize = 12;

// -------------------------------------------- Set Data ------------------------------ //

    // sheet.getRangeByName('A6').setNumber(1);
    // sheet.getRangeByName('A6').cellStyle.hAlign = ios.HAlignType.center;
    // sheet.getRangeByName('B6').setText('19-NTU-CS-1136');
    // sheet.getRangeByName('C6').setText('Alina Arshad');
    // sheet.getRangeByName('D6').setNumber(44);
    // sheet.getRangeByName('D6').cellStyle.hAlign = HAlignType.center;
    // sheet.getRangeByName('E6').setNumber(46);
    // sheet.getRangeByName('E6').cellStyle.hAlign = HAlignType.center;

    // sheet.getRangeByName('F6').setFormula('=D6+E6');
    // sheet.getRangeByName('F6').cellStyle.hAlign = HAlignType.center;
    // sheet.getRangeByName('G6').setText('A-');
    // // sheet
    // //     .getRangeByName('G6')
    // //     .setFormula('==IF(F6 > 85, "A+",),(F6 > 80, "A-",)');
    // sheet.getRangeByName('G6').cellStyle.bold = true;
    // sheet.getRangeByName('G6').cellStyle.hAlign = HAlignType.center;
    // sheet.getRangeByName('G6').cellStyle.vAlign = VAlignType.center;

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64, ${base64.encode(bytes)}')
        ..setAttribute('download', 'Results_BSIT_8th_Semester.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationDocumentsDirectory()).path;
      final String fileName = '$path/Results.xlsx';

      final io.File file = io.File(fileName);

      await file.writeAsBytes(bytes, flush: true);

      OpenFile.open(fileName);
    }
  }
}

class Student {
  final String name;
  final double grade;

  Student(this.name, this.grade);
}

class method extends StatelessWidget {
  final alina, mid_percentage_mem1, mid_percentage_mem2, mid_percentage_mem3;
  method(
      {this.alina,
      this.mid_percentage_mem1,
      this.mid_percentage_mem2,
      this.mid_percentage_mem3});

  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collectionGroup('Internal-evaluation')
            // .orderBy('fyp-id')
            .where('fyp-id', isEqualTo: alina)
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
                  // color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Internal Evaluation Pending!!",
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ));
          }
          // length = snapshot.data!.docs.length;
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot groupdocument = snapshot.data!.docs[index];

                bool isFieldEmpty2 = groupdocument['regno2'] == null ||
                    groupdocument['regno2'] == '';
                bool isFieldEmpty3 = groupdocument['regno3'] == null ||
                    groupdocument['regno3'] == '';

                var results = groupdocument['group-intro'] +
                    groupdocument['group-SRS'] +
                    groupdocument['group-design'] +
                    groupdocument['group-objectives'];

                var results_mem1 = groupdocument['group-intro'] +
                    groupdocument['group-SRS'] +
                    groupdocument['group-design'] +
                    groupdocument['group-objectives'] +
                    groupdocument['individual-code-understanding-mem1'] +
                    groupdocument['individual-presentation-mem1'];

                var results_mem2 = groupdocument['group-intro'] +
                    groupdocument['group-SRS'] +
                    groupdocument['group-design'] +
                    groupdocument['group-objectives'] +
                    groupdocument['individual-code-understanding-mem2'] +
                    groupdocument['individual-presentation-mem2'];

                var results_mem3 = groupdocument['group-intro'] +
                    groupdocument['group-SRS'] +
                    groupdocument['group-design'] +
                    groupdocument['group-objectives'] +
                    groupdocument['individual-code-understanding-mem3'] +
                    groupdocument['individual-presentation-mem3'];

                double internal_percentage_mem1 = (40 / 100) * results_mem1;
                double internal_percentage_mem2 = (40 / 100) * results_mem2;
                double internal_percentage_mem3 = (40 / 100) * results_mem3;

                double total_mem1 =
                    mid_percentage_mem1 + internal_percentage_mem1;
                double total_mem2 =
                    mid_percentage_mem2 + internal_percentage_mem2;
                double total_mem3 =
                    mid_percentage_mem3 + internal_percentage_mem3;

                final List<Student> students = [
                  Student(groupdocument['mem1'], total_mem1),
                  Student(groupdocument['mem2'], total_mem2),
                  Student(groupdocument['mem3'], total_mem3),
                ];
                String getGradeLetter(double grade) {
                  if (grade >= 90) {
                    return 'A+';
                  } else if (grade >= 85) {
                    return 'A';
                  } else if (grade >= 80) {
                    return 'A-';
                  } else if (grade >= 75) {
                    return 'B+';
                  } else if (grade >= 71) {
                    return 'B';
                  } else if (grade >= 68) {
                    return 'B-';
                  } else if (grade >= 64) {
                    return 'C+';
                  } else if (grade >= 61) {
                    return 'C';
                  } else if (grade >= 58) {
                    return 'C-';
                  } else if (grade >= 54) {
                    return 'D+';
                  } else if (grade >= 50) {
                    return 'D';
                  } else {
                    return 'F';
                  }
                }

                Color getGradeColor(double grade) {
                  if (grade >= 90) {
                    return Colors.green;
                  } else if (grade >= 80) {
                    return Colors.blue;
                  } else if (grade >= 70) {
                    return Colors.yellow;
                  } else if (grade >= 60) {
                    return Colors.orange;
                  } else {
                    return Colors.red;
                  }
                }

                return SafeArea(
                  child: Container(
                    height: 220,
                    // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
