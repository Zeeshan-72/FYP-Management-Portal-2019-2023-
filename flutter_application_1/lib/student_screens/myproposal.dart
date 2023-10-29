// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/DemoProposal.dart';
import 'package:flutter_application_1/groupsList.dart';
import 'package:flutter_application_1/proposal_form.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Mygroups extends StatefulWidget {
  const Mygroups({super.key});

  @override
  State<Mygroups> createState() => _MygroupsState();
}

class _MygroupsState extends State<Mygroups> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  DocumentSnapshot get proposalSnapshot2 => fetchdata();

  get proposal2 => null;

  // get proposalSnapshot2 => fetchdata();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 242, 244),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('FYP')
              .doc('fyp(19-23)')
              .collection('groups')
              .doc(firebaseUser!.uid)
              .collection('project')
              .doc('proposals')
              .collection('proposal1')
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
                      "Your Proposal isn't submitted yet",
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
                            //       builder: (context) => Proposal(),
                            //     ));

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const DemoProposal()));
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
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Column(
                  children: [
                    titlepage(),
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 250),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 28, horizontal: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  document["project-title"],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'INDUSTRIAL PARTNER',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["industrial-partner"],
                              style: const TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'PROBLEM STATEMENT',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["problem-statement"],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'OBJECTIVES',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["objectives"],
                              style: const TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'PROBLEM BACKGROUND',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["problem-background"],
                              style: const TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'PROPOSED SOLUTION',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["proposed-solution"],
                              style: const TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'PROPOSED TOOLS',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["proposed-tools"],
                              style: const TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'RELATED TECHNOLOGIES',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["related-technologies"],
                              style: const TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              ' PROJECT RATIONALE',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["project-rationale"],
                              style: const TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'PROPOSED METHODOLOGY',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["proposed-methodology"],
                              style: const TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'GANTT CHART',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["schedule"],
                              style: const TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                    fetchdata(),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // _createPDF(document);
                          _multipage(document);
                        },
                        child: const Text("Print")),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }).toList(),
            );
          }),
    );
  }
}

titlepage() {
  return SafeArea(
      child: StreamBuilder(
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
              return const Text("Null");
            }

            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot db = snapshot.data!.docs[index];

                  if (snapshot.hasData) {
                    return Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 250),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100, bottom: 100),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Department of Computer Sciences',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  ' Faculty of Science and Technology',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'National Textile University, Faisalabad',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                const Text(
                                    'A proposition submitted to satisfy the fractional prerequisite for the degree of Bachelors of \nScience in Information Technology',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 60,
                                ),
                                const Image(
                                  image: NetworkImage(
                                    'https://upload.wikimedia.org/wikipedia/en/e/e4/National_Textile_University_Logo.png',
                                  ),
                                  width: 350,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                const Text(
                                  'Bachelor in Information and Technology',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                Container(
                                  width: 380,
                                  child: Column(
                                    children: [
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            db['mem1'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            db['regno1'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            db['mem2'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            db['regno2'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            db['mem3'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            db['regno3'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 80),
                                    child: Column(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceAround,
                                          children: const [
                                            Text(
                                              'Main Supervisor: ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Text(
                                              'Mr Waqar Ahmad',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceAround,
                                          children: const [
                                            Text(
                                              'Co Supervisor: ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 70,
                                            ),
                                            Text(
                                              'Mr Shahbaz Ahmad Sahi',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ));
                  }

                  return const Text('ddgf');
                });
          }));
}

fetchdata() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('FYP')
          .doc('fyp(19-23)')
          .collection('groups')
          .doc(firebaseUser!.uid)
          .collection('project')
          .doc('proposals')
          .collection('proposal2')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data?.size == 0) {
          return const Text("Null");
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot proposal2 = snapshot.data!.docs[index];

              if (snapshot.hasData) {
                return Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 250),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 28, horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              proposal2["project-title"],
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'INDUSTRIAL PARTNER',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Sans-serif',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["industrial-partner"],
                          style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'PROBLEM STATEMENT',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["problem-statement"],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'OBJECTIVES',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Sans-serif',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["objectives"],
                          style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'PROBLEM BACKGROUND',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Sans-serif',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["problem-background"],
                          style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'PROPOSED SOLUTION',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Sans-serif',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["proposed-solution"],
                          style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'PROPOSED TOOLS',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Sans-serif',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["proposed-tools"],
                          style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'RELATED TECHNOLOGIES',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Sans-serif',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["related-technologies"],
                          style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          ' PROJECT RATIONALE',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Sans-serif',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["project-rationale"],
                          style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'PROPOSED METHODOLOGY',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Sans-serif',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["proposed-methodology"],
                          style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'GANTT CHART',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Sans-serif',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          proposal2["schedule"],
                          style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const Text('Null');
            });
      });
}

_multipage(var snap) async {
  final pdf = pw.Document();

  final netImage = await networkImage(
    'https://upload.wikimedia.org/wikipedia/en/e/e4/National_Textile_University_Logo.png',
  );

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Center(
              child: pw.Container(
                  decoration: const pw.BoxDecoration(),
                  margin: const pw.EdgeInsets.symmetric(
                      vertical: 20, horizontal: 20),
                  width: double.infinity,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 20, bottom: 20),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            'Department of Computer Sciences',
                            style: const pw.TextStyle(
                              fontSize: 18,
                              // pw.fontFamily: 'Raleway',
                            ),
                          ),
                          pw.SizedBox(
                            height: 5,
                          ),
                          pw.Text(
                            ' Faculty of Science and Technology',
                            style: const pw.TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          pw.SizedBox(
                            height: 5,
                          ),
                          pw.Text(
                            'National Textile University, Faisalabad',
                            style: const pw.TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          pw.SizedBox(
                            height: 30,
                          ),
                          pw.Text(
                              'A proposition submitted to satisfy the fractional prerequisite for the degree of Bachelors of \nScience in Information Technology',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 12,
                              )),
                          pw.SizedBox(
                            height: 50,
                          ),
                          pw.Image(netImage, height: 150, width: 350),
                          // pw.Image(
                          //     pw.MemoryImage(
                          //       byteList,
                          //     ),
                          //     fit: pw.BoxFit.fitHeight),

                          // pw.Image(
                          //   image: NetworkImage(
                          //     'https://upload.wikimedia.org/wikipedia/en/e/e4/National_Textile_University_Logo.png',
                          //   ),
                          //   width: 350,
                          //   height: 200,
                          // ),
                          pw.SizedBox(
                            height: 50,
                          ),
                          pw.Text(
                            'Bachelor in Information and Technology',
                            style: pw.TextStyle(
                                fontSize: 18, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(
                            height: 40,
                          ),
                          pw.Container(
                            width: 380,
                            child: pw.Column(
                              children: [
                                pw.Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceAround,
                                  children: [
                                    pw.Text(
                                      'Alina Arshad',
                                      style: pw.TextStyle(
                                          fontSize: 14,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                      '(19-NTU-CS-1136)',
                                      style: const pw.TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(
                                  height: 5,
                                ),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceAround,
                                  children: [
                                    pw.Text(
                                      'Zeeshan Javed',
                                      style: pw.TextStyle(
                                          fontSize: 14,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                      '(19-NTU-CS-1172)',
                                      style: const pw.TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(
                                  height: 5,
                                ),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceEvenly,
                                  children: [
                                    pw.Text(
                                      'Muhammad Zohran',
                                      style: pw.TextStyle(
                                          fontSize: 14,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                      '(19-NTU-CS-1159)',
                                      style: const pw.TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(
                            height: 80,
                          ),
                          pw.Container(
                            child: pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 20),
                              child: pw.Column(
                                // crossAxisAlignment:
                                //     CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    children: [
                                      pw.Text(
                                        'Main Supervisor: ',
                                        style: pw.TextStyle(
                                            fontSize: 14,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.SizedBox(
                                        width: 50,
                                      ),
                                      pw.Text(
                                        'Mr Waqar Ahmad',
                                        style: const pw.TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(
                                    height: 5,
                                  ),
                                  pw.Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    children: [
                                      pw.Text(
                                        'Co Supervisor: ',
                                        style: pw.TextStyle(
                                            fontSize: 14,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.SizedBox(
                                        width: 70,
                                      ),
                                      pw.Text(
                                        'Mr Shahbaz Ahmad Sahi',
                                        style: const pw.TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                  )))
        ];
        // Center
      }));

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Container(
            margin:
                const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Divider(height: 10, thickness: 3),
                  pw.SizedBox(
                    height: 30,
                  ),
                  pw.Text(
                    snap['project-title'],
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                    'INDUSTRIAL PARTNER',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['industrial-partner'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROBLEM STATEMENT',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['problem-statement'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'OBJECTIVES',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['objectives'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROBLEM BACKGROUND',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['problem-background'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROPOSED SOLUTION',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['proposed-solution'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROPOSED TOOLS',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['proposed-tools'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'RELATED TECHNOLOGIES',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['related-technologies'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROJECT RATIONALE',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['project-rationale'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROPOSED METHODOLOGY',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['proposed-methodology'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'GANTT CHART',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    snap['schedule'],
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ]),
          ),
        ]; // Center
      }));

// Second Proposal
  // pdf.addPage(pw.MultiPage(
  //     pageFormat: PdfPageFormat.a4,
  //     build: (pw.Context context) {
  //       return <pw.Widget>[
  //         pw.Container(
  //           margin:
  //               const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
  //           child: pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Divider(height: 10, thickness: 3),
  //                 pw.SizedBox(
  //                   height: 30,
  //                 ),
  //                 pw.Text(
  //                   clc['project-title'],
  //                   style: pw.TextStyle(
  //                       fontSize: 16, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 20,
  //                 ),
  //                 pw.Text(
  //                   'INDUSTRIAL PARTNER',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['industrial-partner'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 15,
  //                 ),
  //                 pw.Text(
  //                   'PROBLEM STATEMENT',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['problem-statement'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 15,
  //                 ),
  //                 pw.Text(
  //                   'OBJECTIVES',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['objectives'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 15,
  //                 ),
  //                 pw.Text(
  //                   'PROBLEM BACKGROUND',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['problem-background'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 15,
  //                 ),
  //                 pw.Text(
  //                   'PROPOSED SOLUTION',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['proposed-solution'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 15,
  //                 ),
  //                 pw.Text(
  //                   'PROPOSED TOOLS',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['proposed-tools'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 15,
  //                 ),
  //                 pw.Text(
  //                   'RELATED TECHNOLOGIES',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['related-technologies'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 15,
  //                 ),
  //                 pw.Text(
  //                   'PROJECT RATIONALE',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['project-rationale'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 15,
  //                 ),
  //                 pw.Text(
  //                   'PROPOSED METHODOLOGY',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['proposed-methodology'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 40,
  //                 ),
  //                 pw.Text(
  //                   'GANTT CHART',
  //                   style: pw.TextStyle(
  //                       fontSize: 13, fontWeight: pw.FontWeight.bold),
  //                 ),
  //                 pw.SizedBox(
  //                   height: 5,
  //                 ),
  //                 pw.Text(
  //                   clc['schedule'],
  //                   style: const pw.TextStyle(
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //               ]),
  //         ),
  //       ]; // Center
  //     }));

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
