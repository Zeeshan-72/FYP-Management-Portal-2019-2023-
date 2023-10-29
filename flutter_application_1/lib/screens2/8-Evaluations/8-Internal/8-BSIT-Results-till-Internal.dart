// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, unnecessary_nullable_for_final_variable_declarations

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

import '../../../main.dart';

class BSIT_RESULTS_TILL_INTERNAL extends StatefulWidget {
  @override
  _BSIT_RESULTS_TILL_INTERNALState createState() =>
      _BSIT_RESULTS_TILL_INTERNALState();
}

class _BSIT_RESULTS_TILL_INTERNALState
    extends State<BSIT_RESULTS_TILL_INTERNAL> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  var snap;
  var results2;
  var mem1_result;
  var mem2_result;
  var mem3_result;

  var external_status;

  String? gradeValue;
  String? myVariable;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collectionGroup('Final-evaluation')
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
                          onPressed: () async {
                            await InternalResult
                                .createExcel(); // Call the method from the second widget
                            // You can perform other actions after the method call if needed
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Print',
                                style: GoogleFonts.roboto(
                                    fontSize: 15, fontWeight: FontWeight.w700),
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
                  Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot groupdocument =
                          snapshot.data!.docs[index];

                      var results = groupdocument['group-intro'] +
                          groupdocument['group-SRS'] +
                          groupdocument['group-design'] +
                          groupdocument['group-objectives'] +
                          groupdocument['group-GUI'] +
                          groupdocument['group-security'] +
                          groupdocument['group-testing'] +
                          groupdocument['group-video'];

                      var results_mem1 = groupdocument['group-intro'] +
                          groupdocument['group-SRS'] +
                          groupdocument['group-design'] +
                          groupdocument['group-objectives'] +
                          groupdocument['group-GUI'] +
                          groupdocument['group-security'] +
                          groupdocument['group-testing'] +
                          groupdocument['group-video'] +
                          groupdocument['individual-code-understanding-mem1'] +
                          groupdocument['individual-presentation-mem1'] +
                          groupdocument['overall-attendance-mem1'];

                      var results_mem2 = groupdocument['group-intro'] +
                          groupdocument['group-SRS'] +
                          groupdocument['group-design'] +
                          groupdocument['group-objectives'] +
                          groupdocument['group-GUI'] +
                          groupdocument['group-security'] +
                          groupdocument['group-testing'] +
                          groupdocument['group-video'] +
                          groupdocument['individual-code-understanding-mem2'] +
                          groupdocument['individual-presentation-mem2'] +
                          groupdocument['overall-attendance-mem2'];

                      var results_mem3 = groupdocument['group-intro'] +
                          groupdocument['group-SRS'] +
                          groupdocument['group-design'] +
                          groupdocument['group-objectives'] +
                          groupdocument['group-GUI'] +
                          groupdocument['group-security'] +
                          groupdocument['group-testing'] +
                          groupdocument['group-video'] +
                          groupdocument['individual-code-understanding-mem3'] +
                          groupdocument['individual-presentation-mem3'] +
                          groupdocument['overall-attendance-mem3'];

                      double mid_percentage_mem1 = (40 / 100) * results_mem1;
                      double mid_percentage_mem2 = (40 / 100) * results_mem2;
                      double mid_percentage_mem3 = (40 / 100) * results_mem3;

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
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InternalResult(
                                    supervisordocument: groupdocument,
                                    groupid: groupdocument['fyp-id'],
                                    mid_percentage_mem1: mid_percentage_mem1,
                                    mid_percentage_mem2: mid_percentage_mem2,
                                    mid_percentage_mem3: mid_percentage_mem3,
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
}

class Student {
  final String name;
  final double grade;

  Student(this.name, this.grade);
}

class InternalResult extends StatelessWidget {
  final supervisordocument,
      groupid,
      mid_percentage_mem1,
      mid_percentage_mem2,
      mid_percentage_mem3;

  static var overall_status;
  static var static_supervisordocument;
  static var static_groupid;
  static var static_mid_percentage_mem1;
  static var static_mid_percentage_mem2;
  static var static_mid_percentage_mem3;

  InternalResult({
    this.supervisordocument,
    this.groupid,
    this.mid_percentage_mem1,
    this.mid_percentage_mem2,
    this.mid_percentage_mem3,
  }) {
    static_supervisordocument = supervisordocument;
    static_groupid = groupid;
    static_mid_percentage_mem1 = mid_percentage_mem1;
    static_mid_percentage_mem2 = mid_percentage_mem2;
    static_mid_percentage_mem3 = mid_percentage_mem3;
  }

  static Future<void> createExcel() async {
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

          ios.Range range = sheet.getRangeByName('A$rowIndex:J$rowIndex');

          range.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;

          ios.Range range2 =
              sheet.getRangeByName('A${rowIndex + 1}:J${rowIndex + 1}');

          range2.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;

          ios.Range range3 =
              sheet.getRangeByName('A${rowIndex + 2}:J${rowIndex + 2}');

          range3.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;

          // range.cellStyle.borders.all.color = '#0000000';

          if (rowIndex % 2 == 0) {
            sheet.getRangeByName('A$rowIndex:J$rowIndex').cellStyle.backColor =
                evenColor;
          } else {
            sheet.getRangeByName('A$rowIndex:J$rowIndex').cellStyle.backColor =
                oddColor;
          }

          if (rowIndex % 2 == 0) {
            sheet
                .getRangeByName('A${rowIndex + 1}:J${rowIndex + 1}')
                .cellStyle
                .backColor = evenColor;
          } else {
            sheet
                .getRangeByName('A${rowIndex + 1}:J${rowIndex + 1}')
                .cellStyle
                .backColor = oddColor;
          }

          if (rowIndex % 2 == 0) {
            sheet
                .getRangeByName('A${rowIndex + 2}:J${rowIndex + 2}')
                .cellStyle
                .backColor = evenColor;
          } else {
            sheet
                .getRangeByName('A${rowIndex + 2}:J${rowIndex + 2}')
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

          if (supervisorData['supervisory-status'] == 'Presentable' &&
                  supervisorData['supervisor_mem1'] +
                          supervisorData['internal_mem1'] >
                      49 ||
              supervisorData['supervisor_mem2'] +
                      supervisorData['internal_mem2'] >
                  49 ||
              supervisorData['supervisor_mem2'] +
                      supervisorData['internal_mem2'] >
                  49) {
            sheet.getRangeByName('J$rowIndex').setText('Presentable');
            sheet.getRangeByName('J$rowIndex').cellStyle.backColorRgb =
                Color.fromRGBO(76, 175, 80, 1); // Green background
            sheet.getRangeByName('J$rowIndex').cellStyle.fontColorRgb =
                Color.fromARGB(255, 255, 255, 255); // White text
          } else {
            sheet.getRangeByName('J$rowIndex').setText('Not Presentable');
            sheet.getRangeByName('J$rowIndex').cellStyle.backColorRgb =
                Color.fromRGBO(229, 57, 53, 1); // Red background
            sheet.getRangeByName('J$rowIndex').cellStyle.fontColorRgb =
                Color.fromARGB(255, 255, 255, 255); // White text
          }

          sheet.getRangeByName('J${rowIndex}:J${rowIndex + 2}').merge();
          sheet.getRangeByName('J${rowIndex}').cellStyle.hAlign =
              ios.HAlignType.center;
          sheet.getRangeByName('J${rowIndex}').cellStyle.vAlign =
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

          sheet
              .getRangeByName('I$rowIndex')
              .setFormula('=G$rowIndex + H$rowIndex');
          sheet.getRangeByName('I$rowIndex').cellStyle.hAlign =
              ios.HAlignType.center;

          if (supervisorData['regno2'] == "") {
            sheet.getRangeByName('I${rowIndex + 1}').setText("");
          } else {
            sheet
                .getRangeByName('I${rowIndex + 1}')
                .setFormula('=G${rowIndex + 1} + H${rowIndex + 1} ');
            sheet.getRangeByName('I${rowIndex + 1}').cellStyle.hAlign =
                ios.HAlignType.center;
          }

          if (supervisorData['regno3'] == "") {
            sheet.getRangeByName('I${rowIndex + 2}').setText("");
          } else {
            sheet
                .getRangeByName('I${rowIndex + 2}')
                .setFormula('=G${rowIndex + 2} + H${rowIndex + 2}');
            sheet.getRangeByName('I${rowIndex + 2}').cellStyle.hAlign =
                ios.HAlignType.center;
          }
          rowIndex += 3; // Increment row index for the next set of data
        }
      }
      sheet.getRangeByName('D1:G1').merge();

      sheet.getRangeByName('D1').setText('BSIT Internal Evaluation Results');
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

      sheet.getRangeByName('A3:J3').merge();

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

      sheet.getRangeByName('G4:I4').merge();
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

// -------------------------------------------- Total ------------------------------ //
      sheet.getRangeByName('I5').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('I5').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('I5').setText('Total');
      sheet.getRangeByName('I5').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('I5').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('I5').cellStyle.bold = true;
      sheet.getRangeByName('I5').cellStyle.fontSize = 12;

// -------------------------------------------- Status (for external) ------------------------------ //
      sheet.getRangeByName('J4:J5').merge();
      sheet.getRangeByName('J4').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('J4').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('J4').setText('Status (for external)');
      sheet.getRangeByName('J4').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('J4').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('J4').columnWidth = 30;
      sheet.getRangeByName('J4').cellStyle.bold = true;
      sheet.getRangeByName('J4').cellStyle.fontSize = 12;

// -------------------------------------------- Set Data ------------------------------ //

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      if (kIsWeb) {
        AnchorElement(
            href:
                'data:application/octet-stream;charset=utf-16le;base64, ${base64.encode(bytes)}')
          ..setAttribute('download', 'BSIT-Internal-Results.xlsx')
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

  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collectionGroup('final-internal-evaluation')
            // .orderBy('fyp-id')
            .where('fyp-id', isEqualTo: groupid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          Color backgroundColor =
              (supervisordocument['overall-supervisory-status'] ==
                      'Presentable')
                  ? Color.fromRGBO(76, 175, 80, 1)
                  : Color.fromRGBO(229, 57, 53, 1);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return Container(
              height: 150,
              decoration: BoxDecoration(
                  // color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'FYP id ',
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                supervisordocument['fyp-id'],
                                style: GoogleFonts.roboto(
                                    fontSize: 14, fontWeight: FontWeight.w500),
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
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                supervisordocument['main-supervisor'],
                                style: GoogleFonts.roboto(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
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
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                supervisordocument['accepted-idea'],
                                style: GoogleFonts.roboto(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Status',
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 40,
                              width: 120,
                              color: backgroundColor,
                              child: Center(
                                child: Text(
                                  supervisordocument[
                                      'overall-supervisory-status'],
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(child: Text('Internal Evaluation is pending'))
                ],
              ),
            );
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
                    groupdocument['group-objectives'] +
                    groupdocument['group-GUI'] +
                    groupdocument['group-security'] +
                    groupdocument['group-testing'] +
                    groupdocument['group-video'];

                var results_mem1 = groupdocument['group-intro'] +
                    groupdocument['group-SRS'] +
                    groupdocument['group-design'] +
                    groupdocument['group-objectives'] +
                    groupdocument['group-GUI'] +
                    groupdocument['group-security'] +
                    groupdocument['group-testing'] +
                    groupdocument['group-video'] +
                    groupdocument['individual-code-understanding-mem1'] +
                    groupdocument['individual-presentation-mem1'] +
                    groupdocument['overall-attendance-mem1'];

                var results_mem2 = groupdocument['group-intro'] +
                    groupdocument['group-SRS'] +
                    groupdocument['group-design'] +
                    groupdocument['group-objectives'] +
                    groupdocument['group-GUI'] +
                    groupdocument['group-security'] +
                    groupdocument['group-testing'] +
                    groupdocument['group-video'] +
                    groupdocument['individual-code-understanding-mem2'] +
                    groupdocument['individual-presentation-mem2'] +
                    groupdocument['overall-attendance-mem2'];

                var results_mem3 = groupdocument['group-intro'] +
                    groupdocument['group-SRS'] +
                    groupdocument['group-design'] +
                    groupdocument['group-objectives'] +
                    groupdocument['group-GUI'] +
                    groupdocument['group-security'] +
                    groupdocument['group-testing'] +
                    groupdocument['group-video'] +
                    groupdocument['individual-code-understanding-mem3'] +
                    groupdocument['individual-presentation-mem3'] +
                    groupdocument['overall-attendance-mem3'];

                double internal_percentage_mem1 = (30 / 100) * results_mem1;
                double internal_percentage_mem2 = (30 / 100) * results_mem2;
                double internal_percentage_mem3 = (30 / 100) * results_mem3;

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
                  if (grade > 49) {
                    return 'Presentable';
                  } else {
                    return 'Not Presentable';
                  }
                }

                String? External_Status = 'Zeeshan';

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

                String externalStatus =
                    (supervisordocument['overall-supervisory-status'] ==
                                'Presentable' &&
                            (total_mem1 > 49 ||
                                total_mem2 > 49 ||
                                total_mem3 > 49))
                        ? 'Presentable'
                        : 'Not Presentable';
                Color backgroundColor = (externalStatus == 'Presentable')
                    ? Colors.green
                    : Color.fromRGBO(229, 57, 53, 1);
                return SafeArea(
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      supervisordocument['fyp-id'],
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
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
                                  Expanded(
                                    child: Text(
                                      groupdocument['main-supervisor'],
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
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
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'Status',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 120,
                                    color: backgroundColor,
                                    child: Center(
                                      child: Text(
                                        externalStatus,
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DataTable(
                          // border: Border.all(1),
                          columns: [
                            DataColumn(
                                label: Text(
                              "Sr No.",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )),
                            DataColumn(
                                label: Text(
                              "Student Name",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )),
                            DataColumn(
                                label: Text(
                              "Student Reg No.",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )),
                            DataColumn(
                                label: Text(
                              "Supervisor (40%)",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )),
                            DataColumn(
                                label: Text(
                              "Internal (30%)",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )),
                            DataColumn(
                                label: Text(
                              "Obtained (/70)",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(
                                '1',
                                style: GoogleFonts.roboto(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              )),
                              DataCell(Text(
                                groupdocument['mem1'],
                                style: GoogleFonts.roboto(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              )),
                              DataCell(Text(
                                groupdocument['regno1'],
                                style: GoogleFonts.roboto(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              )),
                              DataCell(
                                  Text(mid_percentage_mem1.toStringAsFixed(0))),
                              DataCell(Text(
                                  internal_percentage_mem1.toStringAsFixed(0))),
                              DataCell(Text(total_mem1.toStringAsFixed(0))),
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
                                      mid_percentage_mem2.toStringAsFixed(0)))),
                              DataCell(Visibility(
                                visible: !isFieldEmpty2,
                                child: Visibility(
                                  visible: !isFieldEmpty2,
                                  child: Visibility(
                                    visible: !isFieldEmpty2,
                                    child: Text(internal_percentage_mem2
                                        .toStringAsFixed(0)),
                                  ),
                                ),
                              )),
                              DataCell(Visibility(
                                  visible: !isFieldEmpty2,
                                  child: Text(total_mem2.toStringAsFixed(0)))),
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
                                      mid_percentage_mem3.toStringAsFixed(0)))),
                              DataCell(Visibility(
                                visible: !isFieldEmpty3,
                                child: Text(internal_percentage_mem3
                                    .toStringAsFixed(0)),
                              )),
                              DataCell(Visibility(
                                  visible: !isFieldEmpty3,
                                  child: Text(total_mem3.toStringAsFixed(0)))),
                            ]),
                          ],
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
