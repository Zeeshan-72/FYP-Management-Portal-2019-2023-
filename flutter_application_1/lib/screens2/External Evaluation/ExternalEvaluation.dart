// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, camel_case_types, unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Supervisors_screens/supervisor-evaluation.dart';
import 'package:flutter_application_1/convenor_screens/8-bsit-supervisor-evaluation.dart';
import 'package:flutter_application_1/convenor_screens/bsit-final-results.dart';
import 'package:flutter_application_1/convenor_screens/bsit-supervisor-evaluation.dart';
import 'package:flutter_application_1/convenor_screens/bsit-supervisors.dart';
import 'package:flutter_application_1/screens/evaluation_screens/Internal-class-result.dart';
import 'package:flutter_application_1/screens/evaluation_screens/InternalGroupResult.dart';
import 'package:flutter_application_1/screens/evaluation_screens/mid-marksheet.dart';
import 'package:flutter_application_1/screens/evaluation_screens/myinternal-groups.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/BSIT-External-Final-Result.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Group-Allocation.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/external-accounts.dart';
import 'package:google_fonts/google_fonts.dart';

class ExternalEvaluation_2 extends StatefulWidget {
  const ExternalEvaluation_2({super.key});

  @override
  State<ExternalEvaluation_2> createState() => _ExternalEvaluation_2State();
}

class _ExternalEvaluation_2State extends State<ExternalEvaluation_2> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String get collection => collectionname(firebaseUser!.uid);

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

  bool isVisible = true;
  var length;

  final List<String> listItems = [
    "Dr. Abdul Qayyum",
    "Mr. Shahbaz Ahmad Sahi",
    "Dr. Rehan Ashraf",
    "Mr. Waqar Ahmad",
    "Dr. Toqeer Mehmood",
    "Ms. Sara Masood"
  ];

  String? selectedMainSupervisor;
  String? selectedCoSupervisor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                "/Convenor/classes/BS Information Technology/groups/group-members")
            .orderBy('fyp-id')
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
                    "No groups submitted yet! ",
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
              child: Column(children: [
            Container(
              height: 150,
              margin: EdgeInsets.only(top: 1),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 80, 121, 201),
              ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Colors.blue,
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
                                    color: Colors.blue,
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'External Evaluations  ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 600,
                  child: DefaultTabController(
                      length: 3, // length of tabs
                      initialIndex: 0,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(8),
                                child: TabBar(
                                  labelColor: Colors.blue,
                                  unselectedLabelColor: Colors.black,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicatorPadding: EdgeInsets.all(5),
                                  tabs: [
                                    Tab(
                                      child: Text('Manage Accounts',
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Tab(
                                      child: Text('External Groups',
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Tab(
                                      child: Text('External Results',
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: TabBarView(children: <Widget>[
                                    ExternalEvaluatorData(),
                                    ExternalGroupAllocation(),
                                    FinalExternalClassResult(),
                                  ])),
                            ]),
                      )),
                ),
              ],
            )
          ]));
        });
  }
}
