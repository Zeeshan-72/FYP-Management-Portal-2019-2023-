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

class EvaluatorAllocationFinal extends StatefulWidget {
  const EvaluatorAllocationFinal({super.key});

  @override
  State<EvaluatorAllocationFinal> createState() =>
      _EvaluatorAllocationFinalState();
}

class _EvaluatorAllocationFinalState extends State<EvaluatorAllocationFinal> {
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
    "Mr. Pir Bakhash",
    "Mr. Muhammad Nouman",
    "Miss Sana Ikram",
    "Miss Sara Naeem",
    "Miss Kainat Rizwan",
    "Miss Humael Hassan",
    "Miss Saira Ishtiaq"
  ];
  List<String> filteredNames = []; //
  @override
  void initState() {
    super.initState();
    filteredNames = List.from(names);
    // for (String name in names) {
    //   FirebaseFirestore.instance
    //       .collection(
    //           '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators')
    //       .doc('8-internal-evaluators')
    //       .collection(name)
    //       .get()
    //       .then((querySnapshot) {
    //     setState(() {
    //       nameDocumentCount[name] = querySnapshot.docs.length;
    //     });
    //   });
    //  }

    // fetchData();
  }

  Future<void> fetchDocumentCount() async {
    for (String name in names) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection(
              '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators')
          .doc('8-internal-evaluators')
          .collection(name)
          .get();

      setState(() {
        nameDocumentCount[name] = querySnapshot.docs.length;
      });
    }
  }

//copy data from one collection to another
  // Future<List<Map<String, dynamic>>> fetchData() async {
  //   final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection(
  //           '/Convenor/classes/BS Information Technology/groups/group-members')
  //       .get();

  //   List<Map<String, dynamic>> data = querySnapshot.docs
  //       .map((doc) => doc.data() as Map<String, dynamic>)
  //       .toList();

  //   for (var rowData in data) {
  //     final CollectionReference newCollection = FirebaseFirestore.instance
  //         .collection(
  //             '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups');

  //     Map<String, dynamic> documentData = {
  //       '8-evaluator1': '',
  //       '8-evaluator2': '',
  //       'overall-supervisory-status': '',
  //       ...rowData,
  //     };

  //     newCollection.doc(rowData['fyp-id']).set(documentData);
  //   }

  //   return querySnapshot.docs
  //       .map((doc) => doc.data() as Map<String, dynamic>)
  //       .toList();
  // }

  Stream<List<Map<String, dynamic>>> presentable_groups() {
    return FirebaseFirestore.instance
        .collection(
            '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups')
        // .where('overall-supervisory-status', isEqualTo: 'Presentable')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> not_presentable_groups() {
    return FirebaseFirestore.instance
        .collection(
            '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups')
        .where('overall-supervisory-status', isEqualTo: 'Not-Presentable')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String collectionName =
      '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators/8-internal-evaluators/Dr. CM Nadeem Faisal  ';
  final String fieldName = 'fyp-id';
  final dynamic fieldValue = '23-FYP-302';

  Future<void> deleteDocuments() async {
    QuerySnapshot querySnapshot = await firestore
        .collection(collectionName)
        .where(fieldName, isEqualTo: fieldValue)
        .get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
      print('Document deleted successfully.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 8.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 1090,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 50),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(13),
                          height: 50,
                          color: Colors.green[400],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ready to Present (Internal Evaluation)',
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
                        StreamBuilder<List<Map<String, dynamic>>>(
                            stream: presentable_groups(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ); // Show a loading indicator while fetching data
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List<Map<String, dynamic>> data =
                                    snapshot.data!;
                                if (data.isEmpty) {
                                  return Center(
                                      child: Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    width: 300,
                                    height: 50,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue[100]),
                                    child: Center(
                                      child: Text('No groups yet',
                                          style: GoogleFonts.sourceSansPro(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ));
                                }

                                return DataTable(
                                  dataRowHeight: 55,
                                  // columnSpacin: 30,
                                  columns: [
                                    DataColumn(
                                        label: Text('Sr#',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Group ID',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Title',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Evaluator 1',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Evaluator 2',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Action',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                  ],

                                  rows: data.asMap().entries.map((entry) {
                                    final int index = entry.key +
                                        1; // Add 1 to start index from 1
                                    final Map<String, dynamic> row =
                                        entry.value;
                                    return DataRow(
                                        color: index % 2 == 0
                                            ? MaterialStateColor.resolveWith(
                                                (states) => Color.fromARGB(
                                                    255, 233, 236, 239))
                                            : null,
                                        cells: [
                                          DataCell(Text('$index',
                                              style: GoogleFonts.sourceSansPro(
                                                  fontSize: 15))),
                                          DataCell(Text(row['fyp-id'],
                                              style: GoogleFonts.sourceSansPro(
                                                  fontSize: 15))),
                                          DataCell(Text(row['accepted-idea'],
                                              style: GoogleFonts.sourceSansPro(
                                                  fontSize: 15))),
                                          DataCell(SizedBox(
                                            width: 150,
                                            child: Text(
                                                '${row['8-evaluator1'].isNotEmpty ? row['8-evaluator1'] : '--'}',
                                                // textAlign: rowData['8-evaluator1'].isEmpty
                                                //     ? TextAlign.center
                                                //     : TextAlign.start,
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        fontSize: 15)),
                                          )),
                                          DataCell(SizedBox(
                                            width: 150,
                                            child: Text(
                                                '${row['8-evaluator2'].isNotEmpty ? row['8-evaluator2'] : '--'}',
                                                // textAlign: rowData['8-evaluator1'].isEmpty
                                                //     ? TextAlign.center
                                                //     : TextAlign.start,
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        fontSize: 15)),
                                          )),
                                          DataCell(
                                              row['8-evaluator1'].isEmpty &&
                                                      row['8-evaluator2']
                                                          .isEmpty
                                                  ? ElevatedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                  title: Text(
                                                                      'Allocate Evaluators',
                                                                      style: GoogleFonts.sourceSansPro(
                                                                          fontSize:
                                                                              24,
                                                                          fontWeight: FontWeight
                                                                              .w700)),
                                                                  content:
                                                                      Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            20),
                                                                    width: 400,
                                                                    height: 300,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .stretch,
                                                                      children: [
                                                                        Container(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 13),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.grey[200],
                                                                              borderRadius: BorderRadius.circular(7)),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: StatefulBuilder(
                                                                                  builder: (BuildContext context, StateSetter setState) {
                                                                                    Map<int, String> selectedValues = {};

                                                                                    return DropdownButton<String>(
                                                                                      isExpanded: true,
                                                                                      hint: Text(
                                                                                        'Choose Evaluator 1',
                                                                                        style: GoogleFonts.roboto(
                                                                                          fontSize: 14,
                                                                                          color: Color.fromRGBO(87, 99, 108, 1),
                                                                                          fontWeight: FontWeight.w400,
                                                                                        ),
                                                                                      ),
                                                                                      value: evaluator1,
                                                                                      onChanged: (newValue) {
                                                                                        FirebaseFirestore.instance.collection('/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators').doc('8-internal-evaluators').collection(newValue!).get().then((querySnapshot) {
                                                                                          setState(() {
                                                                                            evaluator1 = newValue;
                                                                                            numberOfDocuments = querySnapshot.docs.length;
                                                                                          });
                                                                                        });
                                                                                      },
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
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              60,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                13,
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.grey[200],
                                                                              borderRadius: BorderRadius.circular(7)),
                                                                          child:
                                                                              StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                                                            return DropdownButton<String>(
                                                                              isExpanded: true,
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
                                                                                FirebaseFirestore.instance.collection('/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators').doc('8-internal-evaluators').collection(value!).get().then((querySnapshot) {
                                                                                  setState(() {
                                                                                    evaluator2 = value;
                                                                                    numberOfDocuments = querySnapshot.docs.length;
                                                                                  });
                                                                                });
                                                                              },
                                                                            );
                                                                          }),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              60,
                                                                        ),
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              _allocationButton(row);
                                                                              Navigator.of(context).pop();

                                                                              // _evaluator1 = evaluator1;
                                                                              // _evaluator2 = evaluator2;
                                                                              // _showDropDown = false;
                                                                              // _allocationButton(widget.doc, widget.snap);
                                                                            });
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Allocate',
                                                                            style:
                                                                                GoogleFonts.roboto(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          style: ElevatedButton.styleFrom(
                                                                              // primary: Colors.indigo[600],
                                                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                                                              textStyle: TextStyle(
                                                                                fontSize: 20,
                                                                              )),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      child: Text(
                                                                          'Close'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    )
                                                                  ]);
                                                            });
                                                      },
                                                      style: ButtonStyle(
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size(
                                                                    50, 40)),
                                                      ),
                                                      child: Text('Allocate'),
                                                    )
                                                  : Row(
                                                      children: [
                                                        Container(

                                                            // padding: EdgeInsets.all(10.0 * 0.75),
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.blue
                                                                  .withOpacity(
                                                                      0.1),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          10)),
                                                            ),
                                                            child: Theme(
                                                              data: ThemeData(
                                                                hoverColor: Colors
                                                                    .transparent, // Set hover color to transparent
                                                              ),
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        title:
                                                                            Text(
                                                                          'Group Details',
                                                                          style: GoogleFonts.sourceSansPro(
                                                                              fontSize: 24,
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              400,
                                                                          width:
                                                                              500,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Group Id: ',
                                                                                    style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 30,
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue.withOpacity(0.1)),
                                                                                    child: Text(
                                                                                      row['fyp-id'],
                                                                                      style: GoogleFonts.sourceSansPro(),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Project Title: ',
                                                                                    style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue.withOpacity(0.1)),
                                                                                      child: Flexible(
                                                                                        child: Text(
                                                                                          row['accepted-idea'],
                                                                                          style: GoogleFonts.sourceSansPro(),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Main Supervisor',
                                                                                    style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue.withOpacity(0.1)),
                                                                                      child: Flexible(
                                                                                        child: Text(
                                                                                          row['main-supervisor'],
                                                                                          style: GoogleFonts.sourceSansPro(),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Co Supervisor',
                                                                                    style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue.withOpacity(0.1)),
                                                                                      child: Flexible(
                                                                                        child: Text(
                                                                                          row['co-supervisor'],
                                                                                          style: GoogleFonts.sourceSansPro(),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Evaluator 1: ',
                                                                                    style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue.withOpacity(0.1)),
                                                                                      child: Flexible(
                                                                                        child: Text(
                                                                                          row['8-evaluator1'],
                                                                                          style: GoogleFonts.sourceSansPro(),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Evaluator 2: ',
                                                                                    style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue.withOpacity(0.1)),
                                                                                      child: Flexible(
                                                                                        child: Text(
                                                                                          row['8-evaluator2'],
                                                                                          style: GoogleFonts.sourceSansPro(),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 30,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text('Close')),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .remove_red_eye_sharp,
                                                                  size: 20,
                                                                ),
                                                                color:
                                                                    Colors.blue,
                                                                splashColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        // Container(

                                                        //     // padding: EdgeInsets.all(10.0 * 0.75),
                                                        //     height: 35,
                                                        //     width: 35,
                                                        //     decoration:
                                                        //         BoxDecoration(
                                                        //       color: Color(
                                                        //               0xFFFFA113)
                                                        //           .withOpacity(
                                                        //               0.1),
                                                        //       borderRadius:
                                                        //           const BorderRadius
                                                        //                   .all(
                                                        //               Radius.circular(
                                                        //                   10)),
                                                        //     ),
                                                        //     child: Theme(
                                                        //       data: ThemeData(
                                                        //           hoverColor: Colors
                                                        //               .transparent),
                                                        //       child: IconButton(
                                                        //         onPressed: () {
                                                        //           showDialog(
                                                        //               context:
                                                        //                   context,
                                                        //               builder:
                                                        //                   (BuildContext
                                                        //                       context) {
                                                        //                 return AlertDialog(
                                                        //                     title:
                                                        //                         Text('Update Evaluators', style: GoogleFonts.sourceSansPro(fontSize: 24, fontWeight: FontWeight.w700)),
                                                        //                     content: Container(
                                                        //                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                        //                       width: 400,
                                                        //                       height: 300,
                                                        //                       child: Column(
                                                        //                         crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        //                         children: [
                                                        //                           Container(
                                                        //                             padding: EdgeInsets.symmetric(horizontal: 13),
                                                        //                             decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(7)),
                                                        //                             child: Row(
                                                        //                               children: [
                                                        //                                 Expanded(
                                                        //                                   child: StatefulBuilder(
                                                        //                                     builder: (BuildContext context, StateSetter setState) {

                                                        //                                       return DropdownButton<String>(
                                                        //                                         isExpanded: true,
                                                        //                                         hint: Text(
                                                        //                                           'Choose Evaluator 1',
                                                        //                                           style: GoogleFonts.roboto(
                                                        //                                             fontSize: 14,
                                                        //                                             color: Color.fromRGBO(87, 99, 108, 1),
                                                        //                                             fontWeight: FontWeight.w400,
                                                        //                                           ),
                                                        //                                         ),
                                                        //                                         value: evaluator1,
                                                        //                                         onChanged: (newValue) {
                                                        //                                           FirebaseFirestore.instance.collection('/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators').doc('8-internal-evaluators').collection(newValue!).get().then((querySnapshot) {
                                                        //                                             setState(() {
                                                        //                                               evaluator1 = newValue;
                                                        //                                               numberOfDocuments = querySnapshot.docs.length;
                                                        //                                             });
                                                        //                                           });
                                                        //                                         },
                                                        //                                         items: names.map((String name) {
                                                        //                                           return DropdownMenuItem<String>(
                                                        //                                             value: name,
                                                        //                                             child: Row(
                                                        //                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //                                               children: [
                                                        //                                                 Text(
                                                        //                                                   name,
                                                        //                                                   style: GoogleFonts.roboto(
                                                        //                                                     fontSize: 14,
                                                        //                                                     color: Color.fromRGBO(87, 99, 108, 1),
                                                        //                                                     fontWeight: FontWeight.w400,
                                                        //                                                   ),
                                                        //                                                 ),
                                                        //                                                 nameDocumentCount[name] == null
                                                        //                                                     ? Container()
                                                        //                                                     : Text(
                                                        //                                                         '${nameDocumentCount[name]} groups',
                                                        //                                                         style: GoogleFonts.roboto(
                                                        //                                                           fontSize: 14,
                                                        //                                                           color: Color.fromRGBO(87, 99, 108, 1),
                                                        //                                                           fontWeight: FontWeight.w400,
                                                        //                                                         ),
                                                        //                                                       ),
                                                        //                                               ],
                                                        //                                             ),
                                                        //                                           );
                                                        //                                         }).toList(),
                                                        //                                         icon: Icon(Icons.arrow_drop_down),
                                                        //                                         iconSize: 35,
                                                        //                                         underline: SizedBox(),
                                                        //                                       );
                                                        //                                     },
                                                        //                                   ),
                                                        //                                 ),
                                                        //                               ],
                                                        //                             ),
                                                        //                           ),
                                                        //                           SizedBox(
                                                        //                             height: 60,
                                                        //                           ),
                                                        //                           Container(
                                                        //                             padding: EdgeInsets.symmetric(
                                                        //                               horizontal: 13,
                                                        //                             ),
                                                        //                             decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(7)),
                                                        //                             child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                                        //                               return DropdownButton<String>(
                                                        //                                 isExpanded: true,
                                                        //                                 hint: Text(
                                                        //                                   'Choose Evaluator 2',
                                                        //                                   style: GoogleFonts.roboto(
                                                        //                                     fontSize: 14,
                                                        //                                     color: Color.fromRGBO(87, 99, 108, 1),
                                                        //                                     fontWeight: FontWeight.w400,
                                                        //                                   ),
                                                        //                                 ),
                                                        //                                 value: evaluator2,
                                                        //                                 items: names.map((String name) {
                                                        //                                   return DropdownMenuItem<String>(
                                                        //                                     value: name,
                                                        //                                     child: Row(
                                                        //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //                                       children: [
                                                        //                                         Text(
                                                        //                                           name,
                                                        //                                           style: GoogleFonts.roboto(
                                                        //                                             fontSize: 14,
                                                        //                                             color: Color.fromRGBO(87, 99, 108, 1),
                                                        //                                             fontWeight: FontWeight.w400,
                                                        //                                           ),
                                                        //                                         ),
                                                        //                                         nameDocumentCount[name] == null
                                                        //                                             ? Container()
                                                        //                                             : Text(
                                                        //                                                 '${nameDocumentCount[name]} groups',
                                                        //                                                 style: GoogleFonts.roboto(
                                                        //                                                   fontSize: 14,
                                                        //                                                   color: Color.fromRGBO(87, 99, 108, 1),
                                                        //                                                   fontWeight: FontWeight.w400,
                                                        //                                                 ),
                                                        //                                               ),
                                                        //                                       ],
                                                        //                                     ),
                                                        //                                   );
                                                        //                                 }).toList(),
                                                        //                                 icon: Icon(Icons.arrow_drop_down),
                                                        //                                 iconSize: 35,
                                                        //                                 underline: SizedBox(),
                                                        //                                 onChanged: (value) {
                                                        //                                   FirebaseFirestore.instance.collection('/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators').doc('8-internal-evaluators').collection(value!).get().then((querySnapshot) {
                                                        //                                     setState(() {
                                                        //                                       evaluator2 = value;
                                                        //                                       numberOfDocuments = querySnapshot.docs.length;
                                                        //                                     });
                                                        //                                   });
                                                        //                                 },
                                                        //                               );
                                                        //                             }),
                                                        //                           ),
                                                        //                           SizedBox(
                                                        //                             height: 60,
                                                        //                           ),
                                                        //                           ElevatedButton(
                                                        //                             onPressed: () {
                                                        //                               setState(() {
                                                        //                                 _updationButton(row);
                                                        //                                 Navigator.of(context).pop();

                                                        //                                 // _evaluator1 = evaluator1;
                                                        //                                 // _evaluator2 = evaluator2;
                                                        //                                 // _showDropDown = false;
                                                        //                                 // _allocationButton(widget.doc, widget.snap);
                                                        //                               });
                                                        //                             },
                                                        //                             child: Text(
                                                        //                               'Update',
                                                        //                               style: GoogleFonts.roboto(
                                                        //                                 fontSize: 20,
                                                        //                                 fontWeight: FontWeight.w600,
                                                        //                               ),
                                                        //                             ),
                                                        //                             style: ElevatedButton.styleFrom(
                                                        //                                 backgroundColor: Color(0xFFFFA113),
                                                        //                                 // primary: Colors.indigo[600],
                                                        //                                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                                        //                                 textStyle: TextStyle(
                                                        //                                   fontSize: 20,
                                                        //                                 )),
                                                        //                           ),
                                                        //                         ],
                                                        //                       ),
                                                        //                     ),
                                                        //                     actions: <Widget>[
                                                        //                       TextButton(
                                                        //                         child: Text('Close'),
                                                        //                         onPressed: () {
                                                        //                           Navigator.of(context).pop();
                                                        //                         },
                                                        //                       )
                                                        //                     ]);
                                                        //               });
                                                        //         },
                                                        //         icon: Icon(
                                                        //           Icons.edit,
                                                        //           size: 20,
                                                        //         ),
                                                        //         color: Color(
                                                        //             0xFFFFA113),
                                                        //         splashColor: Colors
                                                        //             .transparent,
                                                        //         highlightColor:
                                                        //             Colors
                                                        //                 .transparent,
                                                        //       ),
                                                        //     ))

                                                        // // Add more DataCell widgets for each column you have
                                                      ],
                                                    ))
                                        ]);
                                  }).toList(),

                                  //                   ],

                                  //                 ),
                                  //         ),
                                  //       ]);
                                  // })
                                );
                              }
                            })
                      ]),
                ),
              ),
            ),
          ),

          // Not Ready to Present

          Container(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 8.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 1090,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 50),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(13),
                          height: 50,
                          color: Colors.red[400],
                          child: Text('Not Ready to Present',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ),
                        StreamBuilder<List<Map<String, dynamic>>>(
                            stream: not_presentable_groups(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ); // Show a loading indicator while fetching data
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List<Map<String, dynamic>> data =
                                    snapshot.data!;
                                if (data.isEmpty) {
                                  return Center(
                                      child: Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    width: 300,
                                    height: 50,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue[100]),
                                    child: Center(
                                      child: Text(
                                          'Supervisor Evaluation is pending',
                                          style: GoogleFonts.sourceSansPro(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ));
                                }

                                return DataTable(
                                  dataRowHeight: 55,
                                  // columnSpacin: 30,
                                  columns: [
                                    DataColumn(
                                        label: Text('Sr#',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Group ID',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Title',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Evaluator 1',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Evaluator 2',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    DataColumn(
                                        label: Text('Action',
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                  ],

                                  rows: data.asMap().entries.map((entry) {
                                    final int index = entry.key +
                                        1; // Add 1 to start index from 1
                                    final Map<String, dynamic> row =
                                        entry.value;
                                    return DataRow(
                                        color: index % 2 == 0
                                            ? MaterialStateColor.resolveWith(
                                                (states) => Color.fromARGB(
                                                    255, 233, 236, 239))
                                            : null,
                                        cells: [
                                          DataCell(Text('$index',
                                              style: GoogleFonts.sourceSansPro(
                                                  fontSize: 15))),
                                          DataCell(Text(row['fyp-id'],
                                              style: GoogleFonts.sourceSansPro(
                                                  fontSize: 15))),
                                          DataCell(Text(row['accepted-idea'],
                                              style: GoogleFonts.sourceSansPro(
                                                  fontSize: 15))),
                                          DataCell(SizedBox(
                                            width: 150,
                                            child: Text(
                                                '${row['8-evaluator1'].isNotEmpty ? row['8-evaluator1'] : '--'}',
                                                // textAlign: rowData['8-evaluator1'].isEmpty
                                                //     ? TextAlign.center
                                                //     : TextAlign.start,
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        fontSize: 15)),
                                          )),
                                          DataCell(SizedBox(
                                            width: 150,
                                            child: Text(
                                                '${row['8-evaluator2'].isNotEmpty ? row['8-evaluator2'] : '--'}',
                                                // textAlign: rowData['8-evaluator1'].isEmpty
                                                //     ? TextAlign.center
                                                //     : TextAlign.start,
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        fontSize: 15)),
                                          )),
                                          DataCell(ElevatedButton(
                                              onPressed: null,
                                              child: Text('Allocate',
                                                  style:
                                                      GoogleFonts.sourceSansPro(
                                                          fontSize: 15))))
                                        ]);
                                  }).toList(),

                                  //                   ],

                                  //                 ),
                                  //         ),
                                  //       ]);
                                  // })
                                );
                              }
                            })
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
        .collection(
            "/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups")
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
                                  documents[i]['8-evaluator1'],
                                  style: const pw.TextStyle(
                                    fontSize: 8.0,
                                  ),
                                ),
                                pw.SizedBox(height: 1),
                                pw.Text(
                                  documents[i]['8-evaluator2'],
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

  Future<void> _updationButton(Map<String, dynamic> snap) async {
    var db = FirebaseFirestore.instance
        .collection(
            '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups')
        .doc(snap['fyp-id'])
        .update(
      {'8-evaluator1': evaluator1, '8-evaluator2': evaluator2},
    );

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators')
        .doc('8-internal-evaluators')
        .collection(evaluator1)
        .where('fyp-id',
            isEqualTo: snap['fyp-id']) // Replace with your WHERE clause
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      await documentSnapshot.reference.delete();
      print('Document deleted successfully.');
    } else {
      print('No document found with the specified condition.');
    }

    var internal1collection = FirebaseFirestore.instance
        .collection(
            '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators')
        .doc('8-internal-evaluators')
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
      "coevaluator": evaluator2,
    });

    var internal2collection = FirebaseFirestore.instance
        .collection(
            '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators')
        .doc('8-internal-evaluators')
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
      "coevaluator": evaluator1,
    });

    // var clc = FirebaseFirestore.instance
    //     .collection(
    //         '/Convenor/classes/BS Information Technology/groups/group-members')
    //     .doc(doc)
    //     .update({
    //   'internal1': evaluator1,
    //   "internal2": evaluator2,
    // });
  }

  void _allocationButton(Map<String, dynamic> snap) {
    var db = FirebaseFirestore.instance
        .collection(
            '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups')
        .doc(snap['fyp-id'])
        .update(
      {'8-evaluator1': evaluator1, '8-evaluator2': evaluator2},
    );

    var internal1collection = FirebaseFirestore.instance
        .collection(
            '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators')
        .doc('8-internal-evaluators')
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
      "coevaluator": evaluator2,
    });

    var internal2collection = FirebaseFirestore.instance
        .collection(
            '/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/8-internal-evaluators')
        .doc('8-internal-evaluators')
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
      "coevaluator": evaluator1,
    });

    // var clc = FirebaseFirestore.instance
    //     .collection(
    //         '/Convenor/classes/BS Information Technology/groups/group-members')
    //     .doc(doc)
    //     .update({
    //   'internal1': evaluator1,
    //   "internal2": evaluator2,
    // });
  }
}
