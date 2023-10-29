import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/convenor_screens/demoallgroups.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart';

class InternalEvaluators extends StatefulWidget {
  const InternalEvaluators({super.key});

  @override
  State<InternalEvaluators> createState() => _InternalEvaluatorsState();
}

var evaluator1;
var evaluator2;

final List storedocs = [];
List evaluatorList = [
  "Dr. Asif Habib",
  "Mr. Shahbaz Ahmad",
  "Dr. Suleman Naqvi",
  "Dr M Hamid",
  "Mr M Naeem",
  "Mr. M Shahid",
  "Dr M Adeel",
  "Dr M Asif",
  "Mr Arsal Mehmood",
  "Ms. Sara Naeem"
];

class _InternalEvaluatorsState extends State<InternalEvaluators> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 244, 246, 249)),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Card(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white),
                                      icon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      label: const Text(
                                        'Assign Evaluators  |',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 46, 43, 43),
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: 'HelveticaNeue',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        _createPDF(storedocs);
                                      },
                                      icon: const Icon(
                                        Icons.print,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                      label: const Text(
                                        'Print',
                                        style: TextStyle(
                                          fontSize: 15,

                                          // fontWeight: FontWeight.bold,
                                          fontFamily: 'HelveticaNeue',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.refresh,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                      label: const Text(
                                        'Refresh',
                                        style: TextStyle(
                                          fontSize: 15,

                                          // fontWeight: FontWeight.bold,
                                          fontFamily: 'HelveticaNeue',
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          groups(),
                        ],
                      )),
                )
              ],
            ),
          )),
    );
  }

  groups() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                '/Convenor/classes/BS Information Technology/groups/group-members')
            .orderBy('fyp-id')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];

                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map a = document.data() as Map<String, dynamic>;
                        storedocs.add(a);
                        a['id'] = document.id;
                      }).toList();

                      {
                        String abc = document.id;
                        String section = document["class"];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                                // margin:
                                //     const EdgeInsets.fromLTRB(80, 40, 80, 40),

                                child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20, bottom: 50),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.blue,
                                          ),
                                          child: Text(
                                            document["fyp-id"],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1200,
                                    margin: const EdgeInsets.fromLTRB(
                                        40, 20, 40, 0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: DataTable(
                                      dataTextStyle:
                                          const TextStyle(fontSize: 14),
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Sr No.',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Registration No',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: <DataRow>[
                                        DataRow(
                                          cells: <DataCell>[
                                            const DataCell(Text('1')),
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
                                            const DataCell(Text('2')),
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
                                            const DataCell(Text('3')),
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
                                  evaluators(document.id, document)
                                  //  fetchdata(document.id),
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
              ],
            );
          }
        });
  }

  evaluators(String docid, var snap) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                '/Convenor/classes/BS Information Technology/groups/group-members')
            .doc(docid)
            .collection('Internal Evaluator')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return assignevaluators(docid, snap);
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot db = snapshot.data!.docs[index];

                if (snapshot.hasData) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Internal Evaluators:",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'HelveticaNeue',
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 25, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Evaluator 1: ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'HelveticaNeue',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  // margin: EdgeInsets.all(20),
                                  height: 40,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Center(
                                    child: Text(
                                      db['evaluator1'],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ]),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Evaluator 2: ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'HelveticaNeue',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(left: 14),
                                    height: 40,
                                    width: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                        db['evaluator2'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return assignevaluators(docid, snap);
              });
        });
  }

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  _createPDF(List value) async {
    String getCurrentDate() {
      var date = DateTime.now().toString();

      var dateParse = DateTime.parse(date);

      var formattedDate =
          "${dateParse.day}-${dateParse.month}-${dateParse.year}";
      return formattedDate.toString();
    }

    final doc = pw.Document();
    var font = await PdfGoogleFonts.tinosRegular();
    var fontBold = await PdfGoogleFonts.tinosBold();

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin:
                const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
            child: pw.Column(children: [
              pw.Text(
                'National Textile Univeristy, Faisalabad',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Text(
                'Department of Computer Science',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Text(
                  'BSIT Final Year Project (FYP) Internal Evaluation notification (Tentative*)',
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(
                height: 30,
              ),
              pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(1),
                    2: pw.FlexColumnWidth(1),
                    3: pw.FlexColumnWidth(2),
                  },
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(children: [
                      pw.Column(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6.0),
                          alignment: pw.Alignment.center,
                          child: pw.Center(
                            child: pw.Text(
                              'FYP ID',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6.0),
                          alignment: pw.Alignment.center,
                          child: pw.Center(
                            child: pw.Text(
                              'Reg No',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6.0),
                          alignment: pw.Alignment.center,
                          child: pw.Center(
                            child: pw.Text(
                              'Evaluators',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6.0),
                          alignment: pw.Alignment.center,
                          child: pw.Center(
                            child: pw.Text(
                              'Project title',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ]),
                    for (var i = 0; i < 14; i++) ...[
                      pw.TableRow(children: [
                        pw.Column(children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.all(6.0),
                            alignment: pw.Alignment.center,
                            child: pw.Center(
                              child: pw.Text(
                                value[i]['fyp-id'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        pw.Container(
                          padding: pw.EdgeInsets.all(6.0),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  value[i]['regno1'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                                pw.Text(
                                  value[i]['regno2'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                                pw.Text(
                                  value[i]['regno3'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                              ]),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.all(6.0),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  value[i]['internal1'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                                pw.SizedBox(height: 1),
                                pw.Text(
                                  value[i]['internal2'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                              ]),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.all(6.0),
                          child: pw.Text(
                            value[i]['accepted-idea'],
                            style: const pw.TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ]),
                    ]
                  ]),
              pw.SizedBox(height: 30),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Dated: ${getCurrentDate()}',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 10)),
                  pw.Column(children: [
                    pw.Text('Shahbaz Ahmad Sahi',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    pw.Text('Convener, BSIT, FYP Committee',
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
                  _createPDF(value);
                },
                child: const Text("Print"))
          ],
        ),
      ),
    );
  }

  assignevaluators(String doc, var snap) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Evaluator 1",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 30,
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: const Text(
                      "Choose Evaluator 1",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    value: evaluator1,
                    onChanged: (newValue) {
                      setState(() {
                        evaluator1 = newValue;
                      });
                    },
                    items: evaluatorList.map((valueItem) {
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
              "Evaluator 2",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 45,
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: const Text(
                      "Choose Evaluator 2",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    value: evaluator2,
                    onChanged: (newValue) {
                      setState(() {
                        evaluator2 = newValue;
                      });
                    },
                    items: evaluatorList.map((valueItem) {
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
                  .collection(
                      '/Convenor/classes/BS Information Technology/groups/group-members')
                  .doc(doc)
                  .collection('Internal Evaluator');

              db.add({
                "evaluator1": evaluator1,
                "evaluator2": evaluator2,
              });

              var internal1collection = FirebaseFirestore.instance
                  .collection('Evaluations')
                  .doc('evaluations')
                  .collection('Internal')
                  .doc('internal-evaluators')
                  .collection(evaluator1)
                  .add({
                'mem1': snap['mem1'],
                'mem2': snap['mem2'],
                'mem3': snap['mem3'],
                'fyp-id': snap['fyp-id'],
                'regno1': snap['regno1'],
                'regno2': snap['regno2'],
                'regno3': snap['regno3'],
                'main-supervisor': snap['main-supervisor'],
                'co-supervisor': snap['co-supervisor'],
                'accepted-idea': snap['accepted-idea']
              });

              var internal2collection = FirebaseFirestore.instance
                  .collection('Evaluations')
                  .doc('evaluations')
                  .collection('Internal')
                  .doc('internal-evaluators')
                  .collection(evaluator2)
                  .add({
                'mem1': snap['mem1'],
                'mem2': snap['mem2'],
                'mem3': snap['mem3'],
                'fyp-id': snap['fyp-id'],
                'regno1': snap['regno1'],
                'regno2': snap['regno2'],
                'regno3': snap['regno3'],
                'main-supervisor': snap['main-supervisor'],
                'co-supervisor': snap['co-supervisor'],
                 'accepted-idea': snap['accepted-idea']
              });

              var clc = FirebaseFirestore.instance
                  .collection(
                      '/Convenor/classes/BS Information Technology/groups/group-members')
                  .doc(doc)
                  .update({
                'internal1': evaluator1,
                "internal2": evaluator2,
              });

              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text(
                          "Evaluator Allocation",
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
                        content: const Text("Allocated",
                            style: TextStyle(
                                color: Color.fromARGB(255, 20, 107, 23))),
                      ));
            });
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          child: const Text('Assign'),
        )
      ],
    );
  }
}
