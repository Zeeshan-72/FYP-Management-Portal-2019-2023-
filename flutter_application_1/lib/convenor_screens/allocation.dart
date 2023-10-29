// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllocationScreen extends StatefulWidget {
  const AllocationScreen({super.key});

  @override
  State<AllocationScreen> createState() => _AllocationScreenState();
}

class _AllocationScreenState extends State<AllocationScreen> {
  var supervisor;
  var cosupervisor;
  List listitem = [
    "Dr. Abdul Qayyum",
    "Mr. Shahbaz Ahmad Sahi",
    "Dr. Rehan Ashraf",
    "Mr. Waqar Ahmad",
    "Dr. Toqeer Mehmood",
    "Ms. Sara Masood"
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Groups").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index1) {
                DocumentSnapshot document1 = snapshot.data!.docs[index1];

                {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 170,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple,
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext contex) =>
                                      StatefulBuilder(builder:
                                          (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                    return AlertDialog(
                                        backgroundColor: Colors.grey[200],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        title: const Center(
                                            child: Text(
                                          "Supervisor Allocation",
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        )),
                                        content: Container(
                                          width: 450,
                                          height: 250,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              Row(
                                                children: [
                                                  const Text("Main Supervisor"),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color: const Color
                                                                .fromARGB(255,
                                                            223, 219, 219)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              top: 3,
                                                              bottom: 3,
                                                              right: 14),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          focusColor:
                                                              Colors.grey[200],
                                                          hint: const Text(
                                                            "Choose Main Supervisor",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          value: supervisor,
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              supervisor =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: listitem
                                                              .map((valueItem) {
                                                            return DropdownMenuItem(
                                                              value: valueItem,
                                                              child: Text(
                                                                  valueItem),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  const Text("Co-Supervisor"),
                                                  const SizedBox(
                                                    width: 45,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color: const Color
                                                                .fromARGB(255,
                                                            223, 219, 219)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              top: 3,
                                                              bottom: 3,
                                                              right: 14),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          focusColor:
                                                              Colors.grey[200],
                                                          hint: const Text(
                                                            "Choose Co-Supervisor",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          value: cosupervisor,
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              cosupervisor =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: listitem
                                                              .map((valueItem) {
                                                            return DropdownMenuItem(
                                                              value: valueItem,
                                                              child: Text(
                                                                  valueItem),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(9.0),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors
                                                                  .deepPurple),
                                                  onPressed: (() {
                                                    var db1 = FirebaseFirestore
                                                        .instance
                                                        .collection("Groups")
                                                        .doc(document1.id)
                                                        .collection(
                                                            "Superviors");

                                                    db1.add({
                                                      "Main Supervisor":
                                                          supervisor,
                                                      "Co-Supervisor":
                                                          cosupervisor,
                                                    });

                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                "Allocation Successful"),
                                                            content: const Icon(
                                                                Icons.done_all),
                                                            actions: [
                                                              MaterialButton(
                                                                child:
                                                                    const Text(
                                                                        "OK"),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  // Navigator.push(
                                                                  //     context,
                                                                  //     MaterialPageRoute(
                                                                  //       builder:
                                                                  //           (context) =>
                                                                  //               ConvenorDashboard(),
                                                                  //     ));
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  }),
                                                  child: const Text(
                                                    "Allocate",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(9.0),
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 210, 208, 214)),
                                              onPressed: () {
                                                Navigator.pop(contex);
                                              },
                                              child: const Text("back",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          )
                                        ]);
                                  }),
                                );
                              },
                              child: const Text(
                                'Allocate Supervisors',
                              )),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  );
                }
              });
        });
  }
}
