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
import 'package:flutter_application_1/screens2/External%20Evaluation/BSIT-Overall-Result.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens2/8-Evaluations/8-Internal/8-BSIT-Results-till-Internal.dart';
import '../screens2/8-Evaluations/8-Internal/final-internal-class-result.dart';
import '../screens2/External Evaluation/BSIT-External-Final-Result.dart';

class BSITGroups extends StatefulWidget {
  const BSITGroups({super.key});

  @override
  State<BSITGroups> createState() => _BSITGroupsState();
}

class _BSITGroupsState extends State<BSITGroups> {
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
                      Row(
                        children: [
                          Text(
                            'Total Groups:  ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'HelveticaNeue',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 32,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.blue,
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
                                    fontSize: 16, fontWeight: FontWeight.w600)),
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
                    Expanded(
                      child: TabBarView(children: [
                        Container(
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
                                          unselectedLabelColor: Colors.black,
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          indicatorPadding: EdgeInsets.all(5),
                                          tabs: [
                                            Tab(
                                              child: Text('Groups',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Tab(
                                              child: Text('Supervisors',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Tab(
                                              child: Text(
                                                  'Supervisor Evaluation',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Tab(
                                              child: Text('Internal Evaluation',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Tab(
                                              child: Text('Results',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
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
                                          child: TabBarView(children: <Widget>[
                                            // InternalEvaluators(),

                                            Container(
                                              child: ListView(
                                                shrinkWrap: true,
                                                children: snapshot.data!.docs
                                                    .map((document) {
                                                  final mainSupervisor =
                                                      document[
                                                          'main-supervisor'];
                                                  final coSupervisor =
                                                      document['co-supervisor'];
                                                  final hasData =
                                                      mainSupervisor != null &&
                                                          coSupervisor !=
                                                              null &&
                                                          mainSupervisor
                                                              .isNotEmpty &&
                                                          coSupervisor
                                                              .isNotEmpty;

                                                  return Card(
                                                    margin: EdgeInsets.all(20),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            20),
                                                                    height: 40,
                                                                    width: 120,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            80,
                                                                            121,
                                                                            201),
                                                                        borderRadius:
                                                                            BorderRadius.circular(6)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        document[
                                                                            'fyp-id'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: PopupMenuButton<
                                                                        String>(
                                                                      itemBuilder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return <
                                                                            PopupMenuEntry<String>>[
                                                                          PopupMenuItem<
                                                                              String>(
                                                                            value:
                                                                                'delete',
                                                                            child:
                                                                                Text('Delete'),
                                                                          ),
                                                                        ];
                                                                      },
                                                                      onSelected:
                                                                          (String
                                                                              value) async {
                                                                        if (value ==
                                                                            'delete') {
                                                                          QuerySnapshot<
                                                                              Map<String,
                                                                                  dynamic>> querySnapshot2 = await FirebaseFirestore
                                                                              .instance
                                                                              .collection('supervisor')
                                                                              .doc('supervisor')
                                                                              .collection(document['main-supervisor'])
                                                                              .doc('groups')
                                                                              .collection('main-supervision')
                                                                              .where('group-id', isEqualTo: document['fyp-id'])
                                                                              .limit(1)
                                                                              .get();

                                                                          if (querySnapshot2
                                                                              .docs
                                                                              .isNotEmpty) {
                                                                            String
                                                                                documentId =
                                                                                querySnapshot2.docs.first.reference.id;
                                                                            await querySnapshot2.docs.first.reference.delete();
                                                                            print('Member document deleted');
                                                                          } else {
                                                                            print('Member document not found');
                                                                          }
                                                                          ;

                                                                          QuerySnapshot<
                                                                              Map<String,
                                                                                  dynamic>> querySnapshot3 = await FirebaseFirestore
                                                                              .instance
                                                                              .collection('supervisor')
                                                                              .doc('supervisor')
                                                                              .collection(document['co-supervisor'])
                                                                              .doc('groups')
                                                                              .collection('co-supervision')
                                                                              .where('group-id', isEqualTo: document['fyp-id'])
                                                                              .limit(1)
                                                                              .get();

                                                                          if (querySnapshot3
                                                                              .docs
                                                                              .isNotEmpty) {
                                                                            String
                                                                                documentId =
                                                                                querySnapshot3.docs.first.reference.id;
                                                                            await querySnapshot3.docs.first.reference.delete();
                                                                            print('Member document deleted');
                                                                          } else {
                                                                            print('Member document not found');
                                                                          }

                                                                          QuerySnapshot<
                                                                              Map<String,
                                                                                  dynamic>> querySnapshot = await FirebaseFirestore
                                                                              .instance
                                                                              .collectionGroup('members')
                                                                              .where('group-id', isEqualTo: document['fyp-id'])
                                                                              .limit(1)
                                                                              .get();

                                                                          if (querySnapshot
                                                                              .docs
                                                                              .isNotEmpty) {
                                                                            String
                                                                                documentId =
                                                                                querySnapshot.docs.first.reference.id;
                                                                            await querySnapshot.docs.first.reference.delete();
                                                                            print('Member document deleted');
                                                                          } else {
                                                                            print('Member document not found');
                                                                          }

                                                                          QuerySnapshot<
                                                                              Map<String,
                                                                                  dynamic>> querySnapshot4 = await FirebaseFirestore
                                                                              .instance
                                                                              .collectionGroup('group-members')
                                                                              .where('fyp-id', isEqualTo: document['fyp-id'])
                                                                              .limit(1)
                                                                              .get();

                                                                          if (querySnapshot4
                                                                              .docs
                                                                              .isNotEmpty) {
                                                                            String
                                                                                documentId =
                                                                                querySnapshot4.docs.first.reference.id;
                                                                            await querySnapshot4.docs.first.reference.delete();
                                                                            print('Member document deleted');
                                                                          } else {
                                                                            print('Member document not found');
                                                                          }
                                                                          ;
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    DataTable(
                                                                  dataTextStyle:
                                                                      const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                  columns: const <
                                                                      DataColumn>[
                                                                    DataColumn(
                                                                      label:
                                                                          Expanded(
                                                                        child:
                                                                            Text(
                                                                          'Name',
                                                                          style: TextStyle(
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Expanded(
                                                                        child:
                                                                            Text(
                                                                          'Registration No',
                                                                          style: TextStyle(
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  rows: <
                                                                      DataRow>[
                                                                    DataRow(
                                                                      cells: <
                                                                          DataCell>[
                                                                        DataCell(
                                                                          Text(
                                                                            document["mem1"],
                                                                          ),
                                                                        ),
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "regno1"],
                                                                        )),
                                                                      ],
                                                                    ),
                                                                    DataRow(
                                                                      cells: <
                                                                          DataCell>[
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "mem2"],
                                                                        )),
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "regno2"],
                                                                        )),
                                                                      ],
                                                                    ),
                                                                    DataRow(
                                                                      cells: <
                                                                          DataCell>[
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "mem3"],
                                                                        )),
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "regno3"],
                                                                        )),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider(
                                                                thickness: 1,
                                                                height: 5,
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        Visibility(
                                                          visible: hasData,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    15),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "Main Supervision: ",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontFamily:
                                                                            'HelveticaNeue',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                5),
                                                                    // margin: EdgeInsets.all(20),
                                                                    height: 40,
                                                                    width: 160,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .blue,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        document[
                                                                            'main-supervisor'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 16),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "Co Supervisor: ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontFamily:
                                                                              'HelveticaNeue',
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      // margin: EdgeInsets.only(left: 14),
                                                                      height:
                                                                          40,
                                                                      width:
                                                                          160,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .blue,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8)),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          document[
                                                                              'co-supervisor'],
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          replacement: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              13),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                              .blue[
                                                                          300],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  height: 50,
                                                                  child: Text(
                                                                    'Supervisors have not allocated yet',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'HelveticaNeue',
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 60,
                                                              ),
                                                              ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              25,
                                                                          vertical:
                                                                              22)),
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Text('Allocate Supervisor'),
                                                                          content:
                                                                              Container(
                                                                            height:
                                                                                250,
                                                                            width:
                                                                                400,
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: 30,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    const Text(
                                                                                      "Main Supervisor",
                                                                                      style: TextStyle(
                                                                                        fontSize: 18,
                                                                                        fontFamily: 'HelveticaNeue',
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 30,
                                                                                    ),
                                                                                    Container(
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.only(left: 14, top: 3, bottom: 3, right: 14),
                                                                                        child: StatefulBuilder(
                                                                                          builder: (BuildContext context, StateSetter setState) {
                                                                                            return DropdownButtonHideUnderline(
                                                                                              child: DropdownButton<String>(
                                                                                                focusColor: Colors.grey[200],
                                                                                                value: selectedMainSupervisor,
                                                                                                hint: Text(
                                                                                                  'Select Main Supervisor',
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 14,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                                ),
                                                                                                onChanged: (String? newValue) {
                                                                                                  setState(() {
                                                                                                    selectedMainSupervisor = newValue;
                                                                                                  });
                                                                                                },
                                                                                                items: listItems.map<DropdownMenuItem<String>>((String value) {
                                                                                                  return DropdownMenuItem<String>(
                                                                                                    value: value,
                                                                                                    child: Text(value),
                                                                                                  );
                                                                                                }).toList(),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 30,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    const Text(
                                                                                      "Co-Supervisor",
                                                                                      style: TextStyle(
                                                                                        fontSize: 18,
                                                                                        fontFamily: 'HelveticaNeue',
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 45,
                                                                                    ),
                                                                                    Container(
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.only(left: 14, top: 3, bottom: 3, right: 14),
                                                                                        child: StatefulBuilder(
                                                                                          builder: (BuildContext context, StateSetter setState) {
                                                                                            return DropdownButtonHideUnderline(
                                                                                              child: DropdownButton<String>(
                                                                                                value: selectedCoSupervisor,
                                                                                                focusColor: Colors.grey[200],
                                                                                                hint: Text(
                                                                                                  'Select Co-Supervisor',
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 14,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                                ),
                                                                                                onChanged: (String? newValue) {
                                                                                                  setState(() {
                                                                                                    selectedCoSupervisor = newValue;
                                                                                                  });
                                                                                                },
                                                                                                items: listItems.map<DropdownMenuItem<String>>((String value) {
                                                                                                  return DropdownMenuItem<String>(
                                                                                                    value: value,
                                                                                                    child: Text(value),
                                                                                                  );
                                                                                                }).toList(),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 30,
                                                                                ),
                                                                                Center(
                                                                                  child: ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 55, vertical: 22)),
                                                                                    onPressed: () {
                                                                                      print(selectedMainSupervisor);
                                                                                      print(selectedCoSupervisor);

                                                                                      var db1 = FirebaseFirestore.instance.collection("/Convenor/classes/BS Information Technology/groups/group-members").doc(document.id).update({
                                                                                        "main-supervisor": selectedMainSupervisor,
                                                                                        "co-supervisor": selectedCoSupervisor,
                                                                                      });

                                                                                      var supervisordata = FirebaseFirestore.instance.collection('supervisor').doc('supervisor').collection(selectedMainSupervisor!).doc('groups').collection('main-supervision');

                                                                                      supervisordata.add({
                                                                                        'accepted-idea': '',
                                                                                        'fyp-id': document['fyp-id'],
                                                                                        "mem1": document['mem1'],
                                                                                        "regno1": document['regno1'],
                                                                                        "mem2": document['mem2'],
                                                                                        "regno2": document['regno2'],
                                                                                        "mem3": document['mem3'],
                                                                                        "regno3": document['regno3'],
                                                                                        "class": document['class'],
                                                                                        "field": document['field'],
                                                                                        "co-supervisor": selectedCoSupervisor,
                                                                                        "main-supervisor": selectedMainSupervisor,
                                                                                        'internal1': '',
                                                                                        'internal2': '',
                                                                                      });

                                                                                      var cosupervisordata = FirebaseFirestore.instance.collection('supervisor').doc('supervisor').collection(selectedCoSupervisor!).doc('groups').collection('co-supervision');

                                                                                      cosupervisordata.add({
                                                                                        'accepted-idea': '',
                                                                                        'fyp-id': document['fyp-id'],
                                                                                        "mem1": document['mem1'],
                                                                                        "regno1": document['regno1'],
                                                                                        "mem2": document['mem2'],
                                                                                        "regno2": document['regno2'],
                                                                                        "mem3": document['mem3'],
                                                                                        "regno3": document['regno3'],
                                                                                        "class": document['class'],
                                                                                        "field": document['field'],
                                                                                        "co-supervisor": selectedCoSupervisor,
                                                                                        "main-supervisor": selectedMainSupervisor,
                                                                                        'internal1': '',
                                                                                        'internal2': '',
                                                                                      });

                                                                                      Navigator.pop(context);
                                                                                      // db1.add({
                                                                                      //   "Main Supervisor":
                                                                                      //       supervisor,
                                                                                      //   "Co-Supervisor":
                                                                                      //       cosupervisor,
                                                                                      // });
                                                                                    },
                                                                                    child: Text('Allocate'),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop(); // Close the dialog
                                                                              },
                                                                              child: Text('Close'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                      'Allocate Now'))
                                                            ],
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 20,
                                                        ),

                                                        Divider(
                                                          thickness: 3,
                                                          height: 5,
                                                          color:
                                                              Colors.grey[100],
                                                        ),

                                                        // method2()
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            SupervisorsList(),

                                            BSIT_MID_EVALUATION(),

                                            InternalClassResult(),
                                            BSITFinalResults(),
                                          ])),
                                    ]),
                              )),
                        ),
                        Container(
                          width: 600,
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
                                          unselectedLabelColor: Colors.black,
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          indicatorPadding: EdgeInsets.all(5),
                                          tabs: [
                                            Tab(
                                              child: Text(
                                                  'Supervisor Evaluation',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Tab(
                                              child: Text('Internal Evaluation',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Tab(
                                              child: Text('Internal Results',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Tab(
                                              child: Text('External Evaluation',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Tab(
                                              child: Text('Final Results',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: TabBarView(children: <Widget>[
                                            BSIT_MID_EVALUATION_8(),
                                            FinalInternalClassResult(),
                                            BSIT_RESULTS_TILL_INTERNAL(),
                                            FinalExternalClassResult(),
                                            BSITOverallResults(),
                                          ])),
                                    ]),
                              )),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ]));
        });
  }
}
