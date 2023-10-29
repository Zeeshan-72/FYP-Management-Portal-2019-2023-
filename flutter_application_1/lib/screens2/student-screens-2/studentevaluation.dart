// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentEvaluations extends StatefulWidget {
  const StudentEvaluations({super.key});

  @override
  State<StudentEvaluations> createState() => _StudentEvaluationsState();
}

class _StudentEvaluationsState extends State<StudentEvaluations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: DefaultTabController(
          length: 2,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ignore: prefer_const_constructors
                Container(
                  width: 400,
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors
                          .blue, // Set the background color of the selected tab
                    ),
                    labelColor:
                        Colors.white, // Set the text color of the selected tab
                    unselectedLabelColor: Colors.black,

                    tabs: [
                      Tab(text: '7th Semester'),
                      Tab(text: '8th Semester'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      children: [
                        DefaultTabController(
                          length: 4,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(13),
                                  height: 50,
                                  color: Colors.blue,
                                  width: double.infinity,
                                  child: Text(
                                    'Semester 7',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'HelveticaNeue',
                                    ),
                                  ),
                                ),
                                TabBar(
                                  labelColor: Colors
                                      .blue, // Set the text color of the selected tab
                                  unselectedLabelColor: Colors.black,
                                  tabs: [
                                    Tab(
                                      text: 'Evaluators',
                                    ),
                                    Tab(text: 'Supervisor Evaluation'),
                                    Tab(text: 'Internal Evaluation'),
                                    Tab(text: 'External Evaluation'),
                                  ],
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      Scrollbar(
                                        controller: ScrollController(),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Container(
                                            height: 300,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 50),
                                            child: DataTable(
                                              dataRowHeight: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 238, 238, 238),
                                                    width: 1.0),
                                              ),
                                              columns: const <DataColumn>[
                                                DataColumn(
                                                    label: Text(
                                                  'Sr#',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  'Group Id',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  'Title',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  'Evaluator 1',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  'Evaluator 2',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  'Date / Time',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  'Venue',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ],
                                              rows: <DataRow>[
                                                DataRow(
                                                  color: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          Color(0xFFEEEEEE)),
                                                  cells: <DataCell>[
                                                    DataCell(Text(
                                                      '1',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    )),
                                                    DataCell(Text(
                                                      '23-FYP-304',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    )),
                                                    DataCell(Flexible(
                                                      child: Text(
                                                        'FYP Management Portal',
                                                        style: GoogleFonts
                                                            .openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    )),
                                                    DataCell(Text(
                                                      'Dr. Muhammad Asif',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    )),
                                                    DataCell(Text(
                                                      'Miss Saira Ishtiaq',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    )),
                                                    DataCell(Text(
                                                      '23-02-2023 / 8:00 AM- 8:30 AM',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    )),
                                                    DataCell(Text(
                                                      'FYP Lab',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    )),
                                                  ],
                                                ),
                                                // Add more DataRow widgets for additional rows of data
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                            height: 50,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: Colors.blue
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text(
                                              'Not Marked Yet...',
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600),
                                            ))),
                                      ),
                                      Center(
                                        child: Container(
                                            height: 50,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: Colors.blue
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text(
                                              'Not Marked Yet...',
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600),
                                            ))),
                                      ),
                                      Center(
                                        child: Container(
                                            height: 50,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: Colors.blue
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text(
                                              'Not Marked Yet...',
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600),
                                            ))),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(13),
                              height: 50,
                              color: Colors.blue,
                              width: double.infinity,
                              child: Text(
                                'Semester 8',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'HelveticaNeue',
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                  margin: EdgeInsets.only(top: 150),
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    'Not Marked Yet...',
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w600),
                                  ))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
