// ignore_for_file: implementation_imports

// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, unused_element, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/DemoProposal.dart';
import 'package:flutter_application_1/new.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Test2 extends StatefulWidget {
  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  String groupdocument = '';

  var groupdetails;

  List total = [];

  final List storedocs = [];

  List proposal1document = [];
  List proposal2document = [];

  var students;

  String docid1 = '';
  String docid2 = '';
  bool button1pro1 = true;
  bool button2pro1 = false;

  bool button1pro2 = true;
  bool button2pro2 = false;

  List get proposal1docs => firstproposal(groupdocument);

  Object? get proposal_1docs => firstproposal(groupdocument);

  void _button1_proposal1() {
    setState(() {
      button1pro1 = false;
      button2pro1 = true;

      var approval = FirebaseFirestore.instance
          .collection('Convenor')
          .doc('classes')
          .collection('BS Information Technology')
          .doc('groups')
          .collection('group-members')
          .doc(groupdocument)
          .collection('proposals')
          .doc('proposals')
          .collection('proposal1')
          .doc(docid1)
          .update({'supervisor-approval': 'Approved'});
    });
  }

  void _button2_proposal1() {
    setState(() {
      button1pro1 = true;
      button2pro1 = false;

      var rejection = FirebaseFirestore.instance
          .collection('Convenor')
          .doc('classes')
          .collection('BS Information Technology')
          .doc('groups')
          .collection('group-members')
          .doc(groupdocument)
          .collection('proposals')
          .doc('proposals')
          .collection('proposal1')
          .doc(docid1)
          .update({'supervisor-approval': 'Rejected'});
    });
  }

  void _button3_proposal1() {
    setState(() {
      button1pro1 = true;
      button2pro1 = true;

      var pending = FirebaseFirestore.instance
          .collection('Convenor')
          .doc('classes')
          .collection('BS Information Technology')
          .doc('groups')
          .collection('group-members')
          .doc(groupdocument)
          .collection('proposals')
          .doc('proposals')
          .collection('proposal1')
          .doc(docid1)
          .update({'supervisor-approval': 'Pending'});
    });
  }

  void _button1_proposal2() {
    setState(() {
      button1pro2 = false;
      button2pro2 = true;

      var approval = FirebaseFirestore.instance
          .collection('Convenor')
          .doc('classes')
          .collection('BS Information Technology')
          .doc('groups')
          .collection('group-members')
          .doc(groupdocument)
          .collection('proposals')
          .doc('proposals')
          .collection('proposal2')
          .doc(docid2)
          .update({'supervisor-approval': 'Approved'});
    });
  }

  void _button2_proposal2() {
    setState(() {
      button1pro2 = true;
      button2pro2 = false;

      var rejection = FirebaseFirestore.instance
          .collection('Convenor')
          .doc('classes')
          .collection('BS Information Technology')
          .doc('groups')
          .collection('group-members')
          .doc(groupdocument)
          .collection('proposals')
          .doc('proposals')
          .collection('proposal2')
          .doc(docid2)
          .update({'supervisor-approval': 'Rejected'});
    });
  }

  void _button3_proposal2() {
    setState(() {
      button1pro2 = true;
      button2pro2 = true;

      var pending = FirebaseFirestore.instance
          .collection('Convenor')
          .doc('classes')
          .collection('BS Information Technology')
          .doc('groups')
          .collection('group-members')
          .doc(groupdocument)
          .collection('proposals')
          .doc('proposals')
          .collection('proposal2')
          .doc(docid2)
          .update({'supervisor-approval': 'Pending'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 242, 244),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                  '/Convenor/classes/BS Information Technology/groups/group-members')
              .orderBy('fyp-id')

              // .where('fyp-id', isEqualTo: '23-FYP-303')
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
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No proposals submitted yet",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DemoProposal(),
                                ));

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DemoProposal()));
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

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 200, 0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _createPDF(storedocs, students, proposal1document,
                            proposal2document);

                        print(storedocs.length);
                        // print(proposal1document);
                      },

                      icon: Icon(
                        Icons.print,
                        size: 20,
                      ), //icon data for elevated button
                      label: Text("Print"),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        students = snapshot.data!.docs.length;
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        groupdocument = document.id;
                        groupdetails = document;
                        // total = document as List;

                        snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map a = document.data() as Map<String, dynamic>;
                          storedocs.add(a);
                          a['id'] = document.id;
                        }).toList();

                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(17)),
                                margin: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 155),
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 28, horizontal: 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 179, 51, 51),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              document["fyp-id"],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Divider(
                                        height: 10,
                                        thickness: 5,
                                        color:
                                            Color.fromARGB(255, 57, 120, 125),
                                      ),
                                      firstproposal(groupdocument),
                                      secondproposal(groupdocument),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Text('null');
                      }),
                ],
              ),
            );
          }),
    );
  }

  _createPDF(
    List value,
    var numbers,
    List proposal_1docs,
    List proposal_2docs,
  ) async {
    // final font = await PdfGoogleFonts.nunitoExtraLight();

    var numbers = value.length;

    var font = await PdfGoogleFonts.tinosRegular();
    var font_bold = await PdfGoogleFonts.tinosBold();

    var color = Colors.blue;
    String getCurrentDate() {
      var date = DateTime.now().toString();

      var dateParse = DateTime.parse(date);

      var formattedDate =
          "${dateParse.day}-${dateParse.month}-${dateParse.year}";
      return formattedDate.toString();
    }

    final doc = pw.Document();

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
              margin:
                  const pw.EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Center(
                    child: pw.Text(
                      'National Textile Univeristy, Faisalabad',
                      style: pw.TextStyle(
                          fontSize: 18, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Center(
                      child: pw.Text(
                    'Department of Computer Science',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold),
                  )),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Center(
                      child: pw.Text(
                          'BSIT Final Year Project (FYP) supervisory committee notification (Tentative*)',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold))),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text('Date: ${getCurrentDate()}',
                      style: pw.TextStyle(
                          decoration: pw.TextDecoration.underline,
                          font: font_bold,
                          fontSize: 10)),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Table(
                      border: pw.TableBorder.all(),
                      // defaultColumnWidth: const pw.FixedColumnWidth(40.0),
                      columnWidths: {
                        // 0: pw.FlexColumnWidth(1),
                        // 1: pw.FlexColumnWidth(3),
                        // 2: pw.FlexColumnWidth(2),
                        // 3: pw.FlexColumnWidth(2),
                        4: pw.FlexColumnWidth(2),
                        5: pw.FlexColumnWidth(2),
                      },
                      // defaultVerticalAlignment:
                      //     pw.TableCellVerticalAlignment.middle,
                      defaultVerticalAlignment:
                          pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.TableRow(
                            // decoration: pw.BoxDecoration(
                            //     color: PdfColor.fromRYB(0, 0, 1)),
                            children: [
                              pw.Column(children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(6.0),
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Text(
                                    'FYP ID',
                                    style: pw.TextStyle(
                                        color: PdfColor.fromRYB(0, 0, 0),
                                        font: font_bold,
                                        fontSize: 8),
                                  ),
                                ),
                              ]),
                              pw.Column(children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(6.0),
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Text(
                                    'Group members',
                                    style: pw.TextStyle(
                                        color: PdfColor.fromRYB(0, 0, 0),
                                        font: font_bold,
                                        fontSize: 8),
                                  ),
                                ),
                              ]),
                              pw.Column(children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(6.0),
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Text(
                                    'Supervisor',
                                    style: pw.TextStyle(
                                        color: PdfColor.fromRYB(0, 0, 0),
                                        font: font_bold,
                                        fontSize: 8),
                                  ),
                                ),
                              ]),
                              pw.Column(children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(6.0),
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Text(
                                    'Co- Supervisor',
                                    style: pw.TextStyle(
                                        color: PdfColor.fromRYB(0, 0, 0),
                                        font: font_bold,
                                        fontSize: 8),
                                  ),
                                ),
                              ]),
                              pw.Column(children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(6.0),
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Text(
                                    'Proposed Ideas',
                                    style: pw.TextStyle(
                                        color: PdfColor.fromRYB(0, 0, 0),
                                        font: font_bold,
                                        fontSize: 8),
                                  ),
                                ),
                              ]),
                              pw.Column(children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(6.0),
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Text(
                                    'Approved Ideas',
                                    style: pw.TextStyle(
                                        color: PdfColor.fromRYB(0, 0, 0),
                                        font: font_bold,
                                        fontSize: 8),
                                  ),
                                ),
                              ]),
                            ]),
                        for (var i = 0; i < 14; i++) ...[
                          pw.TableRow(children: [
                            pw.Column(children: [
                              pw.Container(
                                padding: const pw.EdgeInsets.all(6.0),
                                alignment: pw.Alignment.topLeft,
                                child: pw.Text(
                                  value[i]['fyp-id'],
                                  style: pw.TextStyle(font: font, fontSize: 6),
                                ),
                              ),
                            ]),
                            pw.Column(children: [
                              pw.Container(
                                  padding: const pw.EdgeInsets.all(6.0),
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Column(children: [
                                    pw.Text(
                                      value[i]['regno1'],
                                      style:
                                          pw.TextStyle(font: font, fontSize: 6),
                                    ),
                                    pw.Text(
                                      value[i]['regno2'],
                                      style:
                                          pw.TextStyle(font: font, fontSize: 6),
                                    ),
                                    pw.Text(
                                      value[i]['regno3'],
                                      style:
                                          pw.TextStyle(font: font, fontSize: 6),
                                    ),
                                  ])),
                            ]),
                            pw.Column(children: [
                              pw.Container(
                                padding: const pw.EdgeInsets.all(6.0),
                                alignment: pw.Alignment.topLeft,
                                child: pw.Text(
                                  value[i]['main-supervisor'],
                                  style: pw.TextStyle(font: font, fontSize: 6),
                                ),
                              ),
                            ]),
                            pw.Column(children: [
                              pw.Container(
                                padding: const pw.EdgeInsets.all(6.0),
                                alignment: pw.Alignment.topLeft,
                                child: pw.Text(
                                  value[i]['co-supervisor'],
                                  style: pw.TextStyle(font: font, fontSize: 6),
                                ),
                              ),
                            ]),
                            pw.Column(children: [
                              pw.Container(
                                  padding: const pw.EdgeInsets.all(6.0),
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          proposal_1docs[i]['project-title'],
                                          style: pw.TextStyle(
                                              font: font, fontSize: 6),
                                        ),
                                        pw.SizedBox(
                                          height: 2,
                                        ),
                                        pw.Text(
                                          proposal_2docs[i]['project-title'],
                                          style: pw.TextStyle(
                                              font: font, fontSize: 6),
                                        ),
                                      ])),
                            ]),
                            pw.Column(children: [
                              pw.Container(
                                  padding: const pw.EdgeInsets.all(6.0),
                                  alignment: pw.Alignment.topLeft,
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          proposal_1docs[i]['project-title'],
                                          style: pw.TextStyle(
                                              font: font, fontSize: 6),
                                        ),
                                        pw.SizedBox(
                                          height: 2,
                                        ),
                                        pw.Text(
                                          proposal_2docs[i]['project-title'],
                                          style: pw.TextStyle(
                                              font: font, fontSize: 6),
                                        ),
                                      ])),
                            ]),
                          ]),
                        ],
                      ]),
                  pw.SizedBox(height: 30),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text('Shahbaz Ahmad Sahi',
                            style: pw.TextStyle(font: font_bold, fontSize: 10)),
                        pw.Text('Convener',
                            style: pw.TextStyle(font: font_bold, fontSize: 10)),
                        pw.Text('BSIT, FYP Committee',
                            style: pw.TextStyle(font: font_bold, fontSize: 10)),
                      ])
                ],
              ));

          // Center
        }));

    Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());

    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Text('zeeshan'),
            ElevatedButton(
                onPressed: () {
                  // _createPDF(value);
                },
                child: const Text("Print"))
          ],
        ),
      ),
    );
  }

  firstproposal(
    String value,
  ) {
    String topic = 'Main Topic Details';

    List proposal_1docs = [];

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Convenor')
            .doc('classes')
            .collection('BS Information Technology')
            .doc('groups')
            .collection('group-members')
            .doc(value)
            .collection('proposals')
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
                  Text(
                    "No proposals submitted yet",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DemoProposal(),
                              ));

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DemoProposal()));
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
              docid1 = db.id;

              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                proposal1document.add(a);
                a['id'] = document.id;
              }).toList();

              if (snapshot.hasData) {
                return Container(
                  // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 139, 77, 53),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          ('Proposal 1'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      db["project-title"],
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
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
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                content: SingleChildScrollView(
                                                  child: Container(
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: const <
                                                            Widget>[
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
                                        primary: const Color.fromARGB(
                                            255, 94, 84, 84),
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
                                    onPressed: button1pro1
                                        ? _button1_proposal1
                                        : _button3_proposal1,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: button1pro1
                                            ? Color.fromARGB(255, 50, 107, 50)
                                            : Color.fromARGB(255, 240, 234,
                                                234), // This is what you need!

                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: Text(
                                      button1pro1 ? 'Approve' : 'Approved',
                                      style: TextStyle(
                                          color: button1pro1
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),
                                ElevatedButton(
                                    onPressed: button2pro1
                                        ? _button2_proposal1
                                        : _button3_proposal1,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: button2pro1
                                            ? Color.fromARGB(255, 180, 34, 34)
                                            : Color.fromARGB(
                                                255, 240, 234, 234),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: Text(
                                      button2pro1 ? 'Reject' : 'Rejected',
                                      style: TextStyle(
                                          color: button2pro1
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                SizedBox(
                                  width: 50,
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
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 226, 225, 225),
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 12),
                              child: Text(
                                db['convenor-approval'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Text('null');
            },
          );
        });
  }

  secondproposal(String value) {
    String topic = 'FYP Topic(Option 2)';
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Convenor')
            .doc('classes')
            .collection('BS Information Technology')
            .doc('groups')
            .collection('group-members')
            .doc(value)
            .collection('proposals')
            .doc('proposals')
            .collection('proposal2')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot db = snapshot.data!.docs[index];
              docid2 = db.id;

              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                proposal2document.add(a);
                a['id'] = document.id;
              }).toList();

              if (snapshot.hasData) {
                return Container(
                  // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 139, 77, 53),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          ('Proposal 2'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      db["project-title"],
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
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
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                content: SingleChildScrollView(
                                                  child: Container(
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: const <
                                                            Widget>[
                                                          // _readproposal2(db,
                                                          //     value2, topic),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            255, 94, 84, 84),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: const Text('Read')),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                    onPressed: button1pro2
                                        ? _button1_proposal2
                                        : _button3_proposal2,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: button1pro2
                                            ? Color.fromARGB(255, 50, 107, 50)
                                            : Color.fromARGB(255, 240, 234,
                                                234), // This is what you need!

                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: Text(
                                      button1pro2 ? 'Approve' : 'Approved',
                                      style: TextStyle(
                                          color: button1pro2
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),
                                ElevatedButton(
                                    onPressed: button2pro2
                                        ? _button2_proposal2
                                        : _button3_proposal2,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: button2pro2
                                            ? Color.fromARGB(255, 180, 34, 34)
                                            : Color.fromARGB(
                                                255, 240, 234, 234),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: Text(
                                      button2pro2 ? 'Reject' : 'Rejected',
                                      style: TextStyle(
                                          color: button2pro2
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                SizedBox(
                                  width: 50,
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
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 226, 225, 225),
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 12),
                              child: Text(
                                db['supervisor-approval'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
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
}

_readproposal1(var snap, var value2, String topic) {
  var sample = value2;

  String imageUrl = snap['proposed-methodology-url'].toString();
  String imageUrl2 = snap['ganttchart-url'].toString();

  return SafeArea(
    child: Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(),
              Container(
                width: 1400,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 28, horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sample["group-id"],
                        style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: 10,
                        thickness: 5,
                        color: Color.fromARGB(255, 57, 120, 125),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // const Divider(
                      //   height: 1,
                      //   thickness: 2,
                      //   color: Colors.blue,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'TITLE',
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
                        snap["project-title"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
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
                        snap["industrial-partner"],
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
                        snap["problem-statement"],
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
                        snap["objectives"],
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
                        snap["problem-background"],
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
                        snap["proposed-solution"],
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
                        snap["proposed-tools"],
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
                        snap["related-technologies"],
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
                        snap["project-rationale"],
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
                        snap["proposed-methodology"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // ImageNetwork(
                      //   image: imageUrl,
                      //   height: 396,
                      //   width: 515,
                      //   duration: 1500,
                      //   curve: Curves.easeIn,
                      //   onPointer: true,
                      //   debugPrint: false,
                      //   fullScreen: false,
                      //   fitAndroidIos: BoxFit.cover,
                      //   fitWeb: BoxFitWeb.cover,
                      //   borderRadius: BorderRadius.circular(70),
                      // ),
                      // const SizedBox(
                      //   height: 40,
                      // ),
                      const Text(
                        'GANTT CHART',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // ImageNetwork(
                      //   image: imageUrl2,
                      //   height: 396,
                      //   width: 515,
                      //   duration: 1500,
                      //   curve: Curves.easeIn,
                      //   onPointer: true,
                      //   debugPrint: false,
                      //   fullScreen: false,
                      //   fitAndroidIos: BoxFit.cover,
                      //   fitWeb: BoxFitWeb.cover,
                      //   borderRadius: BorderRadius.circular(70),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Text(
                        snap["schedule"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              _multipage(snap, sample, topic);
            },
            child: const Text("Print")),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

_readproposal2(var snap, var value2, String topic) {
  var sample = value2;

  String imageUrl = snap['proposed-methodology-url'].toString();
  return SafeArea(
    child: Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(),
              Container(
                width: 1400,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 28, horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sample["group-id"],
                        style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: 10,
                        thickness: 5,
                        color: Color.fromARGB(255, 57, 120, 125),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   children: [
                      //     const Text(
                      //       'Group Id: ',
                      //       style: TextStyle(
                      //         fontFamily: 'Sans-serif',
                      //         fontSize: 18,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       sample["group-id"],
                      //       style: const TextStyle(
                      //         fontFamily: 'Sans-serif',
                      //         fontSize: 16,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const Divider(
                      //   height: 1,
                      //   thickness: 2,
                      //   color: Colors.blue,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'TITLE',
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
                        snap["project-title"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
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
                        snap["industrial-partner"],
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
                        snap["problem-statement"],
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
                        snap["objectives"],
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
                        snap["problem-background"],
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
                        snap["proposed-solution"],
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
                        snap["proposed-tools"],
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
                        snap["related-technologies"],
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
                        snap["project-rationale"],
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
                        snap["proposed-methodology"],
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
                        snap["schedule"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              _multipage(snap, sample, topic);
            },
            child: const Text("Print")),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

_multipage(var snap, var snap2, String topic) async {
  final pdf = pw.Document();
  final db;

  var font = await PdfGoogleFonts.tinosRegular();
  var font_bold = await PdfGoogleFonts.tinosBold();

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  final netImage = await networkImage(
    'https://upload.wikimedia.org/wikipedia/en/e/e4/National_Textile_University_Logo.png',
  );

  // final netImage = await networkImage(snap['proposed-methodology-url']);
  dynamic data;

  title() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Zeeshan')
            // .doc('classes')
            // .collection('BS Information Technology')
            // .doc('groups')
            // .collection('group-members')
            // .where('group-id', isEqualTo: snap['group-id'])
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot db = snapshot.data!.docs[index];
                data = db;
                return Text('$db');
              });
        });
  }

  DocumentSnapshot snapshot;

  void getData() async {
    //use a Async-await function to get the data
    final data = await FirebaseFirestore.instance
        .collection("Zeeshan")
        .doc('EycajcosUCibiWDYtIDh')
        .get(); //get the data
    snapshot = data;
  }

  pdf.addPage(pw.MultiPage(
      // maxPages: 100,
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Center(
              child: pw.Container(
                  decoration: const pw.BoxDecoration(),
                  margin: const pw.EdgeInsets.symmetric(
                      vertical: 15, horizontal: 15),
                  width: double.infinity,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 15, bottom: 20),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            snap['group-id'],
                            style: pw.TextStyle(
                              fontSize: 28,
                              font: font,
                              // color: pw.Colors.blue,
                            ),
                          ),

                          pw.SizedBox(
                            height: 60,
                          ),
                          pw.Text('Project Proposal',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                fontSize: 24,
                                font: font_bold,
                              )),
                          pw.SizedBox(
                            height: 55,
                          ),
                          pw.Image(netImage, height: 140, width: 380),
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
                            'Supervisor',
                            style: pw.TextStyle(
                              fontSize: 20,
                              font: font_bold,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            snap2['main-supervisor'],
                            style: pw.TextStyle(
                              fontSize: 18,
                              font: font,
                            ),
                          ),
                          pw.SizedBox(
                            height: 25,
                          ),
                          pw.Text(
                            'Group Details',
                            style: pw.TextStyle(
                              fontSize: 18,
                              font: font_bold,
                            ),
                          ),
                          pw.Text(
                            snap2['mem1'],
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                          pw.Text(
                            snap2['regno1'],
                            style: pw.TextStyle(fontSize: 14, font: font),
                          ),
                          pw.SizedBox(
                            height: 3,
                          ),
                          pw.Text(
                            snap2['mem2'],
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                          pw.Text(
                            snap2['regno2'],
                            style: pw.TextStyle(fontSize: 14, font: font),
                          ),
                          pw.SizedBox(
                            height: 3,
                          ),
                          pw.Text(
                            snap2['mem3'],
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                          pw.Text(
                            snap2['regno3'],
                            style: pw.TextStyle(fontSize: 14, font: font),
                          ),

                          pw.SizedBox(
                            height: 30,
                          ),
                          pw.Text(
                            'Department of Computer Science,',
                            style: pw.TextStyle(fontSize: 16, font: font_bold),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Text(
                            'National Textile University, Faisalabad',
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Text('Date: ${getCurrentDate()}',
                              style: pw.TextStyle(font: font, fontSize: 14)),
                        ]),
                  )))
        ];
        // Center
      }));

  pdf.addPage(pw.MultiPage(

      // maxPages: 100,
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return <pw.Widget>[
          // pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          // pw.Container(
          //   margin:
          //       const pw.EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
          //   child: pw.Expanded(
          //     child: pw.Column(
          //         crossAxisAlignment: pw.CrossAxisAlignment.start,
          //         children: [

          pw.Divider(height: 10, thickness: 3),
          pw.SizedBox(
            height: 20,
          ),
          pw.Text(
            'FYP Proposal',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 20,
              font: font_bold,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            topic,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 18,
              font: font_bold,
            ),
          ),
          pw.SizedBox(
            height: 10,
          ),
          pw.Text(
            'A- Basic Information',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 20,
              font: font,
            ),
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.Table(
              border: pw.TableBorder.all(),
              defaultColumnWidth: const pw.FixedColumnWidth(80.0),
              // defaultVerticalAlignment:
              //     pw.TableCellVerticalAlignment.middle,
              children: [
                pw.TableRow(children: [
                  pw.Column(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 14),
                          child: pw.Text(
                            'Title',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: 14,
                              font: font_bold,
                            ),
                          ),
                        )),
                  ]),
                  pw.Column(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(6.0),
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 5),
                        child: pw.Text(
                          snap['project-title'],
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 14,
                            font: font,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ])
              ]),
          pw.Table(
              border: pw.TableBorder.all(),
              defaultColumnWidth: const pw.FixedColumnWidth(80.0),
              // defaultVerticalAlignment:
              //     pw.TableCellVerticalAlignment.middle,
              children: [
                pw.TableRow(children: [
                  pw.Column(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 14),
                          child: pw.Text(
                            'Project Type',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: 14,
                              font: font_bold,
                            ),
                          ),
                        )),
                  ]),
                  pw.Column(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(6.0),
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 5),
                        child: pw.Text(
                          snap['project-type'],
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 14,
                            font: font,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ])
              ]),
          pw.Table(
              border: pw.TableBorder.all(),
              defaultColumnWidth: const pw.FixedColumnWidth(80.0),
              // defaultVerticalAlignment:
              //     pw.TableCellVerticalAlignment.middle,
              children: [
                pw.TableRow(children: [
                  pw.Column(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 14),
                          child: pw.Text(
                            'Project Category',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: 14,
                              font: font_bold,
                            ),
                          ),
                        )),
                  ]),
                  pw.Column(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(6.0),
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 5),
                        child: pw.Text(
                          snap['project-category'],
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 14,
                            font: font,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ])
              ]),
          pw.Table(
              border: pw.TableBorder.all(),
              defaultColumnWidth: const pw.FixedColumnWidth(80.0),
              // defaultVerticalAlignment:
              //     pw.TableCellVerticalAlignment.middle,
              children: [
                pw.TableRow(children: [
                  pw.Column(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 14),
                          child: pw.Text(
                            'Industry Project',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: 14,
                              font: font_bold,
                            ),
                          ),
                        )),
                  ]),
                  pw.Column(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(6.0),
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 5),
                        child: pw.Text(
                          snap['industrial-partner'],
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 14,
                            font: font,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ])
              ]),
          pw.SizedBox(height: 20),
          pw.Text(
            'B-	Detail of FYP Idea',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 18,
              font: font_bold,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'PROBLEM STATEMENT',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 13,
              font: font_bold,
            ),
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Text(
            snap['problem-statement'],
            style: pw.TextStyle(
              fontSize: 13,
              font: font,
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Text(
            'OBJECTIVES',
            style: pw.TextStyle(
              fontSize: 14,
              font: font_bold,
            ),
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Text(
            snap['objectives'],
            style: pw.TextStyle(
              fontSize: 13,
              font: font,
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Text(
            'PROBLEM BACKGROUND',
            style: pw.TextStyle(fontSize: 14, font: font_bold),
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Text(
            snap['problem-background'],
            style: pw.TextStyle(
              fontSize: 13,
              font: font,
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Text(
            'PROPOSED SOLUTION',
            style: pw.TextStyle(
              fontSize: 14,
              font: font_bold,
            ),
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Text(
            snap['proposed-solution'],
            style: pw.TextStyle(
              fontSize: 13,
              font: font,
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Text(
            'PROPOSED TOOLS',
            style: pw.TextStyle(
              fontSize: 14,
              font: font_bold,
            ),
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Text(
            snap['proposed-tools'],
            style: pw.TextStyle(
              fontSize: 13,
              font: font,
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Text(
            'RELATED TECHNOLOGIES',
            style: pw.TextStyle(
              fontSize: 14,
              font: font_bold,
            ),
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Text(
            snap['related-technologies'],
            style: pw.TextStyle(
              fontSize: 13,
              font: font,
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Text(
            'PROJECT RATIONALE',
            style: pw.TextStyle(
              fontSize: 14,
              font: font_bold,
            ),
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Text(
            snap['project-rationale'],
            style: pw.TextStyle(
              fontSize: 13,
              font: font,
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Text(
            'PROPOSED METHODOLOGY',
            style: pw.TextStyle(
              fontSize: 14,
              font: font_bold,
            ),
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Wrap(children: [
            pw.Text(
              snap['proposed-methodology'],
              style: pw.TextStyle(
                fontSize: 13,
                font: font,
              ),
            ),
          ]),
          pw.SizedBox(
            height: 15,
          ),
          pw.Text(
            'GANTT CHART',
            style: pw.TextStyle(
              fontSize: 14,
              font: font_bold,
            ),
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Text(
            snap['schedule'],
            style: pw.TextStyle(
              fontSize: 13,
              font: font,
            ),
          )
        ];
      }));

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
