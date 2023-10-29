// ignore_for_file: non_constant_identifier_names

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ListStudentPage extends StatefulWidget {
  ListStudentPage({Key? key}) : super(key: key);

  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

var firebaseUser = FirebaseAuth.instance.currentUser;
String get path => ConvenorPath('A5Yb79Mx1oYCD4yv6iBVpERJMP33');
String get section => Convenorclass('A5Yb79Mx1oYCD4yv6iBVpERJMP33');
String get convenorname => Convenorname('A5Yb79Mx1oYCD4yv6iBVpERJMP33');

ConvenorPath(String value) {
  String path = '';

  if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
    return path =
        '/Convenor/classes/BS Information Technology/groups/group-members';
  } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
    return path = '/Convenor/classes/BS Computer Science/groups/group-members';
  } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
    return path =
        '/Convenor/classes/BS Software Engineering/groups/group-members';
  } else {
    return null;
  }
}

Convenorclass(String value) {
  String section = '';
  if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
    return section = 'BSIT';
  } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
    return section = 'BSCS';
  } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
    return section = 'BSSE';
  } else {
    return null;
  }
}

Convenorname(String value) {
  String convenorname = '';
  if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
    return convenorname = 'Shahbaz Ahmad Sahi';
  } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
    return convenorname = 'Haseeb Ahmad';
  } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
    return convenorname = 'Muhammad Shahid';
  } else {
    return null;
  }
}

final Stream<QuerySnapshot> studentsStream =
    FirebaseFirestore.instance.collection(path).orderBy('fyp-id').snapshots();

class _ListStudentPageState extends State<ListStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: studentsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {}
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final List storedocs = [];
              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                storedocs.add(a);
                a['id'] = document.id;
              }).toList();

              return SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 180.0, vertical: 40.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'National Textile Univeristy, Faisalabad',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Department of Computer Science',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            '$section Final Year Project (FYP) supervisory committee notification (Tentative*)',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 50,
                        ),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: const <int, TableColumnWidth>{},
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    color:
                                        const Color.fromARGB(255, 45, 109, 161),
                                    child: const Center(
                                      child: Text(
                                        'FYP ID',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    color:
                                        const Color.fromARGB(255, 45, 109, 161),
                                    child: const Center(
                                      child: Text(
                                        'Main Supervisor',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    color:
                                        const Color.fromARGB(255, 45, 109, 161),
                                    child: const Center(
                                      child: Text(
                                        'Co-Supervisor',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    color:
                                        const Color.fromARGB(255, 45, 109, 161),
                                    child: const Center(
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    color:
                                        const Color.fromARGB(255, 45, 109, 161),
                                    child: const Center(
                                      child: Text(
                                        'Reg Number',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            for (var i = 0; i < storedocs.length; i++) ...[
                              TableRow(
                                children: [
                                  Column(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            padding: const EdgeInsets.all(15.0),
                                            alignment: Alignment.centerLeft,
                                            // color: getBackgroundColor(),
                                            child: Text(storedocs[i]['fyp-id'],
                                                style: const TextStyle(
                                                    fontSize: 14.0))),
                                      ),
                                    ],
                                  ),
                                  TableCell(
                                    child: Container(
                                        padding: const EdgeInsets.all(15.0),
                                        alignment: Alignment.centerLeft,
                                        // color: getBackgroundColor(),
                                        child: Text(
                                            storedocs[i]['main-supervisor'],
                                            style: const TextStyle(
                                                fontSize: 14.0))),
                                  ),
                                  TableCell(
                                    child: Container(
                                        padding: const EdgeInsets.all(15.0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            storedocs[i]['co-supervisor'],
                                            style: const TextStyle(
                                                fontSize: 14.0))),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TableCell(
                                              child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(storedocs[i]['mem1'],
                                                style: const TextStyle(
                                                    fontSize: 14.0)),
                                          )),
                                          TableCell(
                                              child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(storedocs[i]['mem2'],
                                                style: const TextStyle(
                                                    fontSize: 14.0)),
                                          )),
                                          TableCell(
                                              child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(storedocs[i]['mem3'],
                                                style: const TextStyle(
                                                    fontSize: 14.0)),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          TableCell(
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    storedocs[i]['regno1'],
                                                    style: const TextStyle(
                                                        fontSize: 14.0))),
                                          ),
                                          TableCell(
                                              child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(storedocs[i]['regno2'],
                                                style: const TextStyle(
                                                    fontSize: 14.0)),
                                          )),
                                          TableCell(
                                              child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(storedocs[i]['regno3'],
                                                style: const TextStyle(
                                                    fontSize: 14.0)),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dated: ${getCurrentDate()}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Column(
                              children: [
                                Text(
                                  "$convenorname",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Convener, $section , FYP Committee',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                _createPDF(storedocs);
                              },
                              child: const Text('Print')),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  _createPDF(List value) {
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
          return pw.Container(child: pw.Text('Zeeshan'));
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
                  _createPDF(value);
                },
                child: const Text("Print"))
          ],
        ),
      ),
    );
  }
}



//  margin:
//                 const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
//             child: pw.Column(children: [
//               pw.Text(
//                 'National Textile Univeristy, Faisalabad',
//                 style:
//                     pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.SizedBox(
//                 height: 10,
//               ),
//               pw.Text(
//                 'Department of Computer Science',
//                 style:
//                     pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.SizedBox(
//                 height: 10,
//               ),
//               pw.Text(
//                   '$section Final Year Project (FYP) supervisory committee notification (Tentative*)',
//                   style: pw.TextStyle(
//                       fontSize: 12, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(
//                 height: 30,
//               ),
//               pw.Table(
//                   border: pw.TableBorder.all(),
//                   defaultVerticalAlignment:
//                       pw.TableCellVerticalAlignment.middle,
//                   children: [
//                     pw.TableRow(children: [
//                       pw.Column(children: [
//                         pw.Container(
//                           padding: const pw.EdgeInsets.all(6.0),
//                           alignment: pw.Alignment.center,
//                           child: pw.Center(
//                             child: pw.Text(
//                               'FYP ID',
//                               style: pw.TextStyle(
//                                 fontSize: 10.0,
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                       pw.Column(children: [
//                         pw.Container(
//                           padding: const pw.EdgeInsets.all(6.0),
//                           alignment: pw.Alignment.center,
//                           child: pw.Center(
//                             child: pw.Text(
//                               'Main Supervisor',
//                               style: pw.TextStyle(
//                                 fontSize: 10.0,
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                       pw.Column(children: [
//                         pw.Container(
//                           padding: const pw.EdgeInsets.all(6.0),
//                           alignment: pw.Alignment.center,
//                           child: pw.Center(
//                             child: pw.Text(
//                               'Co-Supervisor',
//                               style: pw.TextStyle(
//                                 fontSize: 10.0,
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                       pw.Column(children: [
//                         pw.Container(
//                           padding: const pw.EdgeInsets.all(6.0),
//                           alignment: pw.Alignment.center,
//                           child: pw.Center(
//                             child: pw.Text(
//                               'Name',
//                               style: pw.TextStyle(
//                                 fontSize: 10.0,
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                       pw.Column(children: [
//                         pw.Container(
//                           padding: const pw.EdgeInsets.all(6.0),
//                           alignment: pw.Alignment.center,
//                           child: pw.Center(
//                             child: pw.Text(
//                               'Reg No',
//                               style: pw.TextStyle(
//                                 fontSize: 10.0,
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ]),
//                     for (var i = 0; i < value.length; i++) ...[
//                       pw.TableRow(children: [
//                         pw.Column(children: [
//                           pw.Container(
//                             padding: const pw.EdgeInsets.all(6.0),
//                             alignment: pw.Alignment.center,
//                             child: pw.Center(
//                               child: pw.Text(
//                                 value[i]['fyp-id'],
//                                 style: const pw.TextStyle(
//                                   fontSize: 8.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]),
//                         pw.Column(children: [
//                           pw.Container(
//                             padding: const pw.EdgeInsets.all(6.0),
//                             alignment: pw.Alignment.center,
//                             child: pw.Center(
//                               child: pw.Text(
//                                 value[i]['main-supervisor'],
//                                 style: const pw.TextStyle(
//                                   fontSize: 8.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]),
//                         pw.Column(children: [
//                           pw.Container(
//                             padding: const pw.EdgeInsets.all(6.0),
//                             child: pw.Text(
//                               value[i]['co-supervisor'],
//                               style: const pw.TextStyle(
//                                 fontSize: 8.0,
//                               ),
//                             ),
//                           ),
//                         ]),
//                         pw.Container(
//                           padding: pw.EdgeInsets.all(6.0),
//                           child: pw.Column(
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Text(
//                                   value[i]['mem1'],
//                                   style: const pw.TextStyle(
//                                     fontSize: 8.0,
//                                   ),
//                                 ),
//                                 pw.Text(
//                                   value[i]['mem2'],
//                                   style: const pw.TextStyle(
//                                     fontSize: 8.0,
//                                   ),
//                                 ),
//                                 pw.Text(
//                                   value[i]['mem3'],
//                                   style: const pw.TextStyle(
//                                     fontSize: 8.0,
//                                   ),
//                                 )
//                               ]),
//                         ),
//                         pw.Container(
//                           padding: pw.EdgeInsets.all(6.0),
//                           child: pw.Column(
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Text(
//                                   value[i]['regno1'],
//                                   style: const pw.TextStyle(
//                                     fontSize: 8.0,
//                                   ),
//                                 ),
//                                 pw.Text(
//                                   value[i]['regno2'],
//                                   style: const pw.TextStyle(
//                                     fontSize: 8.0,
//                                   ),
//                                 ),
//                                 pw.Text(
//                                   value[i]['regno3'],
//                                   style: const pw.TextStyle(
//                                     fontSize: 8.0,
//                                   ),
//                                 ),
//                               ]),
//                         )
//                       ]),
//                     ]
//                   ]),
//               pw.SizedBox(height: 70),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text('Dated: ${getCurrentDate()}',
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 10)),
//                   pw.Column(children: [
//                     pw.Text(convenorname,
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold, fontSize: 10)),
//                     pw.Text('Convener, $section, FYP Committee',
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold, fontSize: 10)),
//                   ])
//                 ],
//               )
//             ]),
//           );