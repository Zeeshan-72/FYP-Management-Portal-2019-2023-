// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/proposal_form.dart';

import 'package:flutter_application_1/student_screens/member_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class viewproposal extends StatefulWidget {
  @override
  State<viewproposal> createState() => _viewproposalState();
}

class _viewproposalState extends State<viewproposal> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  var _supervisor;

  var _cosupervisor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 242, 244),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Convenor')
              .doc('classes')
              .collection('BS Information Technology')
              .doc('groups')
              .collection('projects')
              .doc('proposals')
              .collection('proposal1')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 250),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 28, horizontal: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              height: 10,
                              thickness: 5,
                              color: Color.fromARGB(255, 57, 120, 125),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              document["project-title"],
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'INDUSTRIAL PARTNER',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["industrial-partner"],
                              style: TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'PROBLEM STATEMENT',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["problem-statement"],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'OBJECTIVES',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["objectives"],
                              style: TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'PROBLEM BACKGROUND',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["problem-background"],
                              style: TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'PROPOSED SOLUTION',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["proposed-solution"],
                              style: TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'PROPOSED TOOLS',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["proposed-tools"],
                              style: TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'RELATED TECHNOLOGIES',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["related-technologies"],
                              style: TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              ' PROJECT RATIONALE',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["project-rationale"],
                              style: TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'PROPOSED METHODOLOGY',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["proposed-methodology"],
                              style: TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'GANTT CHART',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Sans-serif',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document["schedule"],
                              style: TextStyle(
                                fontFamily: 'Sans-serif',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _createPDF(document);
                        },
                        child: Text("Print")),
                    SizedBox(
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

_createPDF(var snap) {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance
      .collection('FYP')
      .doc('fyp(19-23)')
      .collection('groups')
      .doc(firebaseUser!.uid)
      .collection('project')
      .doc('proposals')
      .collection('proposal')
      .snapshots();

  final doc = pw.Document();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          margin: const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
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
                  style: pw.TextStyle(
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
                  style: pw.TextStyle(
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
                  style: pw.TextStyle(
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
                  style: pw.TextStyle(
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
                  style: pw.TextStyle(
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
                  style: pw.TextStyle(
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
                  style: pw.TextStyle(
                    fontSize: 11,
                  ),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.SizedBox(height: 30),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(children: [
                      pw.Text('Shahabaz Ahmad Sahi',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 10)),
                      pw.Text('Convener, Information Technology, FYP Committee',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    ])
                  ],
                )
              ]),
        ); // Center
      }));

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());

  return SafeArea(
    child: Center(
      child: Column(
        children: [
          const Text('zeeshan'),
          ElevatedButton(
              onPressed: () {
                _createPDF(snap);
              },
              child: const Text("Print"))
        ],
      ),
    ),
  );
}
