// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/evaluation_screens/InternalGroupResult.dart';
import 'package:flutter_application_1/screens/evaluation_screens/myinternal-groups.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens2/8-Evaluations/8-Internal/8-my-internal-groups.dart';
import '../../screens2/8-Evaluations/8-Internal/8-my-internal-marksheet.dart';

class InternalEvaluation extends StatefulWidget {
  const InternalEvaluation({Key? key}) : super(key: key);

  @override
  State<InternalEvaluation> createState() => _InternalEvaluationState();
}

class _InternalEvaluationState extends State<InternalEvaluation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
          Widget>[
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
                          length: 4, // length of tabs
                          initialIndex: 0,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    child: TabBar(
                                      labelColor: Colors.blue,
                                      unselectedLabelColor: Colors.black,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorPadding: EdgeInsets.all(5),
                                      tabs: [
                                        Tab(
                                          child: Text('Groups',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Tab(
                                          child: Text('Marks Sheet',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Tab(
                                          child: Text('Results',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Tab(
                                          child: Text('Notification',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: TabBarView(children: <Widget>[
                                        // InternalEvaluators(),
                                        MyInternalGroups2(),
                                        InternalMarksheet(),
                                        // InternalEvaluationList(),

                                        Container(
                                          child: const Center(
                                            child: Text('Results',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Container(
                                          child: const Center(
                                            child: Text('Notifications',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                      ])),
                                ]),
                          )),
                    ),
                    Container(
                      width: 600,
                      child: DefaultTabController(
                          length: 3, // length of tabs
                          initialIndex: 0,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    child: TabBar(
                                      labelColor: Colors.blue,
                                      unselectedLabelColor: Colors.black,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorPadding: EdgeInsets.all(5),
                                      tabs: [
                                        Tab(
                                          child: Text('Groups',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Tab(
                                          child: Text('Marks Sheet',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Tab(
                                          child: Text('Results',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: TabBarView(children: <Widget>[
                                        // InternalEvaluators(),
                                        MyInternalGroups_8(),
                                        my_internal_groups_marksheet(),
                                        // InternalEvaluationList(),

                                        Center(
                                          child: Container(
                                            width: 300,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.blue[200]),
                                            child: Center(
                                              child: Text('Results are pending',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                        ),
                                      ])),
                                ]),
                          )),
                    ),
                  ]),
                )
              ])),
        ),
      ]),
    )));
  }
}

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Screen"),
      ),
      body: Container(
        child: Center(
          child: Text("This is a new screen"),
        ),
      ),
    );
  }
}
