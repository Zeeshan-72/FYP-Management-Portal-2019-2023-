// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_application_1/student_screens/member_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: Mygroup(),
    );
  }
}

class Mygroup extends StatefulWidget {
  const Mygroup({super.key});

  @override
  State<Mygroup> createState() => _MygroupState();
}

class _MygroupState extends State<Mygroup> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  var _supervisor;

  var _cosupervisor;
  var fypid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Group"),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 234, 235),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("FYP")
              .doc("fyp(19-23)")
              .collection('groups')
              .doc(firebaseUser!.uid)
              .collection("members")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.data?.size == 0) {
              return Center(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
                width: 600,
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your group isn't registered yet!",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Click here to Register"),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemberForm(),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 20),
                              textStyle: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          child: Text('Register now'),
                        )
                      ],
                    )
                  ],
                ),
              ));
            }
            return Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((document) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50, left: 45),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "FYP-ID",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 230,
                                ),
                                Text(
                                  document["group-id"],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                // fypid = document["group-id"],
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  "Field",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  document["field"],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1200,
                            margin: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: DataTable(
                              dataTextStyle: const TextStyle(fontSize: 14),
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Sr No.',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
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
                                    DataCell(Text('1')),
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
                                    const DataCell(Text('2')),
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
                                    const DataCell(Text('3')),
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
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // method1()
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }),
    );
  }

  method1() {
    return SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Convenor')
                .doc('classes')
                .collection('BS Information Technology')
                .doc('groups')
                .collection('group-members')
                .where(
                  'fyp-id',
                )
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
