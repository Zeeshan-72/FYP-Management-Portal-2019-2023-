// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/convenor_screens/demoallgroups.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart';

class ExternalGroupAllocation extends StatefulWidget {
  const ExternalGroupAllocation({super.key});

  @override
  State<ExternalGroupAllocation> createState() =>
      _ExternalGroupAllocationState();
}

class _ExternalGroupAllocationState extends State<ExternalGroupAllocation> {
  // String _evaluator1 = '';
  // String _evaluator2 = '';

  bool showSelection = false;

  bool _showDropDown = true;
  var evaluator2;

  var evaluator1;

  int numberOfDocuments = 0;
  Map<String, int> nameDocumentCount = {};

  var selectedName;

  List<String> evaluator1_list = List.generate(13, (index) => '');
  List<String> names = [];

  Future<List<String>> fetchNamesFromFirestore() async {
    // Access the Firestore collection
    CollectionReference collection =
        FirebaseFirestore.instance.collection('/External/accounts/Evaluators');

    // Fetch the documents in the collection
    QuerySnapshot snapshot = await collection.get();

    // Iterate over each document and retrieve the "Name" field
    snapshot.docs.forEach((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data?.containsKey('Name') == true) {
        String? name = data!['Name'];
        if (name != null) {
          names.add(name);
        }
      }
    });

    return names;
  }

  List<String> filteredNames = []; //
  @override
  void initState() {
    super.initState();
    fetchNamesFromFirestore();
  }

  CollectionReference collection = FirebaseFirestore.instance
      .collection('/External/accounts/presentable-groups');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          width: 1090,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              padding: EdgeInsets.all(13),
              height: 50,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ready to Present (External Evaluation)',
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
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
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: collection.orderBy('fyp-id').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final documents = snapshot.data!.docs;

                  return DataTable(
                    dataRowHeight: 55,
                    // columnSpacin: 30,
                    columns: [
                      DataColumn(
                          label: Text('Sr#',
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 16, fontWeight: FontWeight.w600))),
                      DataColumn(
                          label: Text('Group ID',
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 16, fontWeight: FontWeight.w600))),
                      DataColumn(
                          label: Text('Title',
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 16, fontWeight: FontWeight.w600))),
                      DataColumn(
                          label: Text('External Evaluator',
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 16, fontWeight: FontWeight.w600))),
                      DataColumn(
                          label: Text('Action',
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 16, fontWeight: FontWeight.w600))),
                    ],

                    rows: List<DataRow>.generate(documents.length, (index) {
                      final document = documents[index];
                      final data = document.data() as Map<String, dynamic>;
                      final documentId = document.id;
                      final isEvenRow = index % 2 == 0;

                      // Convert int values to string
                      final name = data['fyp-id'].toString();
                      final email = data['accepted-idea'].toString();

                      var index2 = index + 1;
                      return DataRow(
                          color: index % 2 == 0
                              ? MaterialStateColor.resolveWith((states) =>
                                  Color.fromARGB(255, 233, 236, 239))
                              : null,
                          cells: [
                            DataCell(Text('$index2',
                                style:
                                    GoogleFonts.sourceSansPro(fontSize: 15))),
                            DataCell(Text(data['fyp-id'],
                                style:
                                    GoogleFonts.sourceSansPro(fontSize: 15))),
                            DataCell(Text(data['accepted-idea'],
                                style:
                                    GoogleFonts.sourceSansPro(fontSize: 15))),
                            DataCell(SizedBox(
                              width: 150,
                              child: Text(
                                  '${data['external-evaluator1'].isNotEmpty ? data['external-evaluator1'] : '--'}',
                                  // textAlign: dataData['8-evaluator1'].isEmpty
                                  //     ? TextAlign.center
                                  //     : TextAlign.start,
                                  style:
                                      GoogleFonts.sourceSansPro(fontSize: 15)),
                            )),
                            DataCell(data['external-evaluator1'].isEmpty
                                ? ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Text(
                                                    'Allocate External Evaluator',
                                                    style: GoogleFonts
                                                        .sourceSansPro(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                content: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                                  width: 400,
                                                  height: 200,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 13),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7)),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  StatefulBuilder(
                                                                builder: (BuildContext
                                                                        context,
                                                                    StateSetter
                                                                        setState) {
                                                                  Map<int,
                                                                          String>
                                                                      selectedValues =
                                                                      {};

                                                                  return DropdownButton<
                                                                      String>(
                                                                    isExpanded:
                                                                        true,
                                                                    hint: Text(
                                                                      'Choose Evaluator 1',
                                                                      style: GoogleFonts
                                                                          .roboto(
                                                                        fontSize:
                                                                            14,
                                                                        color: Color.fromRGBO(
                                                                            87,
                                                                            99,
                                                                            108,
                                                                            1),
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    value:
                                                                        evaluator1,
                                                                    onChanged:
                                                                        (newValue) {
                                                                      setState(
                                                                          () {
                                                                        evaluator1 =
                                                                            newValue; // Update the selected value
                                                                      });
                                                                    },
                                                                    items: names
                                                                        .map((String
                                                                            name) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            name,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              name,
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
                                                                    icon: Icon(Icons
                                                                        .arrow_drop_down),
                                                                    iconSize:
                                                                        35,
                                                                    underline:
                                                                        SizedBox(),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 60,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          var internal1collection =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      '/External/accounts/External-Evaluation')
                                                                  .doc(
                                                                      'evaluators')
                                                                  .collection(
                                                                      evaluator1)
                                                                  .add({
                                                            'mem1':
                                                                data['mem1'],
                                                            'mem2':
                                                                data['mem2'],
                                                            'mem3':
                                                                data['mem3'],
                                                            'fyp-id':
                                                                data['fyp-id'],
                                                            'regno1':
                                                                data['regno1'],
                                                            'regno2':
                                                                data['regno2'],
                                                            'regno3':
                                                                data['regno3'],
                                                            'main-supervisor': data[
                                                                'main-supervisor'],
                                                            'co-supervisor': data[
                                                                'co-supervisor'],
                                                            'accepted-idea': data[
                                                                'accepted-idea'],
                                                            "external-evaluator1":
                                                                evaluator1,
                                                            "evaluator2": '',
                                                            "meevaluator":
                                                                evaluator1,
                                                            "coevaluator": '',
                                                          });

                                                          var clc = FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  '/External/accounts/presentable-groups')
                                                              .doc(documentId)
                                                              .update({
                                                            'external-evaluator1':
                                                                evaluator1,
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'Allocate',
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                // primary: Colors.indigo[600],
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            18),
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Close'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ]);
                                          });
                                    },
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size(50, 40)),
                                    ),
                                    child: Text('Allocate'),
                                  )
                                : Row(
                                    children: [
                                      Container(

                                          // padding: EdgeInsets.all(10.0 * 0.75),
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: Theme(
                                            data: ThemeData(
                                              hoverColor: Colors
                                                  .transparent, // Set hover color to transparent
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                CollectionReference collection =
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            '/External/accounts/External-Evaluation')
                                                        .doc('evaluators')
                                                        .collection(data[
                                                            'external-evaluator1']);

                                                QuerySnapshot querySnapshot =
                                                    await collection
                                                        .where('fyp-id',
                                                            isEqualTo:
                                                                data['fyp-id'])
                                                        .get();

                                                querySnapshot.docs
                                                    .forEach((document) {
                                                  document.reference.delete();
                                                });

                                                var clc = FirebaseFirestore
                                                    .instance
                                                    .collection(
                                                        '/External/accounts/presentable-groups')
                                                    .doc(documentId)
                                                    .update({
                                                  'external-evaluator1': '',
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                size: 20,
                                              ),
                                              color: Colors.red,
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                            ),
                                          )),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ))
                          ]);
                    }).toList(),
                  );
                }),
          ]),
        ),
      ]),

      // Not Ready to Present
    ));
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

      var formattedDate =
          "${dateParse.day}-${dateParse.month}-${dateParse.year}";
      return formattedDate.toString();
    }

    final FirebaseFirestore _db = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await _db
        .collection("/External/accounts/presentable-groups")
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
                  'BSIT Final Year Project (FYP) External Evaluation notification',
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
                    for (var i = 0; i < 8; i++) ...[
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
                          padding: const pw.EdgeInsets.all(6.0),
                          alignment: pw.Alignment.center,
                          child: pw.Center(
                            child: pw.Text(
                              documents[i]['external-evaluator1'],
                              style: const pw.TextStyle(
                                fontSize: 8.0,
                              ),
                            ),
                          ),
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
              pw.SizedBox(height: 220),
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

  void _allocationButton(var snap, docid) {
    // var db = FirebaseFirestore.instance
    //     .collection(
    //         '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups')
    //     .doc(snap['fyp-id'])
    //     .update(
    //   {'8-evaluator1': evaluator1, '8-evaluator2': evaluator2},
    // );
  }
}
