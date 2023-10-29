// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens2/8-Evaluations/8-Internal/8-Internal-evaluation-form.dart';
import 'package:flutter_application_1/screens2/8-Evaluations/8-Internal/8-internal-evaluation-results.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Evaluation-Form.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Evaluation-Result.dart';
import 'package:flutter_application_1/screens2/student-screens-2/homepage.dart';
import 'package:flutter_application_1/screens/evaluation_screens/EvaluationForm.dart';
import 'package:flutter_application_1/screens/evaluation_screens/evaluation_results.dart';
import 'package:google_fonts/google_fonts.dart';

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
  {"userId": "cpMIGGn4ZEfXe77uB4UOkJTQtu12", "name": "Dr. Abdul Qayoom"},
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

class MyExternalGroups extends StatefulWidget {
  @override
  _MyExternalGroupsState createState() => _MyExternalGroupsState();
}

class _MyExternalGroupsState extends State<MyExternalGroups> {
  late Future<UserData> _userData;
  Map<String, dynamic>? userData;

  final beforeEvaluationColor = Color(0xffbbbbbb); // light gray
  final afterEvaluationColor = Color(0xff4caf50);

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

  @override
  void initState() {
    super.initState();
    _userData = getUserData();
    fetchUserData();
  }

  Future<UserData> getUserData() async {
    var user = await FirebaseAuth.instance.currentUser;

    // var userId = user!.uid;
    var userId = 'A5Yb79Mx1oYCD4yv6iBVpERJMP33';
    for (var i = 0; i < users.length; i++) {
      if (users[i]['userId'] == userId) {
        var userData = UserData.fromMap(users[i]);

        return userData;
      }
    }

    throw Exception('No UserData found for current user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _userData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('/External/accounts/External-Evaluation')
                      .doc('evaluators')
                      .collection(userData!['Name'])
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
                            Text("No groups allocated yet! ",
                                style: GoogleFonts.roboto(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
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
                    return SafeArea(
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            padding: EdgeInsets.only(top: 30),
                            width: double.infinity,
                            color: Color(0xFF0D46BB),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('External Evaluation',
                                  style: GoogleFonts.roboto(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 10, right: 0),
                            child: Container(
                              height: 400,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20, bottom: 20),
                                    child: Text('Assigned Groups',
                                        style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  DataTable(
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        "FYP ID",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Supervisor",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Co-Supervisor",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Project Title",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Action",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ))
                                    ],
                                    rows: snapshot.data!.docs.map((
                                      DocumentSnapshot document,
                                    ) {
                                      return DataRow(
                                        cells: [
                                          DataCell(Text(document['fyp-id'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                          DataCell(Text(
                                              document['main-supervisor'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                          DataCell(Text(
                                              document['co-supervisor'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                          DataCell(Text(
                                              document['accepted-idea'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                          DataCell(FutureBuilder(
                                              future: _userData,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  return StreamBuilder<
                                                      QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            '/External/accounts/External-Evaluation')
                                                        .doc('evaluators')
                                                        .collection(document[
                                                            'external-evaluator1'])
                                                        .doc(document.id)
                                                        .collection(
                                                            'External-Evaluation-Results')
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return CircularProgressIndicator();
                                                      }

                                                      if (snapshot.data!.docs
                                                          .isNotEmpty) {
                                                        return ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      afterEvaluationColor),
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return FractionallySizedBox(
                                                                  heightFactor:
                                                                      1.0,
                                                                  child:
                                                                      AlertDialog(
                                                                          content:
                                                                              Container(
                                                                    width: 1100,
                                                                    height: 700,
                                                                    child: ExternalEvaluationResults(
                                                                        snap:
                                                                            document),
                                                                  )),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Text("Results",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              )),
                                                          // color: Colors.grey,
                                                        );
                                                      }
                                                      return ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          22,
                                                                      vertical:
                                                                          10)
                                                              // primary:
                                                              //     beforeEvaluationColor),
                                                              ),
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return FractionallySizedBox(
                                                                  heightFactor:
                                                                      1.0,
                                                                  child:
                                                                      AlertDialog(
                                                                          content:
                                                                              Container(
                                                                    width: 1100,
                                                                    height: 700,
                                                                    child: ExternalEvaluationForm(
                                                                        documentSnapshot:
                                                                            document),
                                                                  )),
                                                                );
                                                              },
                                                            );
                                                            // Perform evaluation and store in firestore
                                                          },
                                                          child: Text(
                                                              'Evaluate',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              )));
                                                    },
                                                  );
                                                }
                                                return Text('');
                                              })),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
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
}
