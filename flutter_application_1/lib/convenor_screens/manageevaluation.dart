// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/convenor_screens/bsit-final-results.dart';
import 'package:flutter_application_1/convenor_screens/Evaluations.dart';
import 'package:flutter_application_1/EvaluatorAllocation.dart';
import 'package:flutter_application_1/screens/evaluation_screens/Internal-class-result.dart';
import 'package:flutter_application_1/screens/evaluation_screens/evaluator_list.dart';
import 'package:flutter_application_1/screens2/convenor-screens-2/final-evaluation-allocation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens2/8-Evaluations/8-Internal/8-internal-evaluator-list.dart';
import '../screens2/8-Evaluations/8-Internal/final-internal-class-result.dart';

class ManageEvaluation extends StatefulWidget {
  @override
  _ManageEvaluationState createState() => _ManageEvaluationState();
}

class _ManageEvaluationState extends State<ManageEvaluation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Evaluations  |  ',
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 46, 43, 43),
                          // fontWeight: FontWeight.bold,
                          // fontFamily: 'HelveticaNeue',
                        )),
                    Text(
                      'Internal Evaluation',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.dashboard,
                      color: Colors.blue,
                      size: 22,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Dashboard',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            // fontWeight: FontWeight.bold,
                          ),
                        )),
                    Text('/',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Evaluations',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text('/',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(' Internal',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ))
                  ],
                ),
              ],
            ),
          ),
          Container(
              height: 1000,
              child: DefaultTabController(
                length: 2,
                initialIndex: 1,
                child: Column(children: [
                  TabBar(
                    indicator: BoxDecoration(color: Colors.blue[300]),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    // indicatorPadding: EdgeInsets.all(5),
                    tabs: [
                      Container(
                        width: double.infinity,
                        // color: Colors.blue[300],
                        child: Tab(
                          child: Text('Semester 7',
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: double.infinity,
                          child: Tab(
                            child: Text('Semester 8',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      Container(
                        width: 600,
                        child: DefaultTabController(
                            length: 6, // length of tabs
                            initialIndex: 0,
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      child: TabBar(
                                        labelColor: Colors.blue,
                                        unselectedLabelColor: Colors.black,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        tabs: [
                                          Tab(
                                            child: Text('Allocation',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Tab(
                                            child: Text('Evaluators',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Tab(
                                            child: Text('Results',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        //height of TabBarView
                                        // decoration: const BoxDecoration(
                                        //     border: Border(
                                        //         top: BorderSide(
                                        //             color: Colors.grey, width: 0.5))),
                                        child: TabBarView(children: <Widget>[
                                          // InternalEvaluators(),
                                          EvaluatorAllocation(),
                                          EvaluatorsList(),
                                          InternalClassResult(),
                                        ])),
                                  ]),
                            )),
                      ),
                      Container(
                        width: 600,
                        child: DefaultTabController(
                            length: 5, // length of tabs
                            initialIndex: 0,
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      child: TabBar(
                                        labelColor: Colors.blue,
                                        unselectedLabelColor: Colors.black,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        indicatorPadding: EdgeInsets.all(5),
                                        tabs: [
                                          Tab(
                                            child: Text('Evaluators Allocation',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Tab(
                                            child: Text('Internal Evaluation',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Tab(
                                            child: Text('Internal Results',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: TabBarView(children: <Widget>[
                                          EvaluatorAllocationFinal(),
                                          FinalInternalEvaluatorList(),
                                          FinalInternalClassResult(),

                                          // InternalEvaluators(),
                                          // MyInternalGroups2(),
                                          // InternalMarksheet(),
                                          // InternalEvaluationList(),
                                        ])),
                                  ]),
                            )),
                      )
                    ]),
                  ),
                ]),
              ))
        ]))));
  }
}
