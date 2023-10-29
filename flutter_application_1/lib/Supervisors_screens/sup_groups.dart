// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, camel_case_types, unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Supervisors_screens/supervisor-evaluation.dart';
import 'package:flutter_application_1/screens/evaluation_screens/Internal-marksheet.dart';
import 'package:flutter_application_1/screens/evaluation_screens/InternalGroupResult.dart';
import 'package:flutter_application_1/screens/evaluation_screens/mid-marksheet.dart';
import 'package:flutter_application_1/screens/evaluation_screens/myinternal-groups.dart';
import 'package:flutter_application_1/screens2/8-Evaluations/Supervisor-Evaluation-8.dart';
import 'package:google_fonts/google_fonts.dart';

class sup_groups extends StatefulWidget {
  @override
  State<sup_groups> createState() => _sup_groupsState();
}

class _sup_groupsState extends State<sup_groups> with TickerProviderStateMixin {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String get collection => collectionname(firebaseUser!.uid);

  late TabController _semesterTabController;
  late TabController _semester7TabController;
  late TabController _semester8TabController;

  @override
  void initState() {
    super.initState();
    _semesterTabController = TabController(length: 2, vsync: this);
    _semester7TabController = TabController(length: 5, vsync: this);
    _semester8TabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _semesterTabController.dispose();
    _semester7TabController.dispose();
    _semester8TabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return method1();
  }

  collectionname(String value) {
    String collection = '';
    if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
      return collection = 'Mr. Shahbaz Ahmad Sahi';
    } else if (value == 'W0RSGhwWvLUUgvMGkds9xVOLSaA3') {
      return collection = 'Mr. Waqar Ahmad';
    } else if (value == 'cpMIGGn4ZEfXe77uB4UOkJTQtu12') {
      return collection = 'Dr. Abdul Qayyum';
    } else if (value == 'RndCDn7CRKRz7uvzysR89Iga07f1') {
      return collection = 'Dr. Toqeer Mehmood';
    } else if (value == 'JLJV5AExTpg2IMgWVBC8sK3774q2') {
      return collection = 'Dr. Rehan Ashraf';
    } else if (value == 'UYnDX4dbGpdjkDt3m784v5egd7O2') {
      collection = 'Ms. Sana Ikram';
    } else {
      return collection = '';
    }
  }

  var length;
  method1() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                "/Convenor/classes/BS Information Technology/groups/group-members")
            .where("main-supervisor", isEqualTo: collection)
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
          length = snapshot.data!.docs.length;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  margin: EdgeInsets.only(top: 1),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30,
                          left: 10,
                        ),
                        child: Icon(
                          Icons.school,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: VerticalDivider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Program Batch : ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 40,
                                    width: 160,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 40, 137, 216),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Center(
                                      child: Text(
                                        '(2019 - 2023)',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'HelveticaNeue',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Section : ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    height: 40,
                                    width: 280,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 40, 137, 216),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Center(
                                      child: Text(
                                        'BS Information Technology',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'HelveticaNeue',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total Supervisions:  ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 30,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 40, 137, 216),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Center(
                                      child: Text(
                                        '$length',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'HelveticaNeue',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 140,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Co-Supervisions:  ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'HelveticaNeue',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 30,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 40, 137, 216),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Center(
                                      child: Text(
                                        '$length',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'HelveticaNeue',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),


                
                Container(
                  height: 1000,
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 1,
                    child: Column(
                      children: [
                        TabBar(
                          indicator: BoxDecoration(color: Colors.blue[300]),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          // indicatorPadding: EdgeInsets.all(5),
                          tabs: [
                            Container(
                              width: double.infinity,
                              // color: Colors.blue[300],
                              child: Tab(
                                child: Text('Semester 7',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            Tab(
                              child: Container(
                                width: double.infinity,
                                child: Tab(
                                  child: Text('Semester 8',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Semester 7 Childrens

                        Expanded(
                          child: TabBarView(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: double.infinity,
                                child: DefaultTabController(
                                    length: 5, // length of tabs
                                    initialIndex: 0,
                                    child: SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(8),
                                              child: TabBar(
                                                labelColor: Colors.blue,
                                                unselectedLabelColor:
                                                    Colors.black,
                                                indicatorSize:
                                                    TabBarIndicatorSize.label,
                                                indicatorPadding:
                                                    EdgeInsets.all(5),
                                                tabs: [
                                                  Tab(
                                                    child: Text('Groups',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                  Tab(
                                                    child: Text('Evaluation',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                  Tab(
                                                    child: Text(
                                                        'Supervisor Evaluation',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                  Tab(
                                                    child: Text(
                                                        'Internal Evaluation',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                  Tab(
                                                    child: Text('Results',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 20,
                                                    right: 20,
                                                    left: 20),
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: TabBarView(
                                                    children: <Widget>[
                                                      // InternalEvaluators(),

                                                      Container(
                                                        child: ListView(
                                                          shrinkWrap: true,
                                                          children: snapshot
                                                              .data!.docs
                                                              .map((document) {
                                                            return Card(
                                                              margin: EdgeInsets
                                                                  .all(20),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.all(20),
                                                                              height: 40,
                                                                              width: 120,
                                                                              decoration: BoxDecoration(color: Color.fromARGB(255, 80, 121, 201), borderRadius: BorderRadius.circular(6)),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  document['fyp-id'],
                                                                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              DataTable(
                                                                            dataTextStyle:
                                                                                const TextStyle(fontSize: 14),
                                                                            columns: const <DataColumn>[
                                                                              DataColumn(
                                                                                label: Expanded(
                                                                                  child: Text(
                                                                                    'Name',
                                                                                    style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              DataColumn(
                                                                                label: Expanded(
                                                                                  child: Text(
                                                                                    'Registration No',
                                                                                    style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                            rows: <DataRow>[
                                                                              DataRow(
                                                                                cells: <DataCell>[
                                                                                  DataCell(
                                                                                    Text(
                                                                                      document["mem1"],
                                                                                    ),
                                                                                  ),
                                                                                  DataCell(Text(
                                                                                    document["regno1"],
                                                                                  )),
                                                                                ],
                                                                              ),
                                                                              DataRow(
                                                                                cells: <DataCell>[
                                                                                  DataCell(Text(
                                                                                    document["mem2"],
                                                                                  )),
                                                                                  DataCell(Text(
                                                                                    document["regno2"],
                                                                                  )),
                                                                                ],
                                                                              ),
                                                                              DataRow(
                                                                                cells: <DataCell>[
                                                                                  DataCell(Text(
                                                                                    document["mem3"],
                                                                                  )),
                                                                                  DataCell(Text(
                                                                                    document["regno3"],
                                                                                  )),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                          thickness:
                                                                              1,
                                                                          height:
                                                                              5,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            15),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  "Role: ",
                                                                                  style: TextStyle(
                                                                                    fontSize: 18,
                                                                                    fontFamily: 'HelveticaNeue',
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                margin: EdgeInsets.only(left: 5),
                                                                                // margin: EdgeInsets.all(20),
                                                                                height: 40,
                                                                                width: 160,
                                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(6)),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    ('Main Supervision'),
                                                                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                "Co Supervisor: ",
                                                                                style: TextStyle(
                                                                                  fontSize: 18,
                                                                                  fontFamily: 'HelveticaNeue',
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              // margin: EdgeInsets.only(left: 14),
                                                                              height: 40,
                                                                              width: 160,
                                                                              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  document['co-supervisor'],
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),

                                                                  Divider(
                                                                    thickness:
                                                                        3,
                                                                    height: 5,
                                                                    color: Colors
                                                                            .grey[
                                                                        100],
                                                                  ),

                                                                  // method2()
                                                                ],
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                      MainSupervisionGroupsEvaluation(),

                                                      MidMarksheet(),

                                                      InternalGroupMarksheet(),

                                                      Container(
                                                        child: const Center(
                                                          child: Text('Results',
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                    ])),
                                          ]),
                                    )),
                              ),

                              /// Semester 8 Childrens

                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: double.infinity,
                                child: DefaultTabController(
                                    length: 5, // length of tabs
                                    initialIndex: 0,
                                    child: SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(8),
                                              child: TabBar(
                                                labelColor: Colors.blue,
                                                unselectedLabelColor:
                                                    Colors.black,
                                                indicatorSize:
                                                    TabBarIndicatorSize.label,
                                                indicatorPadding:
                                                    EdgeInsets.all(5),
                                                tabs: [
                                                  Tab(
                                                    child: Text(
                                                        'Supervisor Evaluation',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                  Tab(
                                                    child: Text(
                                                        'Internal Evaluation',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                  Tab(
                                                    child: Text(
                                                        'External Evaluation',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                  Tab(
                                                    child: Text('Results',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                color: Colors.white,
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 20,
                                                    right: 20,
                                                    left: 20),
                                                height: 500,
                                                child: TabBarView(
                                                    children: <Widget>[
                                                      // InternalEvaluators(),
                                                      SupervisorEvaluation8(),

                                                      Center(
                                                        child: Container(
                                                          width: 300,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Colors
                                                                  .blue[200]),
                                                          child: Center(
                                                            child: Text(
                                                                'No Group evaluated Yet',
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                        ),
                                                      ),

                                                      Center(
                                                        child: Container(
                                                          width: 300,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Colors
                                                                  .blue[200]),
                                                          child: Center(
                                                            child: Text(
                                                                'External Evaluation is Pending',
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                        ),
                                                      ),

                                                      Center(
                                                        child: Container(
                                                          width: 300,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Colors
                                                                  .blue[200]),
                                                          child: Center(
                                                            child: Text(
                                                                'Result Pending',
                                                                style: GoogleFonts.openSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                        ),
                                                      ),
                                                    ])),
                                          ]),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
