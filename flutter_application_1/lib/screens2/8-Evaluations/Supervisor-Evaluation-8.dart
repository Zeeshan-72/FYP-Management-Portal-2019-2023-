// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/evaluation_screens/MidEvaluationForm.dart';
import 'package:flutter_application_1/screens2/8-Evaluations/FinalEvaluationForm.dart';
import 'package:flutter_application_1/screens2/8-Evaluations/FinalEvaluationResults.dart';
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

class SupervisorEvaluation8 extends StatefulWidget {
  const SupervisorEvaluation8({super.key});

  @override
  State<SupervisorEvaluation8> createState() => _SupervisorEvaluation8State();
}

class _SupervisorEvaluation8State extends State<SupervisorEvaluation8> {
  late Future<UserData> _userData;

  final beforeEvaluationColor = Color(0xffbbbbbb); // light gray
  final afterEvaluationColor = Color(0xff4caf50);

  @override
  void initState() {
    super.initState();
    _userData = getUserData();
  }

  var row;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FutureBuilder(
            future: _userData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('supervisor')
                      .doc('supervisor')
                      .collection(snapshot.data.name)
                      .doc('groups')
                      .collection('main-supervision')
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
                    final data = snapshot.data!.docs;
                    return Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: IntrinsicWidth(
                          child: Container(
                            padding: EdgeInsets.all(13),
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, bottom: 20),
                                  child: Text('Final Evaluation',
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                ),
                                DataTable(
                                  dataRowHeight: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 238, 238, 238),
                                        width: 1.0),
                                  ),
                                  columns: [
                                    DataColumn(
                                        label: Text('Sr#',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Group id',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Co-Supervisor',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Title',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Action',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Status (Internal)',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    // Add more DataColumn widgets for additional columns
                                  ],
                                  rows: List.generate(data.length, (index) {
                                    final doc = data[index];

                                    // Access additional columns if needed

                                    return DataRow(
                                        color: index % 2 == 0
                                            ? MaterialStateColor.resolveWith(
                                                (states) => Color.fromARGB(
                                                    255, 233, 236, 239))
                                            : null,
                                        cells: [
                                          DataCell(Container(
                                            child: Text((index + 1).toString(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15)),
                                          )),
                                          DataCell(Container(
                                            width: 100,
                                            child: Text(doc['fyp-id'],
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15)),
                                          )),
                                          DataCell(Container(
                                            width: 150,
                                            child: Text(doc['co-supervisor'],
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15)),
                                          )),
                                          DataCell(Container(
                                            width: 300,
                                            child: Text(doc['accepted-idea'],
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15)),
                                          )),
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
                                                            'supervisor')
                                                        .doc('supervisor')
                                                        .collection(
                                                            snapshot.data.name)
                                                        .doc('groups')
                                                        .collection(
                                                            'main-supervision')
                                                        .doc(doc.id)
                                                        .collection(
                                                            'Final-evaluation')
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      row = snapshot.data!.docs;
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
                                                                    child: FinalEvaluationResults(
                                                                        snap:
                                                                            doc),
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
                                                                    child: FinalEvaluationForm(
                                                                        documentSnapshot:
                                                                            doc),
                                                                  )),
                                                                );
                                                              },
                                                            );
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
                                          DataCell(
                                            FutureBuilder(
                                              future: _userData,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  return StreamBuilder<
                                                      QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'supervisor')
                                                        .doc('supervisor')
                                                        .collection(
                                                            snapshot.data.name)
                                                        .doc('groups')
                                                        .collection(
                                                            'main-supervision')
                                                        .doc(doc.id)
                                                        .collection(
                                                            'Final-evaluation')
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return CircularProgressIndicator();
                                                      }
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return CircularProgressIndicator();
                                                      }
                                                      if (snapshot
                                                          .data!.docs.isEmpty) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[350],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2)),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    13.0),
                                                            child: Text(
                                                              ('Pending'),
                                                              style: GoogleFonts.openSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      final data = snapshot
                                                              .data!.docs.first
                                                              .data()
                                                          as Map<String,
                                                              dynamic>;
                                                      final status = data[
                                                          'overall-supervisory-status'];

                                                      Color containerColor;
                                                      Color textColor;
                                                      String statusText;

                                                      if (status ==
                                                          'Presentable') {
                                                        containerColor =
                                                            Color.fromRGBO(102,
                                                                187, 106, 1);
                                                        textColor =
                                                            Colors.white;
                                                        statusText =
                                                            'Presentable';
                                                      } else if (status ==
                                                          'Not Presentable') {
                                                        containerColor =
                                                            Color.fromRGBO(
                                                                239, 83, 80, 1);
                                                        textColor =
                                                            Colors.white;
                                                        statusText =
                                                            'Not Presentable';
                                                      } else {
                                                        containerColor =
                                                            Colors.grey;
                                                        textColor =
                                                            Colors.black;
                                                        statusText = 'Pending';
                                                      }

                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: containerColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  13.0),
                                                          child: Text(
                                                            statusText,
                                                            style: GoogleFonts
                                                                .openSans(
                                                              color: textColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } else if (snapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator();
                                                } else {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[350],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(13.0),
                                                      child: Text(
                                                        ('Pending'),
                                                        style: GoogleFonts
                                                            .openSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          )
                                        ]);
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Text('Something went wrong');
            }));
  }

  Future<UserData> getUserData() async {
    var user = await FirebaseAuth.instance.currentUser;
    // var userId = 'RndCDn7CRKRz7uvzysR89Iga07f1';
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
