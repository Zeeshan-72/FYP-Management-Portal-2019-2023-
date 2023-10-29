// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_new, prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/student_screens/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class SuperProposals extends StatefulWidget {
  const SuperProposals({super.key});

  @override
  State<SuperProposals> createState() => _SuperProposalsState();
}

Future<List<Map<String, dynamic>>> getDocumentsFromCollection(
    String collectionName) async {
  List<Map<String, dynamic>> documentList = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            '/Convenor/classes/BS Information Technology/groups/group-members')
        .where('main-supervisor', isEqualTo: collection)
        .get();

    querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      documentList.add(data);
    });
  } catch (error) {
    print('Error retrieving documents: $error');
  }

  return documentList;
}

var firebaseUser = FirebaseAuth.instance.currentUser;

String get collection => collectionname(firebaseUser!.uid);

final List storedocs = [];

List proposal1document = [];
List proposal2document = [];

final List Approved_ideas = [];

var students;

var groupid;

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

getMarkers() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Convenor')
      .doc('classes')
      .collection('BS Information Technology')
      .doc('groups')
      .collection('group-members')
      .doc(groupid)
      .collection('proposals')
      .doc('proposals')
      .collection('proposal1')
      .where('supervisor-approval', isEqualTo: 'Endorsed')
      .get();

  querySnapshot.docs.map((DocumentSnapshot document) {
    Map a = document.data() as Map<String, dynamic>;
    Approved_ideas.add(a);
    a['id'] = document.id;
  }).toList();

  // var Approved_ideas = querySnapshot.docs;
  return Approved_ideas;
}

Ideas() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Convenor')
          .doc('classes')
          .collection('BS Information Technology')
          .doc('groups')
          .collection('group-members')
          .doc(groupid)
          .collection('proposals')
          .doc('proposals')
          .collection('proposal1')
          .where('supervisor-approval', isEqualTo: 'Endorsed')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        snapshot.data!.docs.map((DocumentSnapshot document) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];

                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map a = document.data() as Map<String, dynamic>;
                  Approved_ideas.add(a);
                  a['id'] = document.id;
                }).toList();

                if (snapshot.hasData) {
                  return Text('zeeshan');
                }

                return Text('null');
              });
        });
        return Text('null');
      });
}

class _SuperProposalsState extends State<SuperProposals> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                '/Convenor/classes/BS Information Technology/groups/group-members')
            .where('main-supervisor', isEqualTo: collection)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "No proposals submitted yet!",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(3),
                  width: double.infinity,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 80, 121, 201),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8, left: 36),
                        child: Text(
                          'Proposals',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Role: ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 40),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Co Supervision',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListView.builder(
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
                                  vertical: 20, horizontal: 25),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 28, horizontal: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.0))),
                                                      title: const Text(
                                                        'Group Details',
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      actions: <Widget>[
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 20,
                                                                  bottom: 10),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  ctx);
                                                            },
                                                            child: const Text(
                                                                "OK"),
                                                          ),
                                                        ),
                                                      ],
                                                      content: SizedBox(
                                                        height: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .blueAccent,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                      child:
                                                                          Text(
                                                                        'ID:  ' +
                                                                            document["fyp-id"],
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.blueAccent,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(12.0),
                                                                          child:
                                                                              Text(
                                                                            document["class"],
                                                                            style:
                                                                                const TextStyle(color: Colors.white, fontSize: 14),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Card(
                                                              // margin:
                                                              //     const EdgeInsets.all(20),
                                                              child: SizedBox(
                                                                width: 500,
                                                                child:
                                                                    DataTable(
                                                                  dataTextStyle:
                                                                      const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                  columns: const <
                                                                      DataColumn>[
                                                                    DataColumn(
                                                                      label:
                                                                          Expanded(
                                                                        child:
                                                                            Text(
                                                                          'Name',
                                                                          style: TextStyle(
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Expanded(
                                                                        child:
                                                                            Text(
                                                                          'Registration No',
                                                                          style: TextStyle(
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  rows: <
                                                                      DataRow>[
                                                                    DataRow(
                                                                      cells: <
                                                                          DataCell>[
                                                                        DataCell(
                                                                          Text(
                                                                            document["mem1"],
                                                                          ),
                                                                        ),
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "regno1"],
                                                                        )),
                                                                      ],
                                                                    ),
                                                                    DataRow(
                                                                      cells: <
                                                                          DataCell>[
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "mem2"],
                                                                        )),
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "regno2"],
                                                                        )),
                                                                      ],
                                                                    ),
                                                                    DataRow(
                                                                      cells: <
                                                                          DataCell>[
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "mem3"],
                                                                        )),
                                                                        DataCell(
                                                                            Text(
                                                                          document[
                                                                              "regno3"],
                                                                        )),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                          },
                                          child: SizedBox(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 179, 51, 51),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  document["fyp-id"],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Divider(
                                      height: 10,
                                      thickness: 5,
                                      color: Color.fromARGB(255, 57, 120, 125),
                                    ),
                                    firstproposal(document.id, document),
                                    secondproposal(document.id, document),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const Text('null');
                    }),
              ],
            ),

            // SingleChildScrollView(
            //   child: Center(
            //     child: Container(
            //       width: 300,
            //       height: 50,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(5),
            //           color: Colors.blue[200]),
            //       child: Center(
            //         child: Text('Site Under Maintenance',
            //             style: GoogleFonts.openSans(
            //                 fontSize: 16, fontWeight: FontWeight.w600)),
            //       ),
            //     ),
            //   ),
            // Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //   Container(
            //     margin: const EdgeInsets.all(3),
            //     width: double.infinity,
            //     height: 70,
            //     decoration: const BoxDecoration(
            //       color: Colors.blue,
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         const Padding(
            //           padding: EdgeInsets.only(top: 8, left: 36),
            //           child: Text(
            //             'Proposals',
            //             style: TextStyle(
            //                 fontSize: 26,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.white),
            //           ),
            //         ),
            //         Row(
            //           children: [
            //             const Text(
            //               'Role: ',
            //               style: TextStyle(
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.white),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.only(right: 40),
            //               decoration: BoxDecoration(
            //                   color: Colors.blueAccent,
            //                   borderRadius: BorderRadius.circular(10)),
            //               child: const Padding(
            //                 padding: EdgeInsets.all(12.0),
            //                 child: Text(
            //                   'Main Supervision',
            //                   style: TextStyle(
            //                       color: Colors.white, fontSize: 14),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            //   SingleChildScrollView(
            //     child: Container(
            //       width: 700,
            //       margin: EdgeInsets.all(13),
            //       child: DataTable(
            //         dataRowHeight: 60,
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //               color: Color.fromARGB(255, 238, 238, 238),
            //               width: 1.0),
            //         ),
            //         columns: const [
            //           DataColumn(
            //               label: Text(
            //             'Sr#',
            //             style: TextStyle(fontWeight: FontWeight.bold),
            //           )),
            //           DataColumn(
            //               label: Text(
            //             'FYP Id',
            //             style: TextStyle(fontWeight: FontWeight.bold),
            //           )),
            //           DataColumn(
            //             label: Text(
            //               'Title',
            //               style: TextStyle(fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //           DataColumn(
            //               label: Text(
            //             'Read',
            //             style: TextStyle(fontWeight: FontWeight.bold),
            //           )),
            //           DataColumn(
            //               label: Text(
            //             'Print',
            //             style: TextStyle(fontWeight: FontWeight.bold),
            //           )),
            //           DataColumn(
            //               label: Text(
            //             'Status',
            //             style: TextStyle(fontWeight: FontWeight.bold),
            //           )),
            //         ],
            //         rows: List.generate(data.length, (index) {
            //           final isOddRow = index % 2 == 1;
            //           final color =
            //               isOddRow ? Colors.grey[200]! : Colors.white;
            //           return DataRow(
            //               color: MaterialStateColor.resolveWith(
            //                   (states) => color),
            //               cells: [
            //                 DataCell(Text(
            //                   '1',
            //                   style: GoogleFonts.openSans(
            //                       fontWeight: FontWeight.w600),
            //                 )),
            //                 DataCell(Text(
            //                   data['fyp-id'],
            //                   style: GoogleFonts.openSans(
            //                       fontWeight: FontWeight.w600),
            //                 )),
            //                 DataCell(Text(
            //                   'FYP Management Portal',
            //                   style: GoogleFonts.openSans(),
            //                 )),
            //                 DataCell(Container(

            //                     // padding: EdgeInsets.all(10.0 * 0.75),
            //                     height: 35,
            //                     width: 35,
            //                     decoration: BoxDecoration(
            //                       color: Colors.blue.withOpacity(0.1),
            //                       borderRadius: const BorderRadius.all(
            //                           Radius.circular(10)),
            //                     ),
            //                     child: Theme(
            //                       data: ThemeData(
            //                         hoverColor: Colors.transparent,
            //                       ),
            //                       child: IconButton(
            //                           onPressed: () {},
            //                           icon: Icon(
            //                             Icons.description_rounded,
            //                             size: 20,
            //                           ),
            //                           color: Colors.blue),
            //                     ))),
            //                 DataCell(Container(

            //                     // padding: EdgeInsets.all(10.0 * 0.75),
            //                     height: 35,
            //                     width: 35,
            //                     decoration: BoxDecoration(
            //                       color: Color(0xFF007EE5).withOpacity(0.1),
            //                       borderRadius: const BorderRadius.all(
            //                           Radius.circular(10)),
            //                     ),
            //                     child: Theme(
            //                       data: ThemeData(
            //                           hoverColor: Colors.transparent),
            //                       child: IconButton(
            //                         onPressed: () {},
            //                         icon: Icon(
            //                           Icons.picture_as_pdf,
            //                           size: 20,
            //                         ),
            //                         color: Color(0xFF007EE5),
            //                       ),
            //                     ))),
            //                 DataCell(
            //                   Container(
            //                     width: 90,
            //                     decoration: BoxDecoration(
            //                         color: Colors.green.withOpacity(0.2),
            //                         borderRadius: BorderRadius.circular(2)),
            //                     child: Padding(
            //                       padding: EdgeInsets.all(10.0),
            //                       child: Text(
            //                         ('Approved'),
            //                         style: GoogleFonts.openSans(
            //                             color: Colors.green,
            //                             fontSize: 14,
            //                             fontWeight: FontWeight.w600),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ]);
            //         }).toList(),
            //       ),
            //     ),
            //   ),
            // ])
          );
        });
  }
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
  var fontBold = await PdfGoogleFonts.tinosBold();

  var color = Colors.blue;
  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
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
                        font: fontBold,
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
                      4: pw.FlexColumnWidth(3),
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
                                      font: fontBold, fontSize: 11),
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
                                      font: fontBold, fontSize: 11),
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
                                      font: fontBold, fontSize: 11),
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
                                      font: fontBold, fontSize: 11),
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
                                      font: fontBold, fontSize: 11),
                                ),
                              ),
                            ]),
                            pw.Column(children: [
                              pw.Container(
                                padding: const pw.EdgeInsets.all(6.0),
                                alignment: pw.Alignment.topLeft,
                                child: pw.Text(
                                  'Endorsed Ideas',
                                  style: pw.TextStyle(
                                      font: fontBold, fontSize: 11),
                                ),
                              ),
                            ]),
                          ]),
                      for (var i = 0; i < 3; i++) ...[
                        pw.TableRow(children: [
                          pw.Column(children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(6.0),
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text(
                                value[i]['fyp-id'],
                                style: pw.TextStyle(font: font, fontSize: 8),
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
                                        pw.TextStyle(font: font, fontSize: 8),
                                  ),
                                  pw.Text(
                                    value[i]['regno2'],
                                    style:
                                        pw.TextStyle(font: font, fontSize: 8),
                                  ),
                                  pw.Text(
                                    value[i]['regno3'],
                                    style:
                                        pw.TextStyle(font: font, fontSize: 8),
                                  ),
                                ])),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(6.0),
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text(
                                value[i]['main-supervisor'],
                                style: pw.TextStyle(font: font, fontSize: 8),
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(6.0),
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text(
                                value[i]['co-supervisor'],
                                style: pw.TextStyle(font: font, fontSize: 8),
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
                                            font: font, fontSize: 8),
                                      ),
                                      pw.SizedBox(
                                        height: 2,
                                      ),
                                      pw.Text(
                                        proposal_2docs[i]['project-title'],
                                        style: pw.TextStyle(
                                            font: font, fontSize: 8),
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
                                        proposal_1docs[i]
                                            ['supervisor-accepted'],
                                        style: pw.TextStyle(
                                            font: font, fontSize: 8),
                                      ),
                                      pw.SizedBox(
                                        height: 2,
                                      ),
                                      pw.Text(
                                        proposal_2docs[i]
                                            ['supervisor-accepted'],
                                        style: pw.TextStyle(
                                            font: font, fontSize: 8),
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
                      pw.Text('$collection',
                          style: pw.TextStyle(font: fontBold, fontSize: 10)),
                      pw.Text('Supervisor BSIT',
                          style: pw.TextStyle(font: fontBold, fontSize: 10)),
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

firstproposal(String value, var value2) {
  String topic = 'Main Topic Details';
  var docid1;
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
          return const Text('No Proposal Submitted yet');
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
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
                                Expanded(
                                  child: Text(
                                    db["project-title"],
                                    softWrap: true,
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
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: <Widget>[
                                                        _readproposal(
                                                            db, value2, topic),
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
                              ElevatedButton(
                                  onPressed: () {
                                    var approval = FirebaseFirestore.instance
                                        .collection('Convenor')
                                        .doc('classes')
                                        .collection('BS Information Technology')
                                        .doc('groups')
                                        .collection('group-members')
                                        .doc(value)
                                        .collection('proposals')
                                        .doc('proposals')
                                        .collection('proposal1')
                                        .doc(docid1)
                                        .update({
                                      'supervisor-approval': 'Endorsed'
                                    });

                                    var approvedtitle = FirebaseFirestore
                                        .instance
                                        .collection('Convenor')
                                        .doc('classes')
                                        .collection('BS Information Technology')
                                        .doc('groups')
                                        .collection('group-members')
                                        .doc(value)
                                        .collection('proposals')
                                        .doc('proposals')
                                        .collection('proposal1')
                                        .doc(docid1)
                                        .update({
                                      'supervisor-accepted': db['project-title']
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 50, 107, 50),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 15),
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                      )),
                                  child: const Text('Endorse')),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    var rejection = FirebaseFirestore.instance
                                        .collection('Convenor')
                                        .doc('classes')
                                        .collection('BS Information Technology')
                                        .doc('groups')
                                        .collection('group-members')
                                        .doc(value)
                                        .collection('proposals')
                                        .doc('proposals')
                                        .collection('proposal1')
                                        .doc(docid1)
                                        .update({
                                      'supervisor-approval': 'Rejected'
                                    });

                                    var approvedtitle = FirebaseFirestore
                                        .instance
                                        .collection('Convenor')
                                        .doc('classes')
                                        .collection('BS Information Technology')
                                        .doc('groups')
                                        .collection('group-members')
                                        .doc(value)
                                        .collection('proposals')
                                        .doc('proposals')
                                        .collection('proposal1')
                                        .doc(docid1)
                                        .update({'supervisor-accepted': ''});
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 180, 34, 34),
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
                                  var pending = FirebaseFirestore.instance
                                      .collection('Convenor')
                                      .doc('classes')
                                      .collection('BS Information Technology')
                                      .doc('groups')
                                      .collection('group-members')
                                      .doc(value)
                                      .collection('proposals')
                                      .doc('proposals')
                                      .collection('proposal1')
                                      .doc(docid1)
                                      .update(
                                          {'supervisor-approval': 'Pending'});

                                  var approvedtitle = FirebaseFirestore.instance
                                      .collection('Convenor')
                                      .doc('classes')
                                      .collection('BS Information Technology')
                                      .doc('groups')
                                      .collection('group-members')
                                      .doc(value)
                                      .collection('proposals')
                                      .doc('proposals')
                                      .collection('proposal1')
                                      .doc(docid1)
                                      .update({'supervisor-accepted': ''});
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 15),
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                    )),
                                child: const Text('Pending'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _multipage(db, value2, topic);
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                      child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: 200,
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                height: 2,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              const Text(
                                'Approval Status',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Supervisor',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0D46BB),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          db['supervisor-approval'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Co-Supervisor',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0D46BB),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          db['co-supervisor-approval'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Convenor',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0D46BB),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          db['convenor-approval'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )))
                ],
              );
            }

            return const Text('null');
          },
        );
      });
}

secondproposal(String value, var value2) {
  String topic = 'FYP Topic(Option 2)';
  var docid2;
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
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
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        ('Proposal 2'),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
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
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: <Widget>[
                                                        _readproposal(
                                                            db, value2, topic),
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
                              ElevatedButton(
                                  onPressed: () {
                                    var approval = FirebaseFirestore.instance
                                        .collection('Convenor')
                                        .doc('classes')
                                        .collection('BS Information Technology')
                                        .doc('groups')
                                        .collection('group-members')
                                        .doc(value)
                                        .collection('proposals')
                                        .doc('proposals')
                                        .collection('proposal2')
                                        .doc(docid2)
                                        .update({
                                      'supervisor-approval': 'Endorsed'
                                    });

                                    var approvedtitle = FirebaseFirestore
                                        .instance
                                        .collection('Convenor')
                                        .doc('classes')
                                        .collection('BS Information Technology')
                                        .doc('groups')
                                        .collection('group-members')
                                        .doc(value)
                                        .collection('proposals')
                                        .doc('proposals')
                                        .collection('proposal2')
                                        .doc(docid2)
                                        .update({
                                      'supervisor-accepted': db['project-title']
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 50, 107, 50),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 15),
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                      )),
                                  child: const Text('Endorse')),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    var rejection = FirebaseFirestore.instance
                                        .collection('Convenor')
                                        .doc('classes')
                                        .collection('BS Information Technology')
                                        .doc('groups')
                                        .collection('group-members')
                                        .doc(value)
                                        .collection('proposals')
                                        .doc('proposals')
                                        .collection('proposal2')
                                        .doc(docid2)
                                        .update({
                                      'supervisor-approval': 'Rejected'
                                    });

                                    var approvedtitle = FirebaseFirestore
                                        .instance
                                        .collection('Convenor')
                                        .doc('classes')
                                        .collection('BS Information Technology')
                                        .doc('groups')
                                        .collection('group-members')
                                        .doc(value)
                                        .collection('proposals')
                                        .doc('proposals')
                                        .collection('proposal2')
                                        .doc(docid2)
                                        .update({'supervisor-accepted': ''});
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 180, 34, 34),
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
                                  var pending = FirebaseFirestore.instance
                                      .collection('Convenor')
                                      .doc('classes')
                                      .collection('BS Information Technology')
                                      .doc('groups')
                                      .collection('group-members')
                                      .doc(value)
                                      .collection('proposals')
                                      .doc('proposals')
                                      .collection('proposal2')
                                      .doc(docid2)
                                      .update(
                                          {'supervisor-approval': 'Pending'});

                                  var approvedtitle = FirebaseFirestore.instance
                                      .collection('Convenor')
                                      .doc('classes')
                                      .collection('BS Information Technology')
                                      .doc('groups')
                                      .collection('group-members')
                                      .doc(value)
                                      .collection('proposals')
                                      .doc('proposals')
                                      .collection('proposal2')
                                      .doc(docid2)
                                      .update({'supervisor-accepted': ''});
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 15),
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                    )),
                                child: const Text('Pending'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _multipage(db, value2, topic);
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                      child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: 200,
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                height: 2,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              const Text(
                                'Approval Status',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Supervisor',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0D46BB),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          db['supervisor-approval'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Co-Supervisor',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0D46BB),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          db['co-supervisor-approval'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Convenor',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0D46BB),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          db['convenor-approval'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )))
                ],
              );
            }

            return const Text('null');
          },
        );
      });
}

_readproposal(var snap, var value2, String topic) {
  var sample = value2;

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
                        snap["group-id"],
                        style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
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
  var fontBold = await PdfGoogleFonts.tinosBold();

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  final netImage = await networkImage(
    'https://upload.wikimedia.org/wikipedia/en/e/e4/National_Textile_University_Logo.png',
  );

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
                                font: fontBold,
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
                              font: fontBold,
                            ),
                          ),
                          // pw.SizedBox(height: 10),
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
                              font: fontBold,
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
                            style: pw.TextStyle(fontSize: 16, font: fontBold),
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
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Container(
            margin:
                const pw.EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Divider(height: 10, thickness: 3),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                    'FYP Proposal',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 20,
                      font: fontBold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    '$topic',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 18,
                      font: fontBold,
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
                                      font: fontBold,
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
                                      font: fontBold,
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
                                      font: fontBold,
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
                                      font: fontBold,
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
                      font: fontBold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'PROBLEM STATEMENT',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: fontBold,
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
                      font: fontBold,
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
                    style: pw.TextStyle(fontSize: 14, font: fontBold),
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
                      font: fontBold,
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
                      font: fontBold,
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
                      font: fontBold,
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
                      font: fontBold,
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
                      font: fontBold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['proposed-methodology'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'GANTT CHART',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: fontBold,
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
                  ),
                ]),
          ),
        ]; // Center
      }));

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
