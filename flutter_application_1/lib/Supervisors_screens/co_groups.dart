// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class co_groups extends StatefulWidget {
  const co_groups({super.key});

  @override
  State<co_groups> createState() => _co_groupsState();
}

class _co_groupsState extends State<co_groups> {
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

  @override
  Widget build(BuildContext context) {
    return method1();
  }

  method1() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                "/Convenor/classes/BS Information Technology/groups/group-members")
            .where("co-supervisor", isEqualTo: collection)
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
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((document) {
                    return Card(
                        margin: EdgeInsets.all(20),
                        child: Column(children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(20),
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 80, 121, 201),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Center(
                                        child: Text(
                                          document['fyp-id'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  child: DataTable(
                                    dataTextStyle:
                                        const TextStyle(fontSize: 14),
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Registration No',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold),
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
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 15, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
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
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Center(
                                            child: Text(
                                              ('Co Supervision'),
                                              style: TextStyle(
                                                  color: Colors.white,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Main Supervisor: ",
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
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                              child: Text(
                                                document['main-supervisor'],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                // method2()
                              ],
                            ),
                          )
                        ]));
                  }).toList(),
                ),
              ],
            ),
          );
        });
  }

  method2() {
    return SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Convenor')
                .doc('classes')
                .collection('BS Information Technology')
                .doc('groups')
                .collection('group-members')
                .where('fyp-id', isEqualTo: '23-FYP-304')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data?.size == 0) {
                return const Text('Supervisors not allocated yet');
              }
              return Column(
                children: [
                  ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                const Text('Main Supervisor'),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  document["main-supervisor"],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text('Co Supervisor'),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  document["co-supervisor"],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        );
                      }).toList()),
                ],
              );
            }));
  }
}
