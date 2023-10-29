import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class allocation extends StatefulWidget {
  const allocation({super.key});

  @override
  State<allocation> createState() => _allocationState();
}

class _allocationState extends State<allocation> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Convenor')
            .doc('classes')
            .collection('BS Information Technology')
            .doc('groups')
            .collection('group-members')
            .orderBy('fyp-id')
            .snapshots(),
        // stream: FirebaseFirestore.instance
        //     .collection('supervisor')
        //     .doc('supervisor')
        //     .collection('Mr. Shahbaz Ahmad Sahi')
        //     .doc('groups')
        //     .collection('main-supervision')
        //     .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var mani = snapshot.data!.docs.length;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return Center(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "No group allocated yet! ",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ));
          } else if (!snapshot.hasData) {
            return const Center(
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
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
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
                                      margin: const EdgeInsets.all(20),
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 80, 121, 201),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Center(
                                        child: Text(
                                          document['fyp-id'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(20),
                                          height: 40,
                                          width: 160,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 80, 121, 201),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Center(
                                            child: Text(
                                              document['accepted-idea'],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                proposal(document.id)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          // method2()
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        });
  }

  proposal(String snap) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Convenor')
            .doc('classes')
            .collection('BS Information Technology')
            .doc('groups')
            .collection('group-members')
            .doc(snap)
            .collection('proposals')
            .doc('proposals')
            .collection('proposal1')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var mani = snapshot.data!.docs.length;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return Center(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "No group allocated yet! ",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ));
          } else if (!snapshot.hasData) {
            return const Center(
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
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(document['accepted']),
                                ElevatedButton(
                                    onPressed: () {
                                      var supervisorCollection =
                                          FirebaseFirestore.instance
                                              .collection('Convenor')
                                              .doc('classes')
                                              .collection(
                                                  'BS Information Technology')
                                              .doc('groups')
                                              .collection('group-members')
                                              .doc(snap)
                                              .update({
                                        'accepted-idea': document['accepted']
                                      });
                                    },
                                    child: const Text('Allocate'))
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        });
  }
}
