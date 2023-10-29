// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/student_screens/myproposal.dart';
import 'package:universal_html/html.dart';

class proposal1 extends StatefulWidget {
  const proposal1({super.key});
  @override
  State<proposal1> createState() => _proposal1State();
}

class _proposal1State extends State<proposal1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Convenor Portal"),
        ),
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      '/Convenor/classes/BS Information Technology/groups/group-members')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: Card(
                      child: Column(children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];

                          {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text('Groupid'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        document["fyp-id"],
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  method1(),
                                  method2()
                                ],
                              ),
                            );
                          }
                        }),
                  ])),
                );
              }),
        ));
  }
}

// fetchdata() {
//   return SafeArea(
//       child: );
// }

method1() {
  return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collectionGroup('proposal3')
              // .where('fyp-id', isEqualTo: '23-FYP-301')
              // .collection('Convenor')
              // .doc('classes')
              // .collection('BS Information Technology')
              // .doc('groups')
              // .collection('group-members')
              // .doc(value)
              // .collection('proposals')
              // .doc('proposals')
              // .collection('proposal1')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // if (!snapshot.hasData) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // } else if (snapshot.data?.size == 0) {
            //   return const Text('No proposals submitted yet');
            // }
            return Card(
              child: Column(
                children: [
                  ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                const Text('Proposal 1'),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  document["title"],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList()),
                ],
              ),
            );
          }));
}

method2() {
  return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collectionGroup('proposal3')
              .where('id', isEqualTo: '1172')
              // .collection('Convenor')
              // .doc('classes')
              // .collection('BS Information Technology')
              // .doc('groups')
              // .collection('group-members')
              // .doc(value)
              // .collection('proposals')
              // .doc('proposals')
              // .collection('proposal2')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // if (!snapshot.hasData) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            return Card(
              child: Column(
                children: [
                  ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                const Text('Proposal 2'),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  document["title"],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList()),
                ],
              ),
            );
          }));
}
