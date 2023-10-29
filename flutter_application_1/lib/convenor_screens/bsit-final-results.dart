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

class BSITFinalResults extends StatefulWidget {
  @override
  _BSITFinalResultsState createState() => _BSITFinalResultsState();
}

class _BSITFinalResultsState extends State<BSITFinalResults> {
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
            .collectionGroup('Mid-evaluation')
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
                          onPressed: createExcel,
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
                          groupdocument['group-proposal'];

                      var results_mem1 = groupdocument['group-intro'] +
                          groupdocument['group-SRS'] +
                          groupdocument['group-design'] +
                          groupdocument['group-objectives'] +
                          groupdocument['group-proposal'] +
                          groupdocument['individual-code-understanding-mem1'] +
                          groupdocument['individual-presentation-mem1'] +
                          groupdocument['overall-attendance-mem1'] +
                          groupdocument['task-completion-mem1'];

                      var results_mem2 = groupdocument['group-intro'] +
                          groupdocument['group-SRS'] +
                          groupdocument['group-design'] +
                          groupdocument['group-objectives'] +
                          groupdocument['group-proposal'] +
                          groupdocument['individual-code-understanding-mem2'] +
                          groupdocument['individual-presentation-mem2'] +
                          groupdocument['overall-attendance-mem2'] +
                          groupdocument['task-completion-mem2'];

                      var results_mem3 = groupdocument['group-intro'] +
                          groupdocument['group-SRS'] +
                          groupdocument['group-design'] +
                          groupdocument['group-objectives'] +
                          groupdocument['group-proposal'] +
                          groupdocument['individual-code-understanding-mem3'] +
                          groupdocument['individual-presentation-mem3'] +
                          groupdocument['overall-attendance-mem3'] +
                          groupdocument['task-completion-mem3'];

                      double mid_percentage_mem1 = (60 / 100) * results_mem1;
                      double mid_percentage_mem2 = (60 / 100) * results_mem2;
                      double mid_percentage_mem3 = (60 / 100) * results_mem3;

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
                                  method(
                                    alina: groupdocument['fyp-id'],
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

  Future<void> createExcel() async {
    final evenColor = "#9CC2E5";
    final oddColor = "#FFFFFF";

    final ios.Workbook workbook = ios.Workbook();

    final ios.Worksheet sheet = workbook.worksheets[0];

    // sheet.getRangeByName('C1').setText('BSIT FYP Results (7th Semester)');

    final CollectionReference users = FirebaseFirestore.instance.collection(
        '/Convenor/classes/BS Information Technology/groups/7th-Semester-Results');
    QuerySnapshot querySnapshot = await users.get();

    int rowIndex = 6;
    int count = 1;
    for (QueryDocumentSnapshot userSnapshot in querySnapshot.docs) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      if (rowIndex % 2 == 0) {
        sheet.getRangeByName('A$rowIndex:G$rowIndex').cellStyle.backColor =
            evenColor;
      } else {
        sheet.getRangeByName('A$rowIndex:G$rowIndex').cellStyle.backColor =
            oddColor;
      }

      ios.Range range = sheet.getRangeByName('A$rowIndex:G$rowIndex');

      range.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;
      //  range.cellStyle.borders.all.color =  '#0000000';

      sheet.getRangeByName('A$rowIndex').setNumber(count as double?);
      sheet.getRangeByName('A$rowIndex').cellStyle.hAlign =
          ios.HAlignType.center;

      sheet.getRangeByName('B$rowIndex').setText(userData['regno']);
      sheet.getRangeByName('C$rowIndex').setText(userData['name']);

      if (userData['supervisory-evaluation'] == '0') {
        sheet.getRangeByName('D$rowIndex').setText('pending');
        sheet.getRangeByName('D$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      } else {
        sheet.getRangeByName('D$rowIndex').setNumber(
            int.parse(userData['supervisory-evaluation']) as double?);
        sheet.getRangeByName('D$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      }

      if (userData['internal-evaluation'] == '0') {
        sheet.getRangeByName('E$rowIndex').setText('pending');
        sheet.getRangeByName('E$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      } else {
        sheet
            .getRangeByName('E$rowIndex')
            .setNumber(int.parse(userData['internal-evaluation']) as double?);
        sheet.getRangeByName('E$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      }

      if (userData['supervisory-evaluation'] == '0' ||
          userData['internal-evaluation'] == '0') {
        sheet.getRangeByName('F$rowIndex').setText('-');
        sheet.getRangeByName('F$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      } else {
        sheet
            .getRangeByName('F$rowIndex')
            .setFormula('=D$rowIndex + E$rowIndex');
        sheet.getRangeByName('F$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      }

      if (userData['supervisory-evaluation'] == '0' ||
          userData['internal-evaluation'] == '0') {
        sheet.getRangeByName('G$rowIndex').setText('-');
        sheet.getRangeByName('G$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
      } else {
        sheet.getRangeByName('G$rowIndex').setFormula(
            '=IF(F$rowIndex>=90,"A+",IF(F$rowIndex>=85,"A",IF(F$rowIndex>=80,"A-",IF(F$rowIndex>=75,"B+",IF(F$rowIndex>=71,"B",IF(F$rowIndex>=68,"B-",IF(F$rowIndex>=64,"C+",IF(F$rowIndex>=61,"C",IF(F$rowIndex>=58,"C-",IF(F$rowIndex>=54,"D+",IF(F$rowIndex>=50,"D", IF(F$rowIndex=0,"-",  "F"))))))))))))');
        sheet.getRangeByName('G$rowIndex').cellStyle.bold = true;
        sheet.getRangeByName('G$rowIndex').cellStyle.hAlign =
            ios.HAlignType.center;
        sheet.getRangeByName('G$rowIndex').cellStyle.vAlign =
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

    sheet.getRangeByName('C1').setText('BSIT FYP Results (7th Semester)');
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
    sheet.getRangeByName('D4:F4').merge();
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

// -------------------------------------------- Total ------------------------------ //
    sheet.getRangeByName('F5').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('F5').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('F5').setText('Total');
    sheet.getRangeByName('F5').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('F5').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('F5').cellStyle.bold = true;
    sheet.getRangeByName('F5').cellStyle.fontSize = 12;

// -------------------------------------------- Grade ------------------------------ //

    sheet.getRangeByName('G4:G5').merge();
    sheet.getRangeByName('G4').cellStyle.backColor = '#4472C4';
    sheet.getRangeByName('G4').cellStyle.fontColor = '#ffffff';
    sheet.getRangeByName('G4').setText('Grade');
    sheet.getRangeByName('G4').cellStyle.hAlign = ios.HAlignType.center;
    sheet.getRangeByName('G4').cellStyle.vAlign = ios.VAlignType.center;
    sheet.getRangeByName('G4').cellStyle.bold = true;
    sheet.getRangeByName('G4').cellStyle.fontSize = 12;

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
        ..setAttribute('download', 'Results_BSIT_7th_Semester.xlsx')
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
                              "(60%)",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )),
                            DataColumn(
                                label: Text(
                              "(40%)",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )),
                            DataColumn(
                                label: Text(
                              "Total",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )),
                            DataColumn(
                                label: Text(
                              "Grade",
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
                              DataCell(Text(
                                getGradeLetter(students[0].grade),
                              )),
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
                              DataCell(Visibility(
                                  visible: !isFieldEmpty2,
                                  child:
                                      Text(getGradeLetter(students[1].grade)))),
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
                              DataCell(Visibility(
                                  visible: !isFieldEmpty3,
                                  child:
                                      Text(getGradeLetter(students[2].grade)))),
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































