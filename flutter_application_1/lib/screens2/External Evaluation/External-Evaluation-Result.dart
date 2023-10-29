// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:editable/editable.dart';
import 'package:pdf/pdf.dart';

import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> users = [
  {"userId": "Hopu7hxZy2aIWzz0sWNMvnPxvzG3", "name": "Dr. Muhammad Asif Habib"},
  {"userId": "v6BFVgU84rc5vUivTzhqCjGt5LC3", "name": "Dr. Mudassar Ahmad"},
  {"userId": "JLJV5AExTpg2IMgWVBC8sK3774q2", "name": "Dr. Rehan Ashraf"},
  {"userId": "ouBUTRzvpbdYZLnvCBSZcXXFBMN2", "name": "Dr. Haseeb Ahmad"},
  {"userId": "zFm9gU5b1jeDDUu1tD4XyWJtsg23", "name": "Dr. Isma Hamid"},
  {"userId": "S5OGYR4RkqZ6xzKqLlrVBeXIXgG2", "name": "Dr. Muhammad Asif"},
  {"userId": "MMTvKpGtsJQRWLyqFeB1P9Jms792", "name": "Dr. Shahbaz Ahmad"},
  {"userId": "W0RSGhwWvLUUgvMGkds9xVOLSaA3", "name": "Mr. Waqar Ahmad"},
  {"userId": "EzOEIpWeYnSDCCW8O8hEoyraPko1", "name": "Dr. CM Nadeem Faisal"},
  {"userId": "RndCDn7CRKRz7uvzysR89Iga07f1", "name": "Dr. Toqeer Mehmood"},
  {"userId": "ClBK5vpwKXgl3c3WgboMLYvyBim1", "name": "Dr. Hamid Ali"},
  {"userId": "cpMIGGn4ZEfXe77uB4UOkJTQtu12", "name": "Dr. Abdul Qayyum"},
  {"userId": "vHqYdIQminUb7R6aHP5f2IAc4oQ2", "name": "Dr. Muhammad Adeel"},
  {"userId": "euP6bebMZfWPKzissugjvgiarQx1", "name": "Dr. Suleman Raza"},
  {"userId": "", "name": "Dr. Aisha Younas"},
  {"userId": "", "name": "Dr. Sajida Parveen"},
  {"userId": "KvlPt9RlYcMtrNYhspWKufb63f32", "name": "Dr. Inam Illahi"},
  {"userId": "0ZRr7ZuX1hOmh9r8ulCKLgFO4Il1", "name": "Mr. Muhammad Shahid"},
  {"userId": "5QfE9xxaEXU3NUeMBv0y3zgk6S72", "name": "Mr. Nasir Mahmood"},
  {"userId": "A5Yb79Mx1oYCD4yv6iBVpERJMP33", "name": "Mr. Shahbaz Ahmad Sahi"},
  {"userId": "VK7qNqiWeucWOTWPyCSfCawWcF02", "name": "Mr. Muhammad Naeem"},
  {"userId": "GpVmXTKEpYSJg6zX8li91E3dTod2", "name": "Mr. Arsal Mahmood"},
  {"userId": "", "name": "Mr. Muhammad Nouman"},
  {"userId": "", "name": "Miss Sana Ikram"},
  {"userId": "UokwmyYyaxN0ZdSCn4UmXRhX4VA3", "name": "Miss Sara Naeem"},
  {"userId": "", "name": "Miss Kainat Rizwan"},
  {"userId": "", "name": "Miss Humael Hassan"},
  {"userId": "", "name": "Miss Saira Ishtiaq"},
];

class UserData {
  final String userId;
  final String name;

  UserData({required this.userId, required this.name});

  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      userId: data['userId'],
      name: data['name'],
    );
  }
}

class ExternalEvaluationResults extends StatefulWidget {
  final DocumentSnapshot snap;

  ExternalEvaluationResults({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<ExternalEvaluationResults> createState() =>
      _ExternalEvaluationResultsState();
}

class _ExternalEvaluationResultsState extends State<ExternalEvaluationResults> {
  final formKey = GlobalKey<FormState>();

  final _group_intro = TextEditingController();
  final _group_SRS = TextEditingController();
  final _group_design = TextEditingController();
  final _group_testing = TextEditingController();
  final _group_objectives = TextEditingController();
  final _group_video = TextEditingController();
  final _group_GUI = TextEditingController();
  final _individual_presentation_mem1 = TextEditingController();
  final _individual_presentation_mem2 = TextEditingController();
  final _individual_presentation_mem3 = TextEditingController();
  final _code_understanding_mem1 = TextEditingController();
  final _code_understanding_mem2 = TextEditingController();
  final _code_understanding_mem3 = TextEditingController();

  List<List<String>> tableData = [
    ['A1', 'B1', 'C1', 'D1', 'E1', 'F1'],
    ['A2', 'B2', 'C2', 'D2', 'E2', 'F2'],
    ['A3', 'B3', 'C3', 'D3', 'E3', 'F3'],
  ];
  // Update values
  late Future<UserData> _userData;
  @override
  void initState() {
    super.initState();
    var snap = widget.snap;
    _userData = getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // _group_intro.value = TextEditingValue(text: snap['group-intro']);

    // var query = FirebaseFirestore.instance.collection('Internal-evaluation').where('fyp-id', isEqualTo: data['23-fyp-305']);
    bool isFieldEmpty2 =
        widget.snap['regno2'] == null || widget.snap['regno2'] == '';

    bool isFieldEmpty3 =
        widget.snap['regno3'] == null || widget.snap['regno3'] == '';
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
        body: FutureBuilder(
            future: _userData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('/External/accounts/External-Evaluation')
                        .doc('evaluators')
                        .collection(widget.snap['external-evaluator1'])
                        .doc(widget.snap.id)
                        .collection('External-Evaluation-Results')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        // ignore: prefer_const_constructors
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot groupdocument =
                              snapshot.data!.docs[index];

                          // snap = groupdocument;

                          var results = groupdocument['group-intro'] +
                              groupdocument['group-SRS'] +
                              groupdocument['group-design'] +
                              groupdocument['group-objectives'] +
                              groupdocument['group-GUI'] +
                              groupdocument['group-security'] +
                              groupdocument['group-testing'] +
                              groupdocument['group-video'];

                          var results_mem1 = groupdocument[
                                  'individual-code-understanding-mem1'] +
                              groupdocument['individual-presentation-mem1'] +
                              groupdocument['overall-attendance-mem1'];

                          var results_mem2 = groupdocument[
                                  'individual-code-understanding-mem2'] +
                              groupdocument['individual-presentation-mem2'] +
                              groupdocument['overall-attendance-mem2'];

                          var results_mem3 = groupdocument[
                                  'individual-code-understanding-mem3'] +
                              groupdocument['individual-presentation-mem3'] +
                              groupdocument['overall-attendance-mem3'];

                          int semester_evaluation_mem1 = int.parse(
                              groupdocument['overall-attendance-mem1']
                                  .toString());

                          int semester_evaluation_mem2 = int.parse(
                              groupdocument['overall-attendance-mem2']
                                  .toString());

                          int individual_evaluation_mem1 = int.parse(
                                  groupdocument[
                                          'individual-code-understanding-mem1']
                                      .toString()) +
                              int.parse(groupdocument['overall-attendance-mem1']
                                  .toString());

                          int individual_evaluation_mem2 = int.parse(
                                  groupdocument[
                                          'individual-code-understanding-mem2']
                                      .toString()) +
                              int.parse(groupdocument['overall-attendance-mem2']
                                  .toString());

                          int individual_evaluation_mem3 = int.parse(
                                  groupdocument[
                                          'individual-code-understanding-mem3']
                                      .toString()) +
                              int.parse(groupdocument['overall-attendance-mem3']
                                  .toString());

                          // double semester_percentage_mem1 =
                          //     (15 / 100) * semester_evaluation_mem1;
                          // double semester_percentage_mem2 =
                          //     (15 / 100) * semester_evaluation_mem2;
                          // double semester_percentage_mem3 =
                          //     (15 / 100) * semester_evaluation_mem3;

                          // double mid_percentage_mem1 =
                          //     (45 / 100) * results_mem1;
                          // double mid_percentage_mem2 =
                          //     (45 / 100) * results_mem2;
                          // double mid_percentage_mem3 =
                          //     (45 / 100) * results_mem3;

                          // double totalresults_mem1 =
                          //     (semester_percentage_mem1 + mid_percentage_mem1);
                          // double totalresults_mem2 =
                          //     (semester_percentage_mem2 + mid_percentage_mem2);
                          // double totalresults_mem3 =
                          //     (semester_percentage_mem3 + mid_percentage_mem3);

                          return SafeArea(
                              child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: Row(
                                    children: [
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            _createPDF(
                                                groupdocument,
                                                results,
                                                results_mem1,
                                                results_mem2,
                                                results_mem3);
                                          },
                                          icon: Icon(
                                            Icons.print_sharp,
                                            size: 20,
                                          ),
                                          label: Text(
                                            'Print',
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800),
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.print_sharp,
                                            size: 20,
                                          ),
                                          label: Text(
                                            'back',
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800),
                                          )),
                                    ],
                                  ),
                                ),
                                Center(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.white,
                                  ),
                                  margin: EdgeInsets.only(
                                    top: 15,
                                    bottom: 25,
                                  ),
                                  width: 800,
                                  child: Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 40, bottom: 40),
                                        // padding: EdgeInsets.all(4),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  'External Evaluation Results',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 50.0, right: 50.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Group Id: ',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        groupdocument['fyp-id'],
                                                        style: GoogleFonts.roboto(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationThickness:
                                                                2,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'Main Supervisor: ',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        groupdocument[
                                                            'main-supervisor'],
                                                        style: GoogleFonts.roboto(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationThickness:
                                                                2,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 50.0, right: 50.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Project Title: ',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    SizedBox(
                                                      width: 75,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        // 'The second row is directly under the first row, with each child in the second row also wrapped in an',
                                                        groupdocument[
                                                            'accepted-idea'],
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: 30,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50, right: 30),
                                                child: Text(
                                                    'Individual Evaluation',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900)),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40),
                                                child: DataTable(
                                                  columnSpacing: 15,
                                                  horizontalMargin: 10,
                                                  // columnSpacing: 20.0,
                                                  // columnSpacing: 20.0,
                                                  border: TableBorder.all(
                                                      color: Colors.black,
                                                      width: 1),
                                                  columns: [
                                                    DataColumn(
                                                        label: Text(
                                                      'Student Name',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                                    DataColumn(
                                                        label: Text(
                                                      'Reg no.',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                                    DataColumn(
                                                      label: Text(
                                                          'Documentation',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                          'Application and code',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                    ),
                                                    DataColumn(
                                                        label: Text(
                                                            'Presentation',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))),
                                                  ],
                                                  rows: [
                                                    DataRow(cells: [
                                                      DataCell(Text(
                                                          groupdocument['mem1'],
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                      DataCell(Text(
                                                          groupdocument[
                                                              'regno1'],
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                      DataCell(Text(
                                                          groupdocument[
                                                                  'individual-documentation-mem1']
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                      DataCell(Text(
                                                          groupdocument[
                                                                  'individual-code-understanding-mem1']
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                      DataCell(Text(
                                                          groupdocument[
                                                                  'individual-presentation-mem1']
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                    ]),
                                                    DataRow(cells: [
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty2,
                                                        child: Text(
                                                            groupdocument[
                                                                'mem2'],
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty2,
                                                        child: Text(
                                                            groupdocument[
                                                                'regno2'],
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty2,
                                                        child: Text(
                                                            groupdocument[
                                                                    'individual-documentation-mem2']
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty2,
                                                        child: Text(
                                                            groupdocument[
                                                                    'individual-code-understanding-mem2']
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty2,
                                                        child: Text(
                                                            groupdocument[
                                                                    'individual-presentation-mem2']
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                    ]),
                                                    DataRow(cells: [
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty3,
                                                        child: Text(
                                                            groupdocument[
                                                                'mem3'],
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty3,
                                                        child: Text(
                                                            groupdocument[
                                                                'regno3'],
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty3,
                                                        child: Text(
                                                            groupdocument[
                                                                    'individual-documentation-mem3']
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty3,
                                                        child: Text(
                                                            groupdocument[
                                                                    'individual-code-understanding-mem3']
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty3,
                                                        child: Text(
                                                            groupdocument[
                                                                    'individual-presentation-mem3']
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                    ]),
                                                  ],
                                                ),
                                              ),

                                              // //   height: 20,
                                              // // ),

                                              SizedBox(
                                                height: 30,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50, right: 30),
                                                child: Text('Final Results',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900)),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50),
                                                child: DataTable(
                                                  columnSpacing: 65.0,
                                                  // columnSpacing: 20.0,
                                                  border: TableBorder.all(
                                                      color: Colors.black,
                                                      width: 1),
                                                  columns: [
                                                    DataColumn(
                                                        label: Text(
                                                      'Student Name',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                                    DataColumn(
                                                        label: Text(
                                                      'Reg no.',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                                    DataColumn(
                                                        label: Text(
                                                            'Total Marks',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))),
                                                    DataColumn(
                                                        label: Text('Obtained',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))),
                                                  ],
                                                  rows: [
                                                    DataRow(cells: [
                                                      DataCell(Text(
                                                          groupdocument['mem1'],
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                      DataCell(Text(
                                                          groupdocument[
                                                              'regno1'],
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                      DataCell(Text('30',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                      DataCell(Text(
                                                          groupdocument[
                                                                  'external-results-mem1']
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                    ]),
                                                    DataRow(cells: [
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty2,
                                                        child: Text(
                                                            groupdocument[
                                                                'mem2'],
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty2,
                                                        child: Text(
                                                            groupdocument[
                                                                'regno2'],
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty2,
                                                        child: Text('30',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty2,
                                                        child: Text(
                                                            groupdocument[
                                                                    'external-results-mem2']
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                    ]),
                                                    DataRow(cells: [
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty3,
                                                        child: Text(
                                                            groupdocument[
                                                                'mem3'],
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty3,
                                                        child: Text(
                                                            groupdocument[
                                                                'regno3'],
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty3,
                                                        child: Text('30',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                      DataCell(Visibility(
                                                        visible: !isFieldEmpty3,
                                                        child: Text(
                                                            groupdocument[
                                                                    'external-results-mem3']
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      )),
                                                    ]),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ));
                        },
                      );
                    });
              }
              return Text('Connected');
            }));
  }
}

Future<UserData> getUserData() async {
  var user = await FirebaseAuth.instance.currentUser;

  var userId = 'S5OGYR4RkqZ6xzKqLlrVBeXIXgG2';
  // var userId = user!.uid;

  for (var i = 0; i < users.length; i++) {
    if (users[i]['userId'] == userId) {
      var userData = UserData.fromMap(users[i]);

      return userData;
    }
  }

  throw Exception('No UserData found for current user');
}

void createPdf() {
  final pdf = pw.Document();

  pdf.addPage(pw.MultiPage(
    build: (pw.Context context) {
      return <pw.Widget>[
        pw.Container(
            child: pw.Column(
          children: [
            pw.Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
          ],
        )
            // pw.Table.fromTextArray(
            //   context: context,
            //   data: <List<String>>[
            //     <String>['Column 1', 'Column 2', 'Column 3'],
            //     ...List.generate(
            //       50,
            //       (index) => <String>['Row $index', 'Value 1', 'Value 2'],
            //     ),
            //   ],
            // ),
            ),
      ];
    },
  ));

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}

String getCurrentDate() {
  var date = DateTime.now().toString();

  var dateParse = DateTime.parse(date);

  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  return formattedDate.toString();
}

_createPDF(var snap, var results, double sum_mem1, double sum_mem2,
    double sum_mem3) async {
  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  final doc = pw.Document();
  var font = await PdfGoogleFonts.tinosRegular();
  var fontBold = await PdfGoogleFonts.tinosBold();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          margin: const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'External Evaluation Results',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Group Id',
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        snap['fyp-id'],
                        style: pw.TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      pw.Text(
                        'Supervisor',
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        snap['main-supervisor'],
                        style: pw.TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ]),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Row(children: [
                  pw.Text('Project Title:',
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(width: 50),
                  pw.Expanded(
                      child: pw.Text(snap['accepted-idea'],
                          style: pw.TextStyle(
                            fontSize: 13,
                          )))
                ]),

                // pw.SizedBox(
                //   height: 20,
                // ),
                // pw.Text(
                //   'Individual Evaluation',
                //   style: pw.TextStyle(
                //       fontSize: 16, fontWeight: pw.FontWeight.bold),
                // ),
                // pw.SizedBox(
                //   height: 10,
                // ),
                // pw.Table.fromTextArray(
                //   context: context,
                //   data: <List<String>>[
                //     <String>[
                //       'Student Name',
                //       'Reg No',
                //       'Overall Attendance',
                //       'Code Understanding',
                //       'Total Marks',
                //     ],
                //     <String>[
                //       snap['mem1'],
                //       snap['regno1'],
                //       snap['overall-attendance-mem1'].toString(),
                //       snap['individual-code-understanding-mem1'].toString(),
                //       '$semester_results'
                //     ],
                //     <String>[
                //       snap['mem2'],
                //       snap['regno2'],
                //       snap['overall-attendance-mem2'].toString(),
                //       snap['individual-code-understanding-mem2'].toString(),
                //       '$semester_results'
                //     ],
                //     <String>[
                //       snap['mem3'],
                //       snap['regno3'],
                //       snap['overall-attendance-mem3'].toString(),
                //       snap['individual-code-understanding-mem3'].toString(),
                //       '$semester_results'
                //     ],
                //   ],
                // ),
                pw.SizedBox(
                  height: 20,
                ),

                pw.Text(
                  'Final Results',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Student Name',
                      'Reg No',
                      'Total Marks',
                      'Obtained Marks'
                    ],
                    <String>[
                      snap['mem1'],
                      snap['regno1'],
                      '30',
                      snap['external-results-mem1'].toString()
                    ],
                    <String>[
                      snap['mem2'],
                      snap['regno2'],
                      '30',
                      snap['external-results-mem2'].toString()
                    ],
                    <String>[
                      snap['mem3'],
                      snap['regno3'],
                      '30',
                      snap['external-results-mem3'].toString()
                    ],
                  ],
                ),
                pw.SizedBox(height: 220),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Dated: ${getCurrentDate()}',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    pw.Column(children: [
                      pw.Text(snap['meevaluator'],
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 10)),
                      pw.Text('Evaluator, BSIT',
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
                _createPDF(snap, results, sum_mem1, sum_mem2, sum_mem3);
              },
              child: const Text("Print"))
        ],
      ),
    ),
  );
}
