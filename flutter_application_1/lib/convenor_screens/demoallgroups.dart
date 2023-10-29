// ignore_for_file: avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/groupsList.dart';

class demogroups extends StatefulWidget {
  @override
  State<demogroups> createState() => _demogroupsState();
}

class _demogroupsState extends State<demogroups> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var supervisor;
  var cosupervisor;

  String get path => ConvenorPath('A5Yb79Mx1oYCD4yv6iBVpERJMP33');
  List get listitem => SupervisorList('mknWkcTTvreOiUPUJdKaWRrBuAG3');

  ConvenorPath(String value) {
    String path = '';
    if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
      return path =
          '/Convenor/classes/BS Information Technology/groups/group-members';
    } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
      return path =
          '/Convenor/classes/BS Computer Science/groups/group-members';
    } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
      return path =
          '/Convenor/classes/BS Software Engineering/groups/group-members';
    } else {
      return null;
    }
  }

  SupervisorList(String value) {
    List listitem = [];
    if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
      return listitem = [
        "Dr. Abdul Qayyum",
        "Mr. Shahbaz Ahmad Sahi",
        "Dr. Rehan Ashraf",
        "Mr. Waqar Ahmad",
        "Dr. Toqeer Mehmood",
        "Ms. Sana Ikram"
      ];
    } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
      return listitem = [
        "Dr. Asif Habib",
        "Mr. Shahbaz Ahmad",
        "Dr. Suleman Naqvi",
        "Dr M Hamid",
        "Mr M Naeem"
      ];
    } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
      return listitem = [
        "Mr. M Shahid",
        "Dr M Adeel",
        "Dr M Asif",
        "Mr Arsal Mehmood",
        "Ms. Sara Naeem"
      ];
    }
  }

  addsupervisor(String doc, List listitem, String path) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Main Supervisor",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Color.fromARGB(255, 219, 220, 223)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 14, top: 3, bottom: 3, right: 14),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    focusColor: Colors.grey[200],
                    hint: const Text(
                      "Choose Main Supervisor",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    value: supervisor,
                    onChanged: (newValue) {
                      setState(() {
                        supervisor = newValue;
                      });
                    },
                    items: listitem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const Text(
              "Co Supervisor",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 45,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color.fromARGB(255, 223, 219, 219)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 14, top: 3, bottom: 3, right: 14),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    focusColor: Colors.grey[200],
                    hint: const Text(
                      "Choose Co-Supervisor",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    value: cosupervisor,
                    onChanged: (newValue) {
                      setState(() {
                        cosupervisor = newValue;
                      });
                    },
                    items: listitem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              var db = FirebaseFirestore.instance
                  .collection(path)
                  .doc(doc)
                  .collection('supervisor');

              db.add({
                "main-supervisor": supervisor,
                "co-supervisor": cosupervisor,
              });

              var clc =
                  FirebaseFirestore.instance.collection(path).doc(doc).update({
                'main-supervisor': supervisor,
                "co-supervisor": cosupervisor,
              });

              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text(
                          "Supervisor Allocation",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                        content: const Text("Successful",
                            style: TextStyle(
                                color: Color.fromARGB(255, 20, 107, 23))),
                      ));
            });
          },
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 57, 120, 125),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          child: const Text('Allocate'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(path)
                  .orderBy('fyp-id')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Card(
                      color: Colors.grey[200],
                      // elevation: 8.0,
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                {
                                  String abc = document.id;
                                  String section = document["class"];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              80, 40, 80, 40),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 50,
                                                left: 20,
                                                right: 20,
                                                bottom: 50),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 94, 99, 146),
                                                        ),
                                                        child: Text(
                                                          document["fyp-id"],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Field",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      document["field"],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 1200,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 20, 40, 0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: DataTable(
                                                    dataTextStyle:
                                                        const TextStyle(
                                                            fontSize: 14),
                                                    columns: const <DataColumn>[
                                                      DataColumn(
                                                        label: Expanded(
                                                          child: Text(
                                                            'Sr No.',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Expanded(
                                                          child: Text(
                                                            'Name',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Expanded(
                                                          child: Text(
                                                            'Registration No',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    rows: <DataRow>[
                                                      DataRow(
                                                        cells: <DataCell>[
                                                          const DataCell(
                                                              Text('1')),
                                                          DataCell(Text(
                                                            document["mem1"],
                                                          )),
                                                          DataCell(Text(
                                                            document["regno1"],
                                                          )),
                                                        ],
                                                      ),
                                                      DataRow(
                                                        cells: <DataCell>[
                                                          const DataCell(
                                                              Text('2')),
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
                                                          const DataCell(
                                                              Text('3')),
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
                                                const Divider(
                                                  height: 1,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                fetchdata(document.id),
                                              ],
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      const Divider(
                                        height: 1,
                                      ),
                                    ],
                                  );
                                }
                              }),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            ListStudentPage())));
                              },
                              child: const Text('View List'))
                        ],
                      ),
                    ),
                  );
                }
              })),
    );
  }

  fetchdata(String value) {
    return SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(path)
                .doc(value)
                .collection('supervisor')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data?.size == 0) {
                return addsupervisor(value, listitem, path);
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot db = snapshot.data!.docs[index];

                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Main Supervisor",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              db['main-supervisor'],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const Text(
                              "Co-supervisor",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              db['co-supervisor'],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }

                  return addsupervisor(value, listitem, path);
                },
              );
            }));
  }

  updatesupervisor(String doc, List listitem, String path) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Main Supervisor",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color.fromARGB(255, 223, 219, 219)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 14, top: 3, bottom: 3, right: 14),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    focusColor: Colors.grey[200],
                    hint: const Text(
                      "Choose Main Supervisor",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    value: supervisor,
                    onChanged: (newValue) {
                      setState(() {
                        supervisor = newValue;
                      });
                    },
                    items: listitem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const Text(
              "Co Supervisor",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 45,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color.fromARGB(255, 223, 219, 219)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 14, top: 3, bottom: 3, right: 14),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    focusColor: Colors.grey[200],
                    hint: const Text(
                      "Choose Co-Supervisor",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    value: cosupervisor,
                    onChanged: (newValue) {
                      setState(() {
                        cosupervisor = newValue;
                      });
                    },
                    items: listitem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              var db = FirebaseFirestore.instance
                  .collection(path)
                  .doc(doc)
                  .collection('supervisor');

              db.add({
                "main-supervisor": supervisor,
                "co-supervisor": cosupervisor,
              });

              var clc =
                  FirebaseFirestore.instance.collection(path).doc(doc).update({
                'main-supervisor': supervisor,
                "co-supervisor": cosupervisor,
              });

              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text(
                          "Supervisor Allocation",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                        content: const Text("Successful",
                            style: TextStyle(
                                color: Color.fromARGB(255, 20, 107, 23))),
                      ));
            });
          },
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 57, 120, 125),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          child: const Text('Allocate'),
        )
      ],
    );
  }
}
