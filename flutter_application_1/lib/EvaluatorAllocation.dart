// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, use_key_in_widget_constructors, sort_child_properties_last, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/convenor_screens/demoallgroups.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart';


List storedocs = [];

class EvaluatorAllocation extends StatelessWidget {
  final headline = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  final subhead = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Open Sans',
  );

  final body = GoogleFonts.roboto(
    fontSize: 16,
    color: Color.fromRGBO(87, 99, 108, 1),
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  _createPDF();
                },
                icon: Icon(
                  Icons.print,
                  size: 20,
                ),
                label: Text('Print')),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      "/Convenor/classes/BS Information Technology/groups/group-members")
                  .orderBy('fyp-id')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot groupData = snapshot.data!.docs[index];

                    // snapshot.data!.docs.map((DocumentSnapshot document) {
                    //   Map a = document.data() as Map<String, dynamic>;
                    //   storedocs.add(a);
                    //   a['id'] = document.id;
                    // }).toList();

                    return Column(
                      children: [
                        Container(
                          height: 210,
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 35),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 3),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            'FYP id ',
                                            style: headline,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Text(
                                              groupData['fyp-id'],
                                              style: body,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Supervisor ',
                                            style: headline,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            groupData['main-supervisor'],
                                            style: body,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Title',
                                            style: headline,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Text(
                                              groupData['accepted-idea'],
                                              style: body,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                // AllocateEvaluators(
                                //   doc: groupData.id,
                                //   snap: groupData,
                                // ),
                                EvaluatorsData(
                                    doc1: groupData.id, snap1: groupData)
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EvaluatorsData extends StatefulWidget {
  final String doc1;
  var snap1;
  EvaluatorsData({required this.doc1, required this.snap1});

  @override
  State<EvaluatorsData> createState() => _EvaluatorsDataState();
}

class _EvaluatorsDataState extends State<EvaluatorsData> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                "/Convenor/classes/BS Information Technology/groups/group-members")
            .doc(widget.doc1)
            .collection('Internal Evaluator')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return AllocateEvaluators(doc: widget.doc1, snap: widget.snap1);
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              // Build your widget based on the data from Firestore
              return Container(
                // height: 200,
                // margin: EdgeInsets.only(right: 40),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          // _selectedValue,
                          'Evaluator 1: ',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            // color: Color.fromRGBO(87, 99, 108, 1),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          // _selectedValue,
                          documentSnapshot['evaluator1'],
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Color.fromRGBO(87, 99, 108, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 170,
                    ),
                    Row(
                      children: [
                        Text(
                          // _selectedValue,
                          'Evaluator 2: ',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            // color: Color.fromRGBO(87, 99, 108, 1),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          // _selectedValue,
                          documentSnapshot['evaluator2'],
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Color.fromRGBO(87, 99, 108, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       // setState(() {
                        //       //   _showDropDown = true;
                        //       // });
                        //     },
                        //     child: Text('Update')),
                      ],
                    ),
                    Expanded(child: Container())
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AllocateEvaluators extends StatefulWidget {
  final String doc;
  var snap;
  AllocateEvaluators({required this.doc, required this.snap});

  @override
  State<AllocateEvaluators> createState() => _AllocateEvaluatorsState();
}

class _AllocateEvaluatorsState extends State<AllocateEvaluators> {
  String _evaluator1 = '';
  String _evaluator2 = '';

  bool showSelection = false;

  bool _showDropDown = true;
  var evaluator2;

  var evaluator1;

  int numberOfDocuments = 0;
  Map<String, int> nameDocumentCount = {};

  final names = [
    "Dr. Muhammad Asif Habib",
    "Dr. Mudassar Ahmad",
    "Dr. Rehan Ashraf",
    "Dr. Haseeb Ahmad",
    "Dr. Isma Hamid",
    "Dr. Muhammad Asif",
    "Dr. Shahbaz Ahmad",
    "Mr. Waqar Ahmad",
    "Dr. CM Nadeem Faisal",
    "Dr. Toqeer Mahmood",
    "Dr. Hamid Ali",
    "Dr. Abdul Qayoom",
    "Dr. Muhammad Adeel",
    "Dr. Suleman Raza",
    "Dr. Aisha Younas",
    "Dr. Sajida Parveen",
    "Dr. Inam Illahi",
    "Mr. Muhammad Shahid",
    "Mr. Nasir Mahmood",
    "Mr. Shahbaz Ahmad Sahi",
    "Mr. Muhammad Naeem",
    "Mr. Arsal Mahmood",
    "Mr. Muhammad Nouman",
    "Miss Sana Ikram",
    "Miss Sara Naeem",
    "Miss Kainat Rizwan",
    "Miss Humael Hassan",
    "Miss Saira Ishtiaq"
  ];

  @override
  void initState() {
    super.initState();
    for (String name in names) {
      FirebaseFirestore.instance
          .collection('/Evaluations/evaluations/Internal')
          .doc('internal-evaluators')
          .collection(name)
          .get()
          .then((querySnapshot) {
        setState(() {
          nameDocumentCount[name] = querySnapshot.docs.length;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(top: 35, bottom: 10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(7)),
                  child: DropdownButton<String>(
                    hint: Text(
                      'Choose Evaluator 1',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Color.fromRGBO(87, 99, 108, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    value: evaluator1,
                    items: names.map((String name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Color.fromRGBO(87, 99, 108, 1),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            nameDocumentCount[name] == null
                                ? Container()
                                : Text(
                                    '${nameDocumentCount[name]} groups',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Color.fromRGBO(87, 99, 108, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ],
                        ),
                      );
                    }).toList(),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 35,
                    underline: SizedBox(),
                    onChanged: (value) {
                      FirebaseFirestore.instance
                          .collection('/Evaluations/evaluations/Internal')
                          .doc('internal-evaluators')
                          .collection(value!)
                          .get()
                          .then((querySnapshot) {
                        setState(() {
                          evaluator1 = value;
                          numberOfDocuments = querySnapshot.docs.length;
                        });
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(7)),
                  child: DropdownButton<String>(
                    hint: Text(
                      'Choose Evaluator 2',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Color.fromRGBO(87, 99, 108, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    value: evaluator2,
                    items: names.map((String name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Color.fromRGBO(87, 99, 108, 1),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            nameDocumentCount[name] == null
                                ? Container()
                                : Text(
                                    '${nameDocumentCount[name]} groups',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Color.fromRGBO(87, 99, 108, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ],
                        ),
                      );
                    }).toList(),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 35,
                    underline: SizedBox(),
                    onChanged: (value) {
                      FirebaseFirestore.instance
                          .collection('/Evaluations/evaluations/Internal')
                          .doc('internal-evaluators')
                          .collection(value!)
                          .get()
                          .then((querySnapshot) {
                        setState(() {
                          evaluator2 = value;
                          numberOfDocuments = querySnapshot.docs.length;
                        });
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _evaluator1 = evaluator1;
                      _evaluator2 = evaluator2;
                      // _showDropDown = false;
                      _allocationButton(widget.doc, widget.snap);
                    });
                  },
                  child: Text(
                    'Allocate',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      // primary: Colors.indigo[600],
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(
                        fontSize: 20,
                      )),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          // Expanded(child: Container())
        ],
      ),
    )

        // visible: _selectedValue.isNotEmpty,
        );
  }

  void _allocationButton(String doc, var snap) {
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
      'accepted-idea': snap['accepted-idea'],
      "evaluator1": evaluator1,
      "evaluator2": evaluator2,
      "meevaluator": evaluator1,
      "coevaluator" : evaluator2,
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
      'accepted-idea': snap['accepted-idea'],
      "evaluator2": evaluator2,
      "evaluator1": evaluator1,
      "meevaluator": evaluator2,
      "coevaluator" : evaluator1,
    });

    var clc = FirebaseFirestore.instance
        .collection(
            '/Convenor/classes/BS Information Technology/groups/group-members')
        .doc(doc)
        .update({
      'internal1': evaluator1,
      "internal2": evaluator2,
    });
  }
}

String getCurrentDate() {
  var date = DateTime.now().toString();

  var dateParse = DateTime.parse(date);

  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  return formattedDate.toString();
}

_createPDF() async {
  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  QuerySnapshot snapshot = await _db
      .collection(
          "/Convenor/classes/BS Information Technology/groups/group-members")
      .orderBy('fyp-id')
      .get();
  List<DocumentSnapshot> documents = snapshot.docs;

  final doc = pw.Document();
  var font = await PdfGoogleFonts.tinosRegular();
  var fontBold = await PdfGoogleFonts.tinosBold();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          margin: const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
          child: pw.Column(children: [
            pw.Text(
              'National Textile Univeristy, Faisalabad',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text(
              'Department of Computer Science',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text(
                'BSIT Final Year Project (FYP) Internal Evaluation notification (Tentative*)',
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
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
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
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
                              documents[i]['fyp-id'],
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
                                documents[i]['regno1'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                documents[i]['regno2'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                documents[i]['regno3'],
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
                                documents[i]['internal1'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.SizedBox(height: 1),
                              pw.Text(
                                documents[i]['internal2'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                            ]),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(6.0),
                        child: pw.Text(
                          documents[i]['accepted-idea'],
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
                _createPDF();
              },
              child: const Text("Print"))
        ],
      ),
    ),
  );
}












// Widget _buildTable(BuildContext context, List<DocumentSnapshot> snapshot) {
//   return  ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: snapshot.data.docs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     DocumentSnapshot document = snapshot.data!.docs[index];

//                     snapshot.data!.docs.map((DocumentSnapshot document) {
//                       Map a = document.data() as Map<String, dynamic>;
//                       storedocs.add(a);
//                       a['id'] = document.id;
//                     }).toList();

//                     {
//                       String abc = document.id;
//                       String section = document["class"];
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [ ] );}});

//  DataTable(
//   columns: <DataColumn>[
//     DataColumn(
//       label: Text('FYP ID'),
//     ),
//     DataColumn(
//       label: Text('Main Supervisor'),
//     ),
//     DataColumn(
//       label: Text('Accepted Idea'),
//     ),
//   ],
//   rows: List.generate(snapshot.length, (index) {
//     return DataRow(
//       color: MaterialStateColor.resolveWith((states) =>
//           index % 2 == 0 ? Colors.grey[200]! : Colors.transparent),
//       cells: [
//         DataCell(
//           Text(snapshot[index]['fyp-id']),
//         ),
//         DataCell(
//           Text(snapshot[index]['main-supervisor']),
//         ),
//         DataCell(
//           Text(snapshot[index]['accepted-idea']),
//         ),
//       ],
//       // color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
//     );
//   }),
// );

// class DummyEvaluators extends StatefulWidget {
//   const DummyEvaluators({super.key});

//   @override
//   State<DummyEvaluators> createState() => _DummyEvaluatorsState();
// }

// var evaluator1;
// var evaluator2;

// final List storedocs = [];
// List evaluatorList = [
//   "Dr. Asif Habib",
//   "Mr. Shahbaz Ahmad",
//   "Dr. Suleman Naqvi",
//   "Dr. M Hamid",
//   "Mr. M Naeem",
//   "Mr. M Shahid",
//   "Dr. M Adeel",
//   "Dr. M Asif",
//   "Mr. Arsal Mehmood",
//   "Ms. Sara Naeem"
// ];

// class _DummyEvaluatorsState extends State<DummyEvaluators> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//           decoration:
//               const BoxDecoration(color: Color.fromARGB(255, 244, 246, 249)),
//           child: Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Column(
//               children: [
//                 Card(
//                   child: Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     TextButton.icon(
//                                       onPressed: () {},
//                                       style: TextButton.styleFrom(
//                                           foregroundColor: Colors.white),
//                                       icon: const Icon(
//                                         Icons.person,
//                                         color: Colors.black,
//                                       ),
//                                       label: const Text(
//                                         'Assign Evaluators  |',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           color:
//                                               Color.fromARGB(255, 46, 43, 43),
//                                           // fontWeight: FontWeight.bold,
//                                           fontFamily: 'HelveticaNeue',
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     TextButton.icon(
//                                       onPressed: () {
//                                         _createPDF(storedocs);
//                                       },
//                                       icon: const Icon(
//                                         Icons.print,
//                                         color: Colors.blue,
//                                         size: 16,
//                                       ),
//                                       label: const Text(
//                                         'Print',
//                                         style: TextStyle(
//                                           fontSize: 15,

//                                           // fontWeight: FontWeight.bold,
//                                           fontFamily: 'HelveticaNeue',
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     TextButton.icon(
//                                       onPressed: () {},
//                                       icon: const Icon(
//                                         Icons.refresh,
//                                         color: Colors.blue,
//                                         size: 16,
//                                       ),
//                                       label: const Text(
//                                         'Refresh',
//                                         style: TextStyle(
//                                           fontSize: 15,

//                                           // fontWeight: FontWeight.bold,
//                                           fontFamily: 'HelveticaNeue',
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           const Divider(
//                             height: 1,
//                           ),
//                           groups(),
//                         ],
//                       )),
//                 )
//               ],
//             ),
//           )),
//     );
//   }

//   groups() {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(
//                 '/Convenor/classes/BS Information Technology/groups/group-members')
//             .where('fyp-id', isEqualTo: '23-FYP-309')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Column(
//               children: [
//                 ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       DocumentSnapshot document = snapshot.data!.docs[index];

//                       snapshot.data!.docs.map((DocumentSnapshot document) {
//                         Map a = document.data() as Map<String, dynamic>;
//                         storedocs.add(a);
//                         a['id'] = document.id;
//                       }).toList();

//                       {
//                         String abc = document.id;
//                         String section = document["class"];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Card(
//                                 // margin:
//                                 //     const EdgeInsets.fromLTRB(80, 40, 80, 40),

//                                 child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 30, left: 20, right: 20, bottom: 50),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         child: Container(
//                                           padding: const EdgeInsets.all(8),
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                             color: Colors.blue,
//                                           ),
//                                           child: Text(
//                                             document["fyp-id"],
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Container(
//                                     width: 1200,
//                                     margin: const EdgeInsets.fromLTRB(
//                                         40, 20, 40, 0),
//                                     decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(20)),
//                                     child: DataTable(
//                                       dataTextStyle:
//                                           const TextStyle(fontSize: 14),
//                                       columns: const <DataColumn>[
//                                         DataColumn(
//                                           label: Expanded(
//                                             child: Text(
//                                               'Group id',
//                                               style: TextStyle(
//                                                   fontStyle: FontStyle.italic,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                         ),
//                                         DataColumn(
//                                           label: Expanded(
//                                             child: Text(
//                                               'Supervisor',
//                                               style: TextStyle(
//                                                   fontStyle: FontStyle.italic,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                         ),
//                                         DataColumn(
//                                           label: Expanded(
//                                             child: Text(
//                                               'Title',
//                                               style: TextStyle(
//                                                   fontStyle: FontStyle.italic,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                       rows: <DataRow>[
//                                         DataRow(
//                                           cells: <DataCell>[
//                                             DataCell(Text(
//                                               document["fyp-id"],
//                                             )),
//                                             DataCell(Text(
//                                               document["main-supervisor"],
//                                             )),
//                                             DataCell(Text(
//                                               document["accepted-idea"],
//                                             )),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   const Divider(
//                                     height: 1,
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   evaluators(document.id, document)
//                                   //  fetchdata(document.id),
//                                 ],
//                               ),
//                             )),
//                             const SizedBox(
//                               height: 25,
//                             ),
//                             const Divider(
//                               height: 1,
//                             ),
//                           ],
//                         );
//                       }
//                     }),
//               ],
//             );
//           }
//         });
//   }

//   evaluators(String docid, var snap) {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(
//                 '/Convenor/classes/BS Information Technology/groups/group-members')
//             .doc(docid)
//             .collection('Internal Evaluator')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.data?.size == 0) {
//             return assignevaluators(docid, snap);
//           }

//           return ListView.builder(
//               shrinkWrap: true,
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 DocumentSnapshot db = snapshot.data!.docs[index];

//                 if (snapshot.hasData) {
//                   return Container(
//                     margin: const EdgeInsets.only(top: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Internal Evaluators:",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'HelveticaNeue',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(
//                               left: 30, right: 30, top: 25, bottom: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(children: [
//                                 const Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "Evaluator 1: ",
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontFamily: 'HelveticaNeue',
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: const EdgeInsets.only(left: 5),
//                                   // margin: EdgeInsets.all(20),
//                                   height: 40,
//                                   width: 160,
//                                   decoration: BoxDecoration(
//                                       color: Colors.blue,
//                                       borderRadius: BorderRadius.circular(6)),
//                                   child: Center(
//                                     child: Text(
//                                       db['evaluator1'],
//                                       style: const TextStyle(
//                                           color: Colors.white, fontSize: 16),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                               Row(
//                                 children: [
//                                   const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       "Evaluator 2: ",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontFamily: 'HelveticaNeue',
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     // margin: EdgeInsets.only(left: 14),
//                                     height: 40,
//                                     width: 160,
//                                     decoration: BoxDecoration(
//                                         color: Colors.blue,
//                                         borderRadius: BorderRadius.circular(8)),
//                                     child: Center(
//                                       child: Text(
//                                         db['evaluator2'],
//                                         style: const TextStyle(
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//                 return assignevaluators(docid, snap);
//               });
//         });
//   }

  

//   assignevaluators(String doc, var snap) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             const Text(
//               "Evaluator 1",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               width: 30,
//             ),
//             Container(
//               width: 200,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: const Text(
//                       "Choose Evaluator 1",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     value: evaluator1,
//                     onChanged: (newValue) {
//                       setState(() {
//                         evaluator1 = newValue;
//                       });
//                     },
//                     items: evaluatorList.map((valueItem) {
//                       return DropdownMenuItem(
//                         value: valueItem,
//                         child: Text(valueItem),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//             const Text(
//               "Evaluator 2",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               width: 45,
//             ),
//             Container(
//               width: 200,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(5),
//                   color: Colors.white),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     hint: const Text(
//                       "Choose Evaluator 2",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     value: evaluator2,
//                     onChanged: (newValue) {
//                       setState(() {
//                         evaluator2 = newValue;
//                       });
//                     },
//                     items: evaluatorList.map((valueItem) {
//                       return DropdownMenuItem(
//                         value: valueItem,
//                         child: Text(valueItem),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               var db = FirebaseFirestore.instance
//                   .collection(
//                       '/Convenor/classes/BS Information Technology/groups/group-members')
//                   .doc(doc)
//                   .collection('Internal Evaluator');

//               db.add({
//                 "evaluator1": evaluator1,
//                 "evaluator2": evaluator2,
//               });

//               var internal1collection = FirebaseFirestore.instance
//                   .collection('Evaluations')
//                   .doc('evaluations')
//                   .collection('Internal')
//                   .doc('internal-evaluators')
//                   .collection(evaluator1)
//                   .add({
//                 'mem1': snap['mem1'],
//                 'mem2': snap['mem2'],
//                 'mem3': snap['mem3'],
//                 'fyp-id': snap['fyp-id'],
//                 'regno1': snap['regno1'],
//                 'regno2': snap['regno2'],
//                 'regno3': snap['regno3'],
//                 'main-supervisor': snap['main-supervisor'],
//                 'co-supervisor': snap['co-supervisor'],
//               });

//               var internal2collection = FirebaseFirestore.instance
//                   .collection('Evaluations')
//                   .doc('evaluations')
//                   .collection('Internal')
//                   .doc('internal-evaluators')
//                   .collection(evaluator2)
//                   .add({
//                 'mem1': snap['mem1'],
//                 'mem2': snap['mem2'],
//                 'mem3': snap['mem3'],
//                 'fyp-id': snap['fyp-id'],
//                 'regno1': snap['regno1'],
//                 'regno2': snap['regno2'],
//                 'regno3': snap['regno3'],
//                 'main-supervisor': snap['main-supervisor'],
//                 'co-supervisor': snap['co-supervisor'],
//               });

//               var clc = FirebaseFirestore.instance
//                   .collection(
//                       '/Convenor/classes/BS Information Technology/groups/group-members')
//                   .doc(doc)
//                   .update({
//                 'internal1': evaluator1,
//                 "internal2": evaluator2,
//               });

//               showDialog(
//                   context: context,
//                   builder: (ctx) => AlertDialog(
//                         title: const Text(
//                           "Evaluator Allocation",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(ctx);
//                             },
//                             child: const Text("OK"),
//                           ),
//                         ],
//                         content: const Text("Allocated",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 20, 107, 23))),
//                       ));
//             });
//           },
//           style: ElevatedButton.styleFrom(
//               primary: Colors.blue,
//               padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
//               textStyle:
//                   const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//           child: const Text('Assign'),
//         )
//       ],
//     );
//   }
// }
