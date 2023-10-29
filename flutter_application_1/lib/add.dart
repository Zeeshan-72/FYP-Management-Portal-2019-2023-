// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:universal_html/html.dart';

class Test extends StatefulWidget {
  const Test({super.key});
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String id = '23-FYP-303';

  bool button1 = true;
  bool button2 = false;

  void _button1() {
    setState(() {
      button1 = false;
      button2 = true;
    });
  }

  void _button2() {
    setState(() {
      button1 = true;
      button2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 242, 244),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('FYP')
              .doc('fyp(19-23)')
              .collection('groups')
              .doc('wBorkr50KobyriYorczQ2tGOSiz1')
              .collection('members')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data?.size == 0) {
              return Center(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
                width: 600,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No proposals submitted yet",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Click here to Submit"),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => DemoProposal(),
                            //     ));

                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => DemoProposal()));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 57, 120, 125),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 20),
                              textStyle: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          child: const Text('Submit Now'),
                        )
                      ],
                    )
                  ],
                ),
              ));
            }

            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];

                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 155),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 28, horizontal: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 179, 51, 51),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        document["group-id"],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Divider(
                                  height: 10,
                                  thickness: 5,
                                  color: Color.fromARGB(255, 57, 120, 125),
                                ),
                                // grpinfo(),

                                firstproposal(document.id, document),
                                // secondproposal(document.id, document),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text('null');
                });
          }),
    );
  }
}

firstproposal(String value, var value2) {
  String topic = 'Main Topic Details';
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('FYP')
          .doc('fyp(19-23)')
          .collection('groups')
          .doc('wBorkr50KobyriYorczQ2tGOSiz1')
          .collection('project')
          .doc('proposals')
          .collection('proposal1')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data?.size == 0) {
          return Center(
              child: Container(
            margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
            width: 400,
            height: 250,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "No proposals submitted yet",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Click here to Submit"),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => DemoProposal(),
                        //     ));

                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => DemoProposal()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 57, 120, 125),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      child: const Text('Submit Now'),
                    )
                  ],
                )
              ],
            ),
          ));
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot db = snapshot.data!.docs[index];

            if (snapshot.hasData) {
              return Container(
                // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 139, 77, 53),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  ('Proposal 1'),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            db["project-title"],
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 180, 34, 34),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  db['supervisor-approval'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => Container(
                                            child: AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 200,
                                                  vertical: 20),
                                          scrollable: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          content: SingleChildScrollView(
                                            child: Container(
                                              width: double.infinity,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: const <Widget>[
                                                    // _readproposal1(
                                                    //     db, value2, topic),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )));
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 94, 84, 84),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 15),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                  )),
                              child: const Text('Read')),
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                var local = FirebaseFirestore.instance
                                    .collection('FYP')
                                    .doc('fyp(19-23)')
                                    .collection('groups')
                                    .doc('wBorkr50KobyriYorczQ2tGOSiz1')
                                    .collection('project')
                                    .doc('proposals')
                                    .collection('proposal1')
                                    .doc(db.id)
                                    .update(
                                        {'supervisor-approval': 'Approved'});
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 50, 107, 50),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 15),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                  )),
                              child: const Text('Accept')),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                var local = FirebaseFirestore.instance
                                    .collection('FYP')
                                    .doc('fyp(19-23)')
                                    .collection('groups')
                                    .doc('wBorkr50KobyriYorczQ2tGOSiz1')
                                    .collection('project')
                                    .doc('proposals')
                                    .collection('proposal1')
                                    .doc(db.id)
                                    .update(
                                        {'supervisor-approval': 'Rejected'});
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 180, 34, 34),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 15),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                  )),
                              child: const Text('Reject')),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                // _multipage(db, value2, topic);
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 15),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                  )),
                              child: const Text('Print')),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Text('null');
          },
        );
      });
}
