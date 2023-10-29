// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens2/student-screens-2/homepage.dart';
import 'package:flutter_application_1/screens/evaluation_screens/EvaluationForm.dart';
import 'package:flutter_application_1/screens/evaluation_screens/evaluation_results.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyExternalGroupMarksheet extends StatefulWidget {
  @override
  State<MyExternalGroupMarksheet> createState() =>
      _MyExternalGroupMarksheetState();
}

class _MyExternalGroupMarksheetState extends State<MyExternalGroupMarksheet> {
  Map<String, dynamic>? userData;

  var selectedName;

  @override
  void initState() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    var user = await FirebaseAuth.instance.currentUser;

    var userId = user!.uid;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('/External/accounts/Evaluators')
          .where('userid', isEqualTo: userId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        userData = querySnapshot.docs.first.data() as Map<String, dynamic>?;
        setState(() {}); // Update the UI with the fetched user data
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  final borderRadius = BorderRadius.circular(5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collectionGroup('External-Evaluation-Results')
              .where('meevaluator', isEqualTo: userData!['Name'])
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data?.size == 0) {
              return Center(
                  child: Container(
                height: 150,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No groups Evaluated yet! ",
                          style: GoogleFonts.roboto(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ));
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

              return Column(
                children: [
                  Container(
                    height: 120,
                    padding: EdgeInsets.only(top: 30),
                    width: double.infinity,
                    color: Color(0xFF0D46BB),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('External Evaluation Results',
                          style: GoogleFonts.roboto(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SingleChildScrollView(
                    child: 
                    
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final groupdocument = snapshot.data!.docs[index];

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
                            groupdocument[
                                'individual-code-understanding-mem1'] +
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
                            groupdocument[
                                'individual-code-understanding-mem2'] +
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
                            groupdocument[
                                'individual-code-understanding-mem3'] +
                            groupdocument['individual-presentation-mem3'] +
                            groupdocument['overall-attendance-mem3'];

                        return
                        
                        
                         SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'FYP id ',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w900),
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
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    groupdocument[
                                                        'main-supervisor'],
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
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
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      groupdocument[
                                                          'accepted-idea'],
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  PopupMenuButton(
                                                    padding: EdgeInsets.all(5),

                                                    elevation: 10,

                                                    offset: Offset(0,
                                                        45), // SET THE (X,Y) POSITION
                                                    iconSize: 25,

                                                    itemBuilder: (context) {
                                                      return [
                                                        PopupMenuItem(
                                                            value: 'View',
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (ctx) =>
                                                                        Container(
                                                                            child:
                                                                                AlertDialog(
                                                                          insetPadding: const EdgeInsets.symmetric(
                                                                              horizontal: 200,
                                                                              vertical: 20),
                                                                          scrollable:
                                                                              true,
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                          content:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              child: SingleChildScrollView(
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    _ViewInternalResult(groupdocument)
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )));
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .preview,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .black87,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        'View',
                                                                        style: GoogleFonts.roboto(
                                                                            color: Colors
                                                                                .black87,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w700),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Divider()
                                                                ],
                                                              ),
                                                            )),
                                                      ];
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      DataTable(
                                        columnSpacing: 20.0,
                                        // columnSpacing: 20.0,
                                        // border: TableBorder.all(
                                        //     color: Colors.black, width: 1),
                                        columns: [
                                          DataColumn(
                                              label: Text(
                                            'Student Name',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Reg no.',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          )),
                                          DataColumn(
                                              label: Text('Total Marks',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          DataColumn(
                                              label: Text('Obtained Marks',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell(Text(groupdocument['mem1'],
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                            DataCell(Text(
                                                groupdocument['regno1'],
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                            DataCell(Text('30',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                            DataCell(Text(
                                                groupdocument[
                                                        'external-results-mem1']
                                                    .toString(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Visibility(
                                              visible: !isFieldEmpty2,
                                              child: Text(groupdocument['mem2'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            )),
                                            DataCell(Visibility(
                                              visible: !isFieldEmpty2,
                                              child: Text(
                                                  groupdocument['regno2'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            )),
                                            DataCell(Visibility(
                                              visible: !isFieldEmpty2,
                                              child: Text('30',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
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
                                                          FontWeight.w400)),
                                            )),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Visibility(
                                              visible: !isFieldEmpty2,
                                              child: Text(groupdocument['mem3'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            )),
                                            DataCell(Visibility(
                                              visible: !isFieldEmpty3,
                                              child: Text(
                                                  groupdocument['regno3'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            )),
                                            DataCell(Visibility(
                                              visible: !isFieldEmpty3,
                                              child: Text('30',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
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
                                                          FontWeight.w400)),
                                            )),
                                          ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text('Something went wrong'),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  _ViewInternalResult(var groupdocument) {
    bool isFieldEmpty2 =
        groupdocument['regno2'] == null || groupdocument['regno2'] == '';

    bool isFieldEmpty3 =
        groupdocument['regno3'] == null || groupdocument['regno3'] == '';

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

    return SafeArea(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
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
                        margin: EdgeInsets.only(top: 40, bottom: 40),
                        // padding: EdgeInsets.all(4),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'External Evaluation Results',
                                  style: GoogleFonts.openSans(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 50.0, right: 50.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Group Id: ',
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        groupdocument['fyp-id'],
                                        style: GoogleFonts.roboto(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Main Supervisor: ',
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        groupdocument['main-supervisor'],
                                        style: GoogleFonts.roboto(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 50.0, right: 50.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Project Title: ',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: 75,
                                    ),
                                    Expanded(
                                      child: Text(
                                        // 'The second row is directly under the first row, with each child in the second row also wrapped in an',
                                        groupdocument['accepted-idea'],
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 30),
                                child: Text('Individual Evaluation',
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: DataTable(
                                  columnSpacing: 15,
                                  horizontalMargin: 10,
                                  // columnSpacing: 20.0,
                                  // columnSpacing: 20.0,
                                  border: TableBorder.all(
                                      color: Colors.black, width: 1),
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'Student Name',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Reg no.',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    )),
                                    DataColumn(
                                      label: Text('Documentation',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    DataColumn(
                                      label: Text('Application and code',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    DataColumn(
                                        label: Text('Presentation',
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700))),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text(groupdocument['mem1'],
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                      DataCell(Text(groupdocument['regno1'],
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                      DataCell(Text(
                                          groupdocument[
                                                  'individual-documentation-mem1']
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                      DataCell(Text(
                                          groupdocument[
                                                  'individual-code-understanding-mem1']
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                      DataCell(Text(
                                          groupdocument[
                                                  'individual-presentation-mem1']
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty2,
                                        child: Text(groupdocument['mem2'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty2,
                                        child: Text(groupdocument['regno2'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty2,
                                        child: Text(
                                            groupdocument[
                                                    'individual-documentation-mem2']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty2,
                                        child: Text(
                                            groupdocument[
                                                    'individual-code-understanding-mem2']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty2,
                                        child: Text(
                                            groupdocument[
                                                    'individual-presentation-mem2']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty3,
                                        child: Text(groupdocument['mem3'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty3,
                                        child: Text(groupdocument['regno3'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty3,
                                        child: Text(
                                            groupdocument[
                                                    'individual-documentation-mem3']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty3,
                                        child: Text(
                                            groupdocument[
                                                    'individual-code-understanding-mem3']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty3,
                                        child: Text(
                                            groupdocument[
                                                    'individual-presentation-mem3']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
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
                                padding:
                                    const EdgeInsets.only(left: 50, right: 30),
                                child: Text('Final Results',
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: DataTable(
                                  columnSpacing: 65.0,
                                  // columnSpacing: 20.0,
                                  border: TableBorder.all(
                                      color: Colors.black, width: 1),
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'Student Name',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Reg no.',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    )),
                                    DataColumn(
                                        label: Text('Total Marks',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700))),
                                    DataColumn(
                                        label: Text('Obtained',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700))),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text(groupdocument['mem1'],
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                      DataCell(Text(groupdocument['regno1'],
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                      DataCell(Text('30',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                      DataCell(Text(
                                          groupdocument['external-results-mem1']
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty2,
                                        child: Text(groupdocument['mem2'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty2,
                                        child: Text(groupdocument['regno2'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty2,
                                        child: Text('30',
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty2,
                                        child: Text(
                                            groupdocument[
                                                    'external-results-mem2']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty3,
                                        child: Text(groupdocument['mem3'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty3,
                                        child: Text(groupdocument['regno3'],
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty3,
                                        child: Text('30',
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                      DataCell(Visibility(
                                        visible: !isFieldEmpty3,
                                        child: Text(
                                            groupdocument[
                                                    'external-results-mem3']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      )),
                                    ]),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class FinalInternalClassResult_old extends StatefulWidget {
  @override
  _FinalInternalClassResult_oldState createState() =>
      _FinalInternalClassResult_oldState();
}

class _FinalInternalClassResult_oldState
    extends State<FinalInternalClassResult_old> {
  late Future<UserData> _userData;

  final beforeEvaluationColor = Color(0xffbbbbbb); // light gray
  final afterEvaluationColor = Color(0xff4caf50);

  @override
  void initState() {
    super.initState();
    _userData = getUserData();
    fetchDocumentsFromCollectionGroup();
  }

  Future<void> fetchDocumentsFromCollectionGroup() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final collectionGroup = firestoreInstance.collectionGroup('Mid-evaluation');

    final querySnapshot = await collectionGroup
        .where('main-supervisor', isEqualTo: 'Mr. Shahbaz Ahmad Sahi')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Process the documents here
      for (final documentSnapshot in querySnapshot.docs) {
        final data = documentSnapshot.data();
        // Access the document data fields here
        final myField = data['main-supervisor'];
        final myOtherField = data['co-supervisor'];
        // ...
      }
    } else {
      // No documents found
    }
  }
// List<QueryDocumentSnapshot> documents = await fetchDocumentsFromCollectionGroup('');

//   Future<List<QueryDocumentSnapshot>> fetchDocumentsFromCollectionGroup(
//     String collectionName) async {
//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore
//         .collectionGroup(collectionName)
//         .get();

//     return querySnapshot.docs;
//   } catch (e) {
//     print('Error fetching documents: $e');
//     return [];
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _userData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collectionGroup('Internal-evaluation')
                    .orderBy('fyp-id')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        children: [
                          Text("No group evaluated yet! ",
                              style: GoogleFonts.roboto(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ));
                  }
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(20),
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Text('Internal Results',
                                style: GoogleFonts.roboto(
                                    fontSize: 20, fontWeight: FontWeight.w900)),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final groupdocument = snapshot.data!.docs[index];

                              bool isFieldEmpty2 =
                                  groupdocument['regno2'] == null ||
                                      groupdocument['regno2'] == '';

                              bool isFieldEmpty3 =
                                  groupdocument['regno3'] == null ||
                                      groupdocument['regno3'] == '';

                              var results = groupdocument['group-intro'] +
                                  groupdocument['group-SRS'] +
                                  groupdocument['group-design'] +
                                  groupdocument['group-objectives'];

                              var results_mem1 = groupdocument['group-intro'] +
                                  groupdocument['group-SRS'] +
                                  groupdocument['group-design'] +
                                  groupdocument['group-objectives'] +
                                  groupdocument[
                                      'individual-code-understanding-mem1'] +
                                  groupdocument['individual-presentation-mem1'];

                              var results_mem2 = groupdocument['group-intro'] +
                                  groupdocument['group-SRS'] +
                                  groupdocument['group-design'] +
                                  groupdocument['group-objectives'] +
                                  groupdocument[
                                      'individual-code-understanding-mem2'] +
                                  groupdocument['individual-presentation-mem2'];

                              var results_mem3 = groupdocument['group-intro'] +
                                  groupdocument['group-SRS'] +
                                  groupdocument['group-design'] +
                                  groupdocument['group-objectives'] +
                                  groupdocument[
                                      'individual-code-understanding-mem3'] +
                                  groupdocument['individual-presentation-mem3'];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 20,
                                              top: 20,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'FYP id ',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          groupdocument[
                                                              'fyp-id'],
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
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
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        groupdocument[
                                                            'main-supervisor'],
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Title',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          groupdocument[
                                                              'accepted-idea'],
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                      PopupMenuButton(
                                                        padding:
                                                            EdgeInsets.all(5),

                                                        elevation: 10,

                                                        offset: Offset(0,
                                                            45), // SET THE (X,Y) POSITION
                                                        iconSize: 25,

                                                        itemBuilder: (context) {
                                                          return [
                                                            PopupMenuItem(
                                                                value: 'View',
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (ctx) =>
                                                                            Container(
                                                                                child: AlertDialog(
                                                                              insetPadding: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
                                                                              scrollable: true,
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                              content: SingleChildScrollView(
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  child: SingleChildScrollView(
                                                                                    child: Column(
                                                                                      children: <Widget>[
                                                                                        // _ViewInternalResult(groupdocument)
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )));
                                                                  },
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.preview,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                Colors.black87,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'View',
                                                                            style: GoogleFonts.roboto(
                                                                                color: Colors.black87,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w700),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Divider()
                                                                    ],
                                                                  ),
                                                                )),
                                                            PopupMenuItem(
                                                                value: 'Delete',
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        // FirebaseFirestore
                                                                        //     .instance
                                                                        //     .collection('/Evaluations/evaluations/Internal/internal-evaluators/Dr. Muhammad Asif/nJb4quXTzUhyWgQPtNKB/Internal-evaluation')
                                                                        //     .doc('onmYQOWntldtd7C9FmoO')
                                                                        //     .delete();

                                                                        getDocument2(
                                                                            groupdocument);
                                                                        var internal_results_mem1 = FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "/Convenor/classes/BS Information Technology/groups/7th-Semester-Results")
                                                                            .doc(groupdocument[
                                                                                'regno1'])
                                                                            .update({
                                                                          "internal-evaluation":
                                                                              '0'
                                                                        });

                                                                        var internal_results_mem2 = FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "/Convenor/classes/BS Information Technology/groups/7th-Semester-Results")
                                                                            .doc(groupdocument[
                                                                                'regno2'])
                                                                            .update({
                                                                          "internal-evaluation":
                                                                              '0'
                                                                        });

                                                                        var internal_results_mem3 = FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "/Convenor/classes/BS Information Technology/groups/7th-Semester-Results")
                                                                            .doc(groupdocument[
                                                                                'regno3'])
                                                                            .update({
                                                                          "internal-evaluation":
                                                                              '0'
                                                                        });
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.delete_outline,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                Colors.black87,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            'Delete',
                                                                            style: GoogleFonts.roboto(
                                                                                color: Colors.black87,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w700),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Divider()
                                                                  ],
                                                                )),
                                                          ];
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          DataTable(
                                            columnSpacing: 20.0,
                                            // columnSpacing: 20.0,
                                            // border: TableBorder.all(
                                            //     color: Colors.black, width: 1),
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
                                                  label: Text('Total Marks',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .w700))),
                                              DataColumn(
                                                  label: Text('Obtained Marks',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .w700))),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(Text(
                                                    groupdocument['mem1'],
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400))),
                                                DataCell(Text(
                                                    groupdocument['regno1'],
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400))),
                                                DataCell(Text('100',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400))),
                                                DataCell(Text(
                                                    results_mem1.toString(),
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400))),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Visibility(
                                                  visible: !isFieldEmpty2,
                                                  child: Text(
                                                      groupdocument['mem2'],
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )),
                                                DataCell(Visibility(
                                                  visible: !isFieldEmpty2,
                                                  child: Text(
                                                      groupdocument['regno2'],
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )),
                                                DataCell(Visibility(
                                                  visible: !isFieldEmpty2,
                                                  child: Text('100',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )),
                                                DataCell(Visibility(
                                                  visible: !isFieldEmpty2,
                                                  child: Text(
                                                      results_mem2.toString(),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Visibility(
                                                  visible: !isFieldEmpty2,
                                                  child: Text(
                                                      groupdocument['mem3'],
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )),
                                                DataCell(Visibility(
                                                  visible: !isFieldEmpty3,
                                                  child: Text(
                                                      groupdocument['regno3'],
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )),
                                                DataCell(Visibility(
                                                  visible: !isFieldEmpty3,
                                                  child: Text('100',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )),
                                                DataCell(Visibility(
                                                  visible: !isFieldEmpty3,
                                                  child: Text(
                                                      results_mem3.toString(),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )),
                                              ]),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Container(
              child: Center(
                  child: Text('Something went wrong',
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w600))),
            );
          }
        },
      ),
    );
  }

  void getDocument2(var groupdocument) async {
    String documentId = 'zeeshan';
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('/Evaluations/evaluations/Internal')
        .doc('internal-evaluators')
        .collection(groupdocument['meevaluator'])
        .where('fyp-id', isEqualTo: groupdocument['fyp-id'])
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      documentId = querySnapshot.docs[0].id;
    }

    print('$documentId');
    print(groupdocument.id);
    print(groupdocument['meevaluator']);

    try {
      await FirebaseFirestore.instance
          .collection('/Evaluations/evaluations/Internal')
          .doc('internal-evaluators')
          .collection(groupdocument['meevaluator'])
          .doc('$documentId')
          .collection('Internal-evaluation')
          .doc(groupdocument.id)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 1, 75, 4),
          content: Text('Result deleted sucessfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 194, 28, 16),
          content: Text('$e')));
    }
  }

  Future<UserData> getUserData() async {
    var user = await FirebaseAuth.instance.currentUser;
    // var userId = 'A5Yb79Mx1oYCD4yv6iBVpERJMP33';
    var userId = user!.uid;

    for (var i = 0; i < users.length; i++) {
      if (users[i]['userId'] == userId) {
        var userData = UserData.fromMap(users[i]);

        return userData;
      }
    }

    throw Exception('No UserData found for current user');
  }
}
