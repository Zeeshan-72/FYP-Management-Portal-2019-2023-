// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/evaluation_screens/evaluation_results.dart';
import 'package:flutter_application_1/screens/evaluation_screens/mid-evaluation-results.dart';
import 'package:flutter_application_1/student_screens/member_form.dart';

// ignore_for_file: unnecessary_string_escapes

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

final List<Map<String, dynamic>> users = [
  {"userId": "Hopu7hxZy2aIWzz0sWNMvnPxvzG3", "name": "Dr. Muhammad Asif Habib"},
  {"userId": "v6BFVgU84rc5vUivTzhqCjGt5LC3", "name": "Dr. Mudassar Ahmad"},
  {"userId": "JLJV5AExTpg2IMgWVBC8sK3774q2", "name": "Dr. Rehan Ashraf"},
  {"userId": "ouBUTRzvpbdYZLnvCBSZcXXFBMN2", "name": "Dr. Haseeb Ahmad"},
  {"userId": "zFm9gU5b1jeDDUu1tD4XyWJtsg23", "name": "Dr. Isma Hamid"},
  {"userId": "S5OGYR4RkqZ6xzKqLlrVBeXIXgG2", "name": "Dr. Muhammad Asif"},
  {"userId": "MMTvKpGtsJQRWLyqFeB1P9Jms792", "name": "Dr. Shahbaz Ahmad"},
  {"userId": "W0RSGhwWvLUUgvMGkds9xVOLSaA3", "name": "Mr. Waqar Ahmad"},
  {"userId": "EzOEIpWeYnSDCCW8O8hEoyraPko1", "name": "Dr. CM Nadeem Faisal"},
  {"userId": "RndCDn7CRKRz7uvzysR89Iga07f1", "name": "Dr. Toqeer Mehmood"},
  {"userId": "ClBK5vpwKXgl3c3WgboMLYvyBim1", "name": "Dr. Hamid Ali"},
  {"userId": "cpMIGGn4ZEfXe77uB4UOkJTQtu12", "name": "Dr. Abdul Qayyum"},
  {"userId": "vHqYdIQminUb7R6aHP5f2IAc4oQ2", "name": "Dr. Muhammad Adeel"},
  {"userId": "euP6bebMZfWPKzissugjvgiarQx1", "name": "Dr. Suleman Raza"},
  {"userId": "", "name": "Dr. Aisha Younas"},
  {"userId": "", "name": "Dr. Sajida Parveen"},
  {"userId": "KvlPt9RlYcMtrNYhspWKufb63f32", "name": "Dr. Inam Illahi"},
  {"userId": "0ZRr7ZuX1hOmh9r8ulCKLgFO4Il1", "name": "Mr. Muhammad Shahid"},
  {"userId": "5QfE9xxaEXU3NUeMBv0y3zgk6S72", "name": "Mr. Nasir Mahmood"},
  {"userId": "A5Yb79Mx1oYCD4yv6iBVpERJMP33", "name": "Mr. Shahbaz Ahmad Sahi"},
  {"userId": "VK7qNqiWeucWOTWPyCSfCawWcF02", "name": "Mr. Muhammad Naeem"},
  {"userId": "GpVmXTKEpYSJg6zX8li91E3dTod2", "name": "Mr. Arsal Mahmood"},
  {"userId": "", "name": "Mr. Muhammad Nouman"},
  {"userId": "", "name": "Miss Sana Ikram"},
  {"userId": "UokwmyYyaxN0ZdSCn4UmXRhX4VA3", "name": "Miss Sara Naeem"},
  {"userId": "", "name": "Miss Kainat Rizwan"},
  {"userId": "", "name": "Miss Humael Hassan"},
  {"userId": "", "name": "Miss Saira Ishtiaq"},
];

class UserData {
  final String userId;
  final String name;

  UserData({required this.userId, required this.name});

  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      userId: data['userId'],
      name: data['name'],
    );
  }
}

class FinalEvaluationForm extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  FinalEvaluationForm({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  State<FinalEvaluationForm> createState() => _FinalEvaluationFormState();
}

class _FinalEvaluationFormState extends State<FinalEvaluationForm> {
  late Future<UserData> _userData;

  final beforeEvaluationColor = Color(0xffbbbbbb); // light gray
  final afterEvaluationColor = Color(0xff4caf50);

  @override
  void initState() {
    super.initState();
    _userData = getUserData();
    _getDocumentId();
  }

  //----------- Attendance Strings ----------- //
  String _attendance_mem1 = '';
  String _attendance_mem2 = '';
  String _attendance_mem3 = '';

//----------- Documentation  Sliders (Group)----------- //

  double _overall_attendance_mem1 = 0.0;
  double _overall_attendance_mem2 = 0.0;
  double _overall_attendance_mem3 = 0.0;

  double _group_proposal = 0.0;
  double _group_taskcompletion = 0.0;

  double _group_presentation = 0.0;
  double _group_intro = 0.0;
  double _group_SRS = 0.0;
  double _group_design = 0.0;
  double _group_testing = 0.0;
  double _group_GUI = 0.0;
  double _group_objectives = 0.0;
  double _group_video = 0.0;
  double _group_security = 0.0;

//----------- Documentation  Sliders (Individual)----------- //
  double _individual_code_understanding_mem1 = 0.0;
  double _individual_code_understanding_mem2 = 0.0;
  double _individual_code_understanding_mem3 = 0.0;

  double _task_completion_mem1 = 0.0;
  double _task_completion_mem2 = 0.0;
  double _task_completion_mem3 = 0.0;

//------------------- Individual Presentations  ------------- //
  double _individual_presentation_mem1 = 0.0;
  double _individual_presentation_mem2 = 0.0;
  double _individual_presentation_mem3 = 0.0;

  // ------------------ General Evaluation --------------- //
  String _overall_status = '';
  String _code_genuineness = '';

// ---------------------- Feedback  -------------------------- //
  TextEditingController _documentationController = TextEditingController();
  TextEditingController _interfaceController = TextEditingController();
  TextEditingController _presentationController = TextEditingController();
  TextEditingController _videoController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _groupattendancesliderInteracted = false;
  bool _groupproposalsliderInteracted = false;
  bool _grouptaskcompletionsliderInteracted = false;

  bool _grouppresentationsliderInteracted = false;
  bool _introsliderInteracted = false;
  bool _SRSsliderInteracted = false;
  bool _designsliderInteracted = false;
  bool _testingsliderInteracted = false;
  bool _GUIsliderInteracted = false;
  bool _objectivesliderInteracted = false;
  bool _videosliderInteracted = false;
  bool _securitysliderInteracted = false;
  bool _presentationsliderInteracted = false;
  bool _understandingsliderInteracted = false;
  bool _attendancesliderInteracted = false;

  var _errorMessage;
  var _groupproposalerrorMessage;
  var _groupattendanceerrorMessage;
  var _grouptaskcompletionerrorMessage;

  var _grouppresentationerrorMessage;
  var _SRSerrorMessage;
  var _designerrorMessage;
  var _testingerrorMessage;
  var _introerrorMessage;
  var _GUIerrorMessage;
  var _objectiveerrorMessage;
  var _presentationerrorMessage;
  var _understandingerrorMessage;
  var _attendanceerrorMessage;
  var _videoerrorMessage;
  var _securityerrorMessage;
  var _overall_status_errorMessage;
  var code_genuineness_errorMessage;

  // var _introerrorMessage;
  //  var _introerrorMessage;

  String? percentage;
  String? overall_status;
  String? code_genuineness;

  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  String documentId = '';

  Future<void> _getDocumentId() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            "/Convenor/classes/BS Information Technology/groups/group-members")
        .where("fyp-id", isEqualTo: widget.documentSnapshot['fyp-id'])
        .get();

    if (querySnapshot.docChanges.isNotEmpty) {
      setState(() {
        DocumentSnapshot document = querySnapshot.docs.first;
        documentId = document.id;
      });
    } else {
      print("No documents found with the specified criteria");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFieldEmpty2 = widget.documentSnapshot['regno2'] == null ||
        widget.documentSnapshot['regno2'] == '';

    bool isFieldEmpty3 = widget.documentSnapshot['regno3'] == null ||
        widget.documentSnapshot['regno3'] == '';
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 15, bottom: 25),
                width: 650,
                child: Center(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 218, 220, 224),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image(
                                  image: NetworkImage(
                                      'https://lh6.googleusercontent.com/bqa7oGMGmj5cSRPStRi88tO2LSCazjQJ7JJ2jRjDbqRwdGgyK6qKVK-FaOkNYMl4EyupeTg2zici9_oToM-d63aruvWtGwO4gvRw48EHFoGUssvmLEMRtk2tf2WZiWFAfw=w1210'),
                                ),
                              ),
                            ),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 218, 220, 224),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      child: Container(
                                        height: 10,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 20),
                                      child: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'FYP Assessment ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 32,
                                                    fontWeight:
                                                        FontWeight.w100)),
                                            TextSpan(
                                              text: '(Final Evaluation)',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 20),
                                      child: Text(
                                          'Please submit the evaluation using the rubric:',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Divider(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15, left: 20, bottom: 20),
                                      child: Text(
                                        'Required *',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                )),

                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  // Project id
                                  Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 25, bottom: 35),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Project ID *',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 330,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    initialValue:
                                                        widget.documentSnapshot[
                                                            'fyp-id'],
                                                    decoration:
                                                        InputDecoration(),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'This is a required question';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),

                                  // Title
                                  Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 25, bottom: 35),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Title *',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 400,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    maxLines: 2,
                                                    initialValue:
                                                        widget.documentSnapshot[
                                                            'accepted-idea'],
                                                    decoration:
                                                        InputDecoration(),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'This is a required question';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),

                                  // Main Supervisor
                                  Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 25, bottom: 35),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Main Supervisor *',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 330,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    initialValue:
                                                        widget.documentSnapshot[
                                                            'main-supervisor'],
                                                    decoration:
                                                        InputDecoration(),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'This is a required question';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),

                                  // Co Supervisor

                                  Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 25, bottom: 35),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Co Supervisor *',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 330,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    initialValue:
                                                        widget.documentSnapshot[
                                                            'co-supervisor'],
                                                    decoration:
                                                        InputDecoration(),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'This is a required question';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),

                                  // Student 1

                                  Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 25, bottom: 35),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Student 1 Name / Registration *',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 330,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    initialValue:
                                                        widget.documentSnapshot[
                                                            'mem1'],
                                                    decoration:
                                                        InputDecoration(),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'This is a required question';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),

                                  // Student 2

                                  Visibility(
                                    visible: !isFieldEmpty3,
                                    child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 12),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 218, 220, 224),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25, left: 25, bottom: 35),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Student 2 Name / Registration *',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                  )),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 330,
                                                    child: TextFormField(
                                                      enabled: false,
                                                      initialValue: widget
                                                              .documentSnapshot[
                                                          'mem2'],
                                                      decoration:
                                                          InputDecoration(),
                                                      // autovalidateMode:
                                                      //     AutovalidateMode
                                                      //         .onUserInteraction,
                                                      // validator: (value) {
                                                      //   if (value!.isEmpty) {
                                                      //     return 'This is a required question';
                                                      //   }
                                                      //   return null;
                                                      // },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),

                                  // Student 3

                                  Visibility(
                                    visible: !isFieldEmpty3,
                                    child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 12),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 218, 220, 224),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25, left: 25, bottom: 35),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Student 3 Name / Registration *',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                  )),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 330,
                                                    child: TextFormField(
                                                      enabled: false,
                                                      initialValue: widget
                                                              .documentSnapshot[
                                                          'mem3'],
                                                      decoration:
                                                          InputDecoration(),
                                                      // autovalidateMode:
                                                      //     AutovalidateMode
                                                      //         .onUserInteraction,
                                                      // validator: (value) {
                                                      //   if (value!.isEmpty) {
                                                      //     return 'This is a required question';
                                                      //   }
                                                      //   return null;
                                                      // },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),

// ----------------------------------------------- Attendance ----------------------------------------- //

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Presence on Evaluation Day?',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              '*If all student are absent it means this group never presented',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 35,
                                                left: 0,
                                                bottom: 35,
                                                right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 50, 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 80,
                                                      ),
                                                      Text('Present',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('Absent',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('NA',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                    ],
                                                  ),
                                                ),
// Student 1----Attendance
                                                FormField(
                                                  builder:
                                                      (FormFieldState<String>
                                                          state) {
                                                    return Container(
                                                      width: double.infinity,
                                                      color: Color.fromARGB(
                                                          255, 248, 249, 250),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 10, 50, 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                widget.documentSnapshot[
                                                                    'regno1'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                )),
                                                            Radio(
                                                              value: 'Present',
                                                              groupValue:
                                                                  _attendance_mem1,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _attendance_mem1 =
                                                                      value!;
                                                                  _attendancesliderInteracted =
                                                                      true;
                                                                  _attendanceerrorMessage =
                                                                      null;
                                                                });
                                                              },
                                                            ),
                                                            Radio(
                                                              value: 'Absent',
                                                              groupValue:
                                                                  _attendance_mem1,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _attendance_mem1 =
                                                                      value!;
                                                                  _attendancesliderInteracted =
                                                                      true;
                                                                  _attendanceerrorMessage =
                                                                      null;
                                                                });
                                                              },
                                                            ),
                                                            Radio(
                                                              value: 'NA',
                                                              groupValue:
                                                                  _attendance_mem1,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _attendance_mem1 =
                                                                      value!;
                                                                  _attendancesliderInteracted =
                                                                      true;
                                                                  _attendanceerrorMessage =
                                                                      null;
                                                                });
                                                                state.didChange(
                                                                    value);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                // Student 2----Attendance

                                                Visibility(
                                                  visible: !isFieldEmpty2,
                                                  child: FormField(
                                                    builder:
                                                        (FormFieldState<String>
                                                            state) {
                                                      return Container(
                                                        width: double.infinity,
                                                        color: Color.fromARGB(
                                                            255, 248, 249, 250),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10,
                                                                  10,
                                                                  50,
                                                                  10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  widget.documentSnapshot[
                                                                      'regno2'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                  )),
                                                              Radio(
                                                                value:
                                                                    'Present',
                                                                groupValue:
                                                                    _attendance_mem2,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _attendance_mem2 =
                                                                        value!;
                                                                    _attendancesliderInteracted =
                                                                        true;
                                                                    _attendanceerrorMessage =
                                                                        null;
                                                                  });
                                                                },
                                                              ),
                                                              Radio(
                                                                value: 'Absent',
                                                                groupValue:
                                                                    _attendance_mem2,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _attendance_mem2 =
                                                                        value!;
                                                                    _attendancesliderInteracted =
                                                                        true;
                                                                    _attendanceerrorMessage =
                                                                        null;
                                                                  });
                                                                },
                                                              ),
                                                              Radio(
                                                                value: 'NA',
                                                                groupValue:
                                                                    _attendance_mem2,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _attendance_mem2 =
                                                                        value!;
                                                                    _attendancesliderInteracted =
                                                                        true;
                                                                    _attendanceerrorMessage =
                                                                        null;
                                                                  });
                                                                  state.didChange(
                                                                      value);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
// Student 3----Attendance
                                                Visibility(
                                                  visible: !isFieldEmpty3,
                                                  child: FormField(
                                                    builder:
                                                        (FormFieldState<String>
                                                            state) {
                                                      return Container(
                                                        width: double.infinity,
                                                        color: Color.fromARGB(
                                                            255, 248, 249, 250),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10,
                                                                  10,
                                                                  50,
                                                                  10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  widget.documentSnapshot[
                                                                      'regno3'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                  )),
                                                              Radio(
                                                                value:
                                                                    'Present',
                                                                groupValue:
                                                                    _attendance_mem3,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _attendance_mem3 =
                                                                        value!;
                                                                    _attendancesliderInteracted =
                                                                        true;
                                                                    _attendanceerrorMessage =
                                                                        null;
                                                                  });
                                                                },
                                                              ),
                                                              Radio(
                                                                value: 'Absent',
                                                                groupValue:
                                                                    _attendance_mem3,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _attendance_mem3 =
                                                                        value!;
                                                                    _attendancesliderInteracted =
                                                                        true;
                                                                    _attendanceerrorMessage =
                                                                        null;
                                                                  });
                                                                },
                                                              ),
                                                              Radio(
                                                                value: 'NA',
                                                                groupValue:
                                                                    _attendance_mem3,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _attendance_mem3 =
                                                                        value!;
                                                                  });
                                                                  state.didChange(
                                                                      value);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _attendanceerrorMessage !=
                                                      null
                                                  ? Text(
                                                      _attendanceerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color.fromARGB(
                                                              255,
                                                              231,
                                                              51,
                                                              38)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

                                  // ----------------------------------- Semester Evaluation  -------------------------- //

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Evaluation Results',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              'In this portion, mark the group/student using the provided rubric.',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                        ],
                                      )),

//----------------------------------- Overall Attendance -------------------------- // Slider 1,

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Overall Attendance in 8th Semester (10 Points)',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              '-Weekly attendance of each student throughout the semester',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 35,
                                                left: 0,
                                                bottom: 35,
                                                right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 50, 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 32,
                                                      ),
                                                      Container(),
                                                      Text('0',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('2',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('4',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('6',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('8',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('10',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  color: Color.fromARGB(
                                                      255, 248, 249, 250),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 7, 30, 7),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            widget.documentSnapshot[
                                                                'regno1'],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            )),
                                                        SizedBox(
                                                          width: 30,
                                                        ),
                                                        Flexible(
                                                          child: Slider(
                                                            value:
                                                                _overall_attendance_mem1, //current value
                                                            onChanged: (double
                                                                newValue) {
                                                              setState(() {
                                                                _overall_attendance_mem1 =
                                                                    newValue;
                                                                _groupattendancesliderInteracted =
                                                                    true;
                                                                _groupattendanceerrorMessage =
                                                                    null;
                                                              });
                                                            },
                                                            min: 0,
                                                            max: 10,
                                                            divisions: 10,
                                                            label:
                                                                '$_overall_attendance_mem1',
                                                          ),
                                                        ),
                                                        Text(
                                                            '$_overall_attendance_mem1')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Visibility(
                                                  visible: !isFieldEmpty2,
                                                  child: Container(
                                                    width: double.infinity,
                                                    color: Color.fromARGB(
                                                        255, 248, 249, 250),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 7, 30, 7),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              widget.documentSnapshot[
                                                                  'regno2'],
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              )),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          // ------------------ Student 2 -------------------------
                                                          Flexible(
                                                            child: Slider(
                                                              value:
                                                                  _overall_attendance_mem2, //current value
                                                              onChanged: (double
                                                                  newValue) {
                                                                setState(() {
                                                                  _overall_attendance_mem2 =
                                                                      newValue;
                                                                  _groupattendancesliderInteracted =
                                                                      true;
                                                                  _groupattendanceerrorMessage =
                                                                      null;
                                                                });
                                                              },
                                                              min: 0,
                                                              max: 10,
                                                              divisions: 10,
                                                              label:
                                                                  '$_overall_attendance_mem2',
                                                            ),
                                                          ),
                                                          Text(
                                                              '$_overall_attendance_mem2')
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                // ------------------ Student 3 -------------------------
                                                Visibility(
                                                  visible: !isFieldEmpty3,
                                                  child: Container(
                                                    width: double.infinity,
                                                    color: Color.fromARGB(
                                                        255, 248, 249, 250),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 7, 30, 7),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              widget.documentSnapshot[
                                                                  'regno3'],
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              )),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          Flexible(
                                                            child: Slider(
                                                              value:
                                                                  _overall_attendance_mem3, //current value
                                                              onChanged: (double
                                                                  newValue) {
                                                                setState(() {
                                                                  _overall_attendance_mem3 =
                                                                      newValue;
                                                                  _groupattendancesliderInteracted =
                                                                      true;
                                                                  _groupattendanceerrorMessage =
                                                                      null;
                                                                });
                                                              },
                                                              min: 0,
                                                              max: 10,
                                                              divisions: 10,
                                                              label:
                                                                  '$_overall_attendance_mem3',
                                                            ),
                                                          ),
                                                          Text(
                                                              '$_overall_attendance_mem3')
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _attendanceerrorMessage !=
                                                      null
                                                  ? Text(
                                                      _attendanceerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

//  //----------------------------------- Documentation (Introduction) -------------------------- // Slider 1,

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Introduction and Literature Review:  (5 Points) *',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              '- Problem Statement \n-Related Projects /Literature Review \n- Methodology \n-Objectives \n-Project Scope \netc',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 50, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 32,
                                                ),
                                                Text('0'),
                                                Text('1'),
                                                Text('2'),
                                                Text('3'),
                                                Text('4'),
                                                Text('5'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            color: Color.fromARGB(
                                                255, 248, 249, 250),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 30, 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text('Group',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      )),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Flexible(
                                                    child: Slider(
                                                      value:
                                                          _group_intro, //current value
                                                      onChanged:
                                                          (double newValue) {
                                                        setState(() {
                                                          _group_intro =
                                                              newValue;
                                                          _introsliderInteracted =
                                                              true;
                                                          _introerrorMessage =
                                                              null;
                                                        });
                                                      },
                                                      min: 0,
                                                      max: 5,
                                                      divisions: 5,
                                                      label: '$_group_intro',
                                                    ),
                                                  ),
                                                  Text('$_group_intro')
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _introerrorMessage != null
                                                  ? Text(_introerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color.fromARGB(
                                                              255,
                                                              231,
                                                              51,
                                                              38)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

//  //----------------------------------- Documentation (SRS) -------------------------- // Slider 2,

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Software Requirement Specification:  (15 Points) *',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              '- Functional and Non-Functional Requirements \n- Use Case Description and Diagram \n- Activity Diagram\n-DFD (if required in project) \netc',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 50, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(''),
                                                Text('0'),
                                                Text('5'),
                                                Text('10'),
                                                Text('15'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            color: Color.fromARGB(
                                                255, 248, 249, 250),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 30, 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text('Group',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      )),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Flexible(
                                                    child: Slider(
                                                      value:
                                                          _group_SRS, //current value
                                                      onChanged:
                                                          (double newValue) {
                                                        setState(() {
                                                          _group_SRS = newValue;
                                                          _SRSsliderInteracted =
                                                              true;
                                                          _SRSerrorMessage =
                                                              null;
                                                        });
                                                      },
                                                      min: 0,
                                                      max: 15,
                                                      divisions: 15,
                                                      label: '$_group_SRS',
                                                    ),
                                                  ),
                                                  Text('$_group_SRS')
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _SRSerrorMessage != null
                                                  ? Text(_SRSerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

//  //----------------------------------- Documentation (Design) -------------------------- // Slider 3,

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Software Design Specification:  (10 Points) *',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              '- Class Diagram  \n- Sequence Diagram \n- Database Design (ERD/Tree)\n- Deployment Diagram \n etc',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 50, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 32,
                                                ),
                                                Text('0'),
                                                Text('2'),
                                                Text('4'),
                                                Text('6'),
                                                Text('8'),
                                                Text('10'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            color: Color.fromARGB(
                                                255, 248, 249, 250),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 30, 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Group',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      )),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Flexible(
                                                    child: Slider(
                                                      value:
                                                          _group_design, //current value
                                                      onChanged:
                                                          (double newValue) {
                                                        setState(() {
                                                          _group_design =
                                                              newValue;
                                                          _designsliderInteracted =
                                                              true;
                                                          _designerrorMessage =
                                                              null;
                                                        });
                                                      },
                                                      min: 0,
                                                      max: 10,
                                                      divisions: 10,
                                                      label: '$_group_design',
                                                    ),
                                                  ),
                                                  Text('$_group_design')
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _designerrorMessage != null
                                                  ? Text(_designerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

                                  //---------------------------------- Application and Code (Understanding)  -------------------------- // Slider 5,

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Application and Code (Understanding)  (20 Points)',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              '-Understanding of Code\n- How genuinely code is written by the students\n- Technology Understanding',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 35,
                                                left: 0,
                                                bottom: 35,
                                                right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 50, 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 32,
                                                      ),
                                                      Container(),
                                                      Text('0',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('5',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('10',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('15',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      Text('20',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                  width: double.infinity,
                                                  color: Color.fromARGB(
                                                      255, 248, 249, 250),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 7, 30, 7),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            widget.documentSnapshot[
                                                                'regno1'],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            )),
                                                        SizedBox(
                                                          width: 30,
                                                        ),
                                                        Flexible(
                                                          child: Slider(
                                                            value:
                                                                _individual_code_understanding_mem1, //current value
                                                            onChanged: (double
                                                                newValue) {
                                                              setState(() {
                                                                _individual_code_understanding_mem1 =
                                                                    newValue;
                                                                _understandingsliderInteracted =
                                                                    true;
                                                                _understandingerrorMessage =
                                                                    null;
                                                              });
                                                            },
                                                            min: 0,
                                                            max: 20,
                                                            divisions: 20,
                                                            label:
                                                                '$_individual_code_understanding_mem1',
                                                          ),
                                                        ),
                                                        Text(
                                                            '$_individual_code_understanding_mem1')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Visibility(
                                                  visible: !isFieldEmpty2,
                                                  child: Container(
                                                    width: double.infinity,
                                                    color: Color.fromARGB(
                                                        255, 248, 249, 250),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 7, 30, 7),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              widget.documentSnapshot[
                                                                  'regno2'],
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              )),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          // ------------------ Student 2 -------------------------
                                                          Flexible(
                                                            child: Slider(
                                                              value:
                                                                  _individual_code_understanding_mem2, //current value
                                                              onChanged: (double
                                                                  newValue) {
                                                                setState(() {
                                                                  _individual_code_understanding_mem2 =
                                                                      newValue;
                                                                  _understandingsliderInteracted =
                                                                      true;
                                                                  _understandingerrorMessage =
                                                                      null;
                                                                });
                                                              },
                                                              min: 0,
                                                              max: 20,
                                                              divisions: 20,
                                                              label:
                                                                  '$_individual_code_understanding_mem2',
                                                            ),
                                                          ),
                                                          Text(
                                                              '$_individual_code_understanding_mem2')
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                // ------------------ Student 3 -------------------------
                                                Visibility(
                                                  visible: !isFieldEmpty3,
                                                  child: Container(
                                                    width: double.infinity,
                                                    color: Color.fromARGB(
                                                        255, 248, 249, 250),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 7, 30, 7),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              widget.documentSnapshot[
                                                                  'regno3'],
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              )),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          Flexible(
                                                            child: Slider(
                                                              value:
                                                                  _individual_code_understanding_mem3, //current value
                                                              onChanged: (double
                                                                  newValue) {
                                                                setState(() {
                                                                  _individual_code_understanding_mem3 =
                                                                      newValue;
                                                                  _understandingsliderInteracted =
                                                                      true;
                                                                  _understandingerrorMessage =
                                                                      null;
                                                                });
                                                              },
                                                              min: 0,
                                                              max: 20,
                                                              divisions: 20,
                                                              label:
                                                                  '$_individual_code_understanding_mem3',
                                                            ),
                                                          ),
                                                          Text(
                                                              '$_individual_code_understanding_mem3')
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _understandingerrorMessage !=
                                                      null
                                                  ? Text(
                                                      _understandingerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

//  //----------------------------------- Documentation (30% Objective achievement) -------------------------- // Slider ,

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Application and Code (GUI)   (5 Points) *',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('- User Friendly',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 50, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 32,
                                                ),
                                                Text('0'),
                                                Text('1'),
                                                Text('2'),
                                                Text('3'),
                                                Text('4'),
                                                Text('5'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            color: Color.fromARGB(
                                                255, 248, 249, 250),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 30, 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text('Group',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      )),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Flexible(
                                                    child: Slider(
                                                      value:
                                                          _group_GUI, //current value
                                                      onChanged:
                                                          (double newValue) {
                                                        setState(() {
                                                          _group_GUI = newValue;
                                                          _GUIerrorMessage =
                                                              null;
                                                          _GUIsliderInteracted =
                                                              true;
                                                        });
                                                      },
                                                      min: 0,
                                                      max: 5,
                                                      divisions: 5,
                                                      label: '$_group_GUI',
                                                    ),
                                                  ),
                                                  Text('$_group_GUI')
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _GUIerrorMessage != null
                                                  ? Text(_GUIerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Application Security   (5 Points) *',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              '- Authorization \n - External Attacks (SQL Injection, DOS etc. ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 50, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 32,
                                                ),
                                                Text('0'),
                                                Text('1'),
                                                Text('2'),
                                                Text('3'),
                                                Text('4'),
                                                Text('5'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            color: Color.fromARGB(
                                                255, 248, 249, 250),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 30, 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text('Group',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      )),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Flexible(
                                                    child: Slider(
                                                      value:
                                                          _group_security, //current value
                                                      onChanged:
                                                          (double newValue) {
                                                        setState(() {
                                                          _group_security =
                                                              newValue;
                                                          _securityerrorMessage =
                                                              null;
                                                          _securitysliderInteracted =
                                                              true;
                                                        });
                                                      },
                                                      min: 0,
                                                      max: 5,
                                                      divisions: 5,
                                                      label: '$_group_security',
                                                    ),
                                                  ),
                                                  Text('$_group_security')
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _securityerrorMessage !=
                                                      null
                                                  ? Text(_securityerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

//  //----------------------------------- Documentation (30% Objective achievement) -------------------------- // Slider ,

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Application and Code (Objective Achievement)  (10 Points) *',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              '- Meeting the Objectives Defined in Proposal',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 50, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 32,
                                                ),
                                                Text('0'),
                                                Text('2'),
                                                Text('4'),
                                                Text('6'),
                                                Text('8'),
                                                Text('10'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            color: Color.fromARGB(
                                                255, 248, 249, 250),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 30, 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text('Group',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      )),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Flexible(
                                                    child: Slider(
                                                      value:
                                                          _group_objectives, //current value
                                                      onChanged:
                                                          (double newValue) {
                                                        setState(() {
                                                          _group_objectives =
                                                              newValue;
                                                          _objectiveerrorMessage =
                                                              null;
                                                          _objectivesliderInteracted =
                                                              true;
                                                        });
                                                      },
                                                      min: 0,
                                                      max: 10,
                                                      divisions: 10,
                                                      label:
                                                          '$_group_objectives',
                                                    ),
                                                  ),
                                                  Text('$_group_objectives')
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _objectiveerrorMessage !=
                                                      null
                                                  ? Text(_objectiveerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

//  //----------------------------------- Short Video) -------------------------- // Slider 1,

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Short Video (5 Points) *',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('- Video + One page Broucher',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              )),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 50, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 32,
                                                ),
                                                Text('0'),
                                                Text('1'),
                                                Text('2'),
                                                Text('3'),
                                                Text('4'),
                                                Text('5'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            color: Color.fromARGB(
                                                255, 248, 249, 250),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 30, 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text('Group',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      )),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Flexible(
                                                    child: Slider(
                                                      value:
                                                          _group_video, //current value
                                                      onChanged:
                                                          (double newValue) {
                                                        setState(() {
                                                          _group_video =
                                                              newValue;
                                                          _videosliderInteracted =
                                                              true;
                                                          _videoerrorMessage =
                                                              null;
                                                        });
                                                      },
                                                      min: 0,
                                                      max: 5,
                                                      divisions: 5,
                                                      label: '$_group_video',
                                                    ),
                                                  ),
                                                  Text('$_group_video')
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _videoerrorMessage != null
                                                  ? Text(_videoerrorMessage,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color.fromARGB(
                                                              255,
                                                              231,
                                                              51,
                                                              38)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

                                  //----------------------------------- Presentation -------------------------- // Slider 2,

                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                      top: 25,
                                      left: 25,
                                      bottom: 30,
                                    ),
                                    margin: EdgeInsets.only(top: 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color.fromARGB(
                                              255, 218, 220, 224),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Presentation:  (15 Points) *',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            '- Presentations and ability to explain \n - ppt slides ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            )),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 50, 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Container(),
                                              Text('0'),
                                              Text('5'),
                                              Text('10'),
                                              Text('15'),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          color: Color.fromARGB(
                                              255, 248, 249, 250),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 7, 30, 7),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    widget.documentSnapshot[
                                                        'regno1'],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    )),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Flexible(
                                                  child: Slider(
                                                    value:
                                                        _individual_presentation_mem1, //current value
                                                    onChanged:
                                                        (double newValue) {
                                                      setState(() {
                                                        _individual_presentation_mem1 =
                                                            newValue;
                                                        _grouppresentationsliderInteracted =
                                                            true;
                                                        _grouppresentationerrorMessage =
                                                            null;
                                                      });
                                                    },
                                                    min: 0,
                                                    max: 15,
                                                    divisions: 15,
                                                    label:
                                                        '$_individual_presentation_mem1',
                                                  ),
                                                ),
                                                Text(
                                                    '$_individual_presentation_mem1')
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Visibility(
                                          visible: !isFieldEmpty2,
                                          child: Container(
                                            width: double.infinity,
                                            color: Color.fromARGB(
                                                255, 248, 249, 250),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 30, 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      widget.documentSnapshot[
                                                          'regno2'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      )),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  // ------------------ Student 2 -------------------------
                                                  Flexible(
                                                    child: Slider(
                                                      value:
                                                          _individual_presentation_mem2, //current value
                                                      onChanged:
                                                          (double newValue) {
                                                        setState(() {
                                                          _individual_presentation_mem2 =
                                                              newValue;
                                                          _grouppresentationsliderInteracted =
                                                              true;
                                                          _grouppresentationerrorMessage =
                                                              null;
                                                        });
                                                      },
                                                      min: 0,
                                                      max: 15,
                                                      divisions: 15,
                                                      label:
                                                          '$_individual_presentation_mem2',
                                                    ),
                                                  ),
                                                  Text(
                                                      '$_individual_presentation_mem2')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // ------------------ Student 3 -------------------------
                                        Visibility(
                                          visible: !isFieldEmpty3,
                                          child: Container(
                                            width: double.infinity,
                                            color: Color.fromARGB(
                                                255, 248, 249, 250),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 30, 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      widget.documentSnapshot[
                                                          'regno3'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      )),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Flexible(
                                                    child: Slider(
                                                      value:
                                                          _individual_presentation_mem3, //current value
                                                      onChanged:
                                                          (double newValue) {
                                                        setState(() {
                                                          _individual_presentation_mem3 =
                                                              newValue;
                                                          _grouppresentationsliderInteracted =
                                                              true;
                                                          _grouppresentationerrorMessage =
                                                              null;
                                                        });
                                                      },
                                                      min: 0,
                                                      max: 15,
                                                      divisions: 15,
                                                      label:
                                                          '$_individual_presentation_mem3',
                                                    ),
                                                  ),
                                                  Text(
                                                      '$_individual_presentation_mem3')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: _grouppresentationerrorMessage !=
                                                    null
                                                ? Text(
                                                    _grouppresentationerrorMessage,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color.fromARGB(
                                                            255, 212, 33, 20)))
                                                : Container(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Documentation Similarity:',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          RadioListTile(
                                            title: Text("Less than 30%"),
                                            value: "Less than 30%",
                                            groupValue: percentage,
                                            onChanged: (value) {
                                              setState(() {
                                                percentage = value.toString();
                                              });
                                            },
                                          ),
                                          RadioListTile(
                                            title: Text("Between 30-70%"),
                                            value: "Between 30-70%",
                                            groupValue: percentage,
                                            onChanged: (value) {
                                              setState(() {
                                                percentage = value.toString();
                                              });
                                            },
                                          ),
                                          RadioListTile(
                                            title: Text("More than 70%"),
                                            value: "More than 70%",
                                            groupValue: percentage,
                                            onChanged: (value) {
                                              setState(() {
                                                percentage = value.toString();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: code_genuineness_errorMessage !=
                                                      null
                                                  ? Text(
                                                      code_genuineness_errorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Application\Code Genuineness:',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          RadioListTile(
                                            title: Text(
                                                "I am sure this Code is written by this group (except some helps)"),
                                            value:
                                                "I am sure this Code is written by this group (except some helps)",
                                            groupValue: code_genuineness,
                                            onChanged: (value) {
                                              setState(() {
                                                code_genuineness =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          RadioListTile(
                                            title: Text(
                                                "Not Written by this group"),
                                            value: "Not Written by this group",
                                            groupValue: code_genuineness,
                                            onChanged: (value) {
                                              setState(() {
                                                code_genuineness =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          RadioListTile(
                                            title: Text("Not sure"),
                                            value: "Not sure",
                                            groupValue: code_genuineness,
                                            onChanged: (value) {
                                              setState(() {
                                                code_genuineness =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: code_genuineness_errorMessage !=
                                                      null
                                                  ? Text(
                                                      code_genuineness_errorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

// ------------------------------------------------------ Overall Status ----------------------------/////
                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Overall Status of the Project',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                          RadioListTile(
                                            title: Text(
                                                "Presentable for Internal Evaluation (Minor Revisions)"),
                                            value: "Presentable",
                                            groupValue: _overall_status,
                                            onChanged: (value) {
                                              setState(() {
                                                _overall_status =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          RadioListTile(
                                            title: Text(
                                                "Not Presentable for Internal Evaluation (Major Revisions)"),
                                            value: "Not Presentable",
                                            groupValue: _overall_status,
                                            onChanged: (value) {
                                              setState(() {
                                                _overall_status =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: _overall_status_errorMessage !=
                                                      null
                                                  ? Text(
                                                      _overall_status_errorMessage,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              255,
                                                              212,
                                                              33,
                                                              20)))
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      )),

//- --------------------------------- General Evaluation   ----------------------------------------- //

// ----------------------------------- Improvement in documentation -----------------------
                                  Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 25, bottom: 35),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Comments for improvemnet*',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                )),
                                            Text(
                                                '* Please write point wise i.e. 1,2,3...Mention. OK if nothing to improve',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 500,
                                              child: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                controller:
                                                    _documentationController,
                                                decoration: InputDecoration(
                                                    labelText: 'Your answer'),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'This is a required question';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),

// ----------------------------
// ----
                                  // ------------------------------------- Information of Supervisors --------------------------- //

                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        bottom: 30,
                                      ),
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Information of Supervisors',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                        ],
                                      )),

                                  // Main Supervisor
                                  Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 25, bottom: 35),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Main Supervisor Name *',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 330,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    initialValue:
                                                        widget.documentSnapshot[
                                                            'main-supervisor'],
                                                    decoration:
                                                        InputDecoration(),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'This is a required question';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),

                                  // Co Supervisor

                                  Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 218, 220, 224),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 25, bottom: 35),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Co-Supervisor Name*',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 330,
                                                  child: TextFormField(
                                                    enabled: false,
                                                    initialValue:
                                                        widget.documentSnapshot[
                                                            'co-supervisor'],
                                                    decoration:
                                                        InputDecoration(),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'This is a required question';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),

                                  //////////////////////////
                                ],
                              ),
                            ),

// Submission Button
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        padding:
                                            EdgeInsets.fromLTRB(23, 17, 23, 17),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: () {
                                        print(_overall_status);
                                        print(percentage);
                                        if (!_groupattendancesliderInteracted &&
                                            !_groupproposalsliderInteracted &&
                                            !_grouptaskcompletionsliderInteracted &&
                                            !_grouppresentationsliderInteracted &&
                                            !_introsliderInteracted &&
                                            !_SRSsliderInteracted &&
                                            !_designsliderInteracted &&
                                            !_attendancesliderInteracted &&
                                            !_objectivesliderInteracted &&
                                            !_understandingsliderInteracted &&
                                            !_securitysliderInteracted &&
                                            _overall_status == '' &&
                                            _code_genuineness == '') {
                                          setState(() {
                                            _groupattendanceerrorMessage =
                                                'This is a required field';

                                            _groupproposalerrorMessage =
                                                'This is a required field';

                                            _grouptaskcompletionerrorMessage =
                                                'This is a required field';
                                            _grouppresentationerrorMessage =
                                                'This is a required field';
                                            _SRSerrorMessage =
                                                'This is a required field';
                                            _introerrorMessage =
                                                'This is a required field';
                                            _designerrorMessage =
                                                'This is a required field';
                                            _testingerrorMessage =
                                                'This is a required field';
                                            _attendanceerrorMessage =
                                                'This is a required field';
                                            _GUIerrorMessage =
                                                'This is a required field';
                                            _objectiveerrorMessage =
                                                'This is a required field';
                                            _presentationerrorMessage =
                                                'This is a required field';
                                            _videoerrorMessage =
                                                'This is a required field';
                                            _understandingerrorMessage =
                                                'This is a required field';
                                            code_genuineness_errorMessage =
                                                'This is a required field';
                                            _overall_status_errorMessage =
                                                'This is a required field';
                                            _testingerrorMessage =
                                                'This is a required field';
                                          });
                                        }
                                        if (formKey.currentState!.validate()) {
//                                           var convenorResults = FirebaseFirestore
//                                               .instance
//                                               .collection(
//                                                   "/Convenor/classes/BS Information Technology/groups/group-members/")
//                                               .doc(documentId)
//                                               .collection(
//                                                   'Internal-evaluation');

//                                           convenorResults.add({
// // ----------------------------- Group Details -------------------------- //
//                                             "fyp-id": widget
//                                                 .documentSnapshot["fyp-id"],
//                                             "mem1":
//                                                 widget.documentSnapshot['mem1'],
//                                             "mem2":
//                                                 widget.documentSnapshot['mem2'],
//                                             "mem3":
//                                                 widget.documentSnapshot['mem3'],
//                                             "regno1": widget
//                                                 .documentSnapshot['regno1'],
//                                             "regno2": widget
//                                                 .documentSnapshot['regno2'],
//                                             "regno3": widget
//                                                 .documentSnapshot['regno3'],

//                                             "main-supervisor":
//                                                 widget.documentSnapshot[
//                                                     'main-supervisor'],
//                                             "co-supervisor":
//                                                 widget.documentSnapshot[
//                                                     'co-supervisor'],
//                                             "accepted-idea":
//                                                 widget.documentSnapshot[
//                                                     'accepted-idea'],

//                                             "evaluator1": widget
//                                                 .documentSnapshot['evaluator1'],
//                                             "evaluator2": widget
//                                                 .documentSnapshot['evaluator2'],

//                                             // ----------------------------- Attendance -------------------------- //
//                                             "attendance-mem1": _attendance_mem1,
//                                             "attendance-mem2": _attendance_mem2,
//                                             "attendance-mem3": _attendance_mem3,

//                                             // ----------------------------- Documentation Sliders (Group) -------------------------- //
//                                             "group-intro": _group_intro,
//                                             "group-SRS": _group_SRS,
//                                             "group-design": _group_design,
//                                             "group-testing": _group_testing,
//                                             "group-GUI": _group_GUI,
//                                             "group-objectives":
//                                                 _group_objectives,
//                                             "group-video": _group_video,

//                                             // ----------------------------- Documentation Sliders (Individual) -------------------------- //
//                                             "individual-code-understanding-mem1":
//                                                 _individual_code_understanding_mem1,
//                                             "individual-code-understanding-mem2":
//                                                 _individual_code_understanding_mem2,
//                                             "individual-code-understanding-mem3":
//                                                 _individual_code_understanding_mem3,

//                                             "individual-presentation-mem1":
//                                                 _individual_presentation_mem1,
//                                             "individual-presentation-mem2":
//                                                 _individual_presentation_mem2,
//                                             "individual-presentation-mem3":
//                                                 _individual_presentation_mem3,

//                                             // ----------------------- Others --------------------------------//
//                                             "overall-status": _overall_status,
//                                             "code-genuineness":
//                                                 _code_genuineness,
//                                             "documentaion-improvement":
//                                                 _documentationController.text,
//                                             "interface-improvement":
//                                                 _interfaceController.text,
//                                             "presentation-improvement":
//                                                 _presentationController.text,
//                                             "video-improvement":
//                                                 _videoController.text,
//                                           });

                                          // -----------------------------------Evaluator  1 Collection ------------------
                                          var supervisor_results =
                                              FirebaseFirestore.instance
                                                  .collection('supervisor')
                                                  .doc('supervisor')
                                                  .collection(
                                                      widget.documentSnapshot[
                                                          'main-supervisor'])
                                                  .doc('groups')
                                                  .collection(
                                                      'main-supervision')
                                                  .doc(widget
                                                      .documentSnapshot.id)
                                                  .collection(
                                                      'Final-evaluation');

                                          supervisor_results.add({
// ----------------------------- Group Details -------------------------- //
                                            "fyp-id": widget
                                                .documentSnapshot["fyp-id"],
                                            "mem1":
                                                widget.documentSnapshot['mem1'],
                                            "mem2":
                                                widget.documentSnapshot['mem2'],
                                            "mem3":
                                                widget.documentSnapshot['mem3'],
                                            "regno1": widget
                                                .documentSnapshot['regno1'],
                                            "regno2": widget
                                                .documentSnapshot['regno2'],
                                            "regno3": widget
                                                .documentSnapshot['regno3'],

                                            "main-supervisor":
                                                widget.documentSnapshot[
                                                    'main-supervisor'],
                                            "co-supervisor":
                                                widget.documentSnapshot[
                                                    'co-supervisor'],
                                            "accepted-idea":
                                                widget.documentSnapshot[
                                                    'accepted-idea'],

                                            // ----------------------------- Attendance -------------------------- //
                                            "attendance-mem1": _attendance_mem1,
                                            "attendance-mem2": _attendance_mem2,
                                            "attendance-mem3": _attendance_mem3,

                                            // ----------------------------- Documentation Sliders (Group) -------------------------- //

                                            "overall-attendance-mem1":
                                                _overall_attendance_mem1,

                                            "overall-attendance-mem2":
                                                _overall_attendance_mem2,

                                            "overall-attendance-mem3":
                                                _overall_attendance_mem3,

                                            "group-intro": _group_intro,
                                            "group-SRS": _group_SRS,
                                            "group-design": _group_design,
                                            "group-GUI": _group_GUI,
                                            "group-testing": _group_testing,
                                            "group-video": _group_video,
                                            "group-security": _group_security,

                                            "group-objectives":
                                                _group_objectives,

                                            // ----------------------------- Documentation Sliders (Individual) -------------------------- //
                                            "individual-code-understanding-mem1":
                                                _individual_code_understanding_mem1,
                                            "individual-code-understanding-mem2":
                                                _individual_code_understanding_mem2,
                                            "individual-code-understanding-mem3":
                                                _individual_code_understanding_mem3,

                                            "individual-presentation-mem1":
                                                _individual_presentation_mem1,
                                            "individual-presentation-mem2":
                                                _individual_presentation_mem2,
                                            "individual-presentation-mem3":
                                                _individual_presentation_mem3,

                                            // ----------------------- Others --------------------------------//

                                            "percentage": percentage,
                                            "code-genuineness":
                                                code_genuineness,
                                            "overall-supervisory-status":
                                                _overall_status,

                                            "documentaion-improvement":
                                                _documentationController.text,
                                            "interface-improvement":
                                                _interfaceController.text,
                                            "presentation-improvement":
                                                _presentationController.text,
                                            "video-improvement":
                                                _videoController.text,
                                          });

                                          // -----------------------------------Co Supervisor Collection ------------------

                                          var cosupervisor_results =
                                              FirebaseFirestore
                                                  .instance
                                                  .collection('supervisor')
                                                  .doc('supervisor')
                                                  .collection(
                                                      widget
                                                              .documentSnapshot[
                                                          'co-supervisor'])
                                                  .doc('groups')
                                                  .collection('co-supervision')
                                                  .doc(widget
                                                      .documentSnapshot.id)
                                                  .collection(
                                                      'Final-evaluationCo');

                                          cosupervisor_results.add({
// ----------------------------- Group Details -------------------------- //
                                            "fyp-id": widget
                                                .documentSnapshot["fyp-id"],
                                            "mem1":
                                                widget.documentSnapshot['mem1'],
                                            "mem2":
                                                widget.documentSnapshot['mem2'],
                                            "mem3":
                                                widget.documentSnapshot['mem3'],
                                            "regno1": widget
                                                .documentSnapshot['regno1'],
                                            "regno2": widget
                                                .documentSnapshot['regno2'],
                                            "regno3": widget
                                                .documentSnapshot['regno3'],

                                            "main-supervisor":
                                                widget.documentSnapshot[
                                                    'main-supervisor'],
                                            "co-supervisor":
                                                widget.documentSnapshot[
                                                    'co-supervisor'],
                                            "accepted-idea":
                                                widget.documentSnapshot[
                                                    'accepted-idea'],

                                            // ----------------------------- Attendance -------------------------- //
                                            "attendance-mem1": _attendance_mem1,
                                            "attendance-mem2": _attendance_mem2,
                                            "attendance-mem3": _attendance_mem3,

                                            // ----------------------------- Documentation Sliders (Group) -------------------------- //

                                            "overall-attendance-mem1":
                                                _overall_attendance_mem1,

                                            "overall-attendance-mem2":
                                                _overall_attendance_mem2,

                                            "overall-attendance-mem3":
                                                _overall_attendance_mem3,

                                            "group-intro": _group_intro,
                                            "group-SRS": _group_SRS,
                                            "group-design": _group_design,

                                            "group-testing": _group_testing,
                                            "group-GUI": _group_GUI,
                                            "group-video": _group_video,
                                            "group-security": _group_security,

                                            "group-objectives":
                                                _group_objectives,
                                            "group-presentation":
                                                _group_presentation,

                                            // ----------------------------- Documentation Sliders (Individual) -------------------------- //
                                            "individual-code-understanding-mem1":
                                                _individual_code_understanding_mem1,
                                            "individual-code-understanding-mem2":
                                                _individual_code_understanding_mem2,
                                            "individual-code-understanding-mem3":
                                                _individual_code_understanding_mem3,

                                            "individual-presentation-mem1":
                                                _individual_presentation_mem1,
                                            "individual-presentation-mem2":
                                                _individual_presentation_mem2,
                                            "individual-presentation-mem3":
                                                _individual_presentation_mem3,

                                            // ----------------------- Others --------------------------------//

                                            "percentage": percentage,
                                            "code-genuineness":
                                                code_genuineness,
                                            "overall-supervisory-status":
                                                _overall_status,
                                            "code-genuineness_null":
                                                _code_genuineness,
                                            "documentaion-improvement":
                                                _documentationController.text,
                                            "interface-improvement":
                                                _interfaceController.text,
                                            "presentation-improvement":
                                                _presentationController.text,
                                            "video-improvement":
                                                _videoController.text,
                                          });

                                          var results = _group_SRS +
                                              _group_design +
                                              _group_objectives +
                                              _group_testing;

                                          var results_mem1 = _group_proposal +
                                              _group_intro +
                                              _group_SRS +
                                              _group_design +
                                              _group_objectives +
                                              _overall_attendance_mem1 +
                                              _individual_code_understanding_mem1 +
                                              _individual_presentation_mem1 +
                                              _task_completion_mem1;

                                          var results_mem2 = _group_proposal +
                                              _group_intro +
                                              _group_SRS +
                                              _group_design +
                                              _group_objectives +
                                              _overall_attendance_mem2 +
                                              _individual_code_understanding_mem2 +
                                              _individual_presentation_mem2 +
                                              _task_completion_mem2;

                                          var results_mem3 = _group_proposal +
                                              _group_intro +
                                              _group_SRS +
                                              _group_design +
                                              _group_objectives +
                                              _overall_attendance_mem3 +
                                              _individual_code_understanding_mem3 +
                                              _individual_presentation_mem3 +
                                              _task_completion_mem3;

                                          double supervisory_percentage_mem1 =
                                              (60 / 100) * results_mem1;
                                          double supervisory_percentage_mem2 =
                                              (60 / 100) * results_mem2;
                                          double supervisory_percentage_mem3 =
                                              (60 / 100) * results_mem3;

                                          print('$results');
                                          print('$results_mem1');
                                          print('$results_mem2');
                                          print('$results_mem3');

                                          // var supervisory_results_mem1 =
                                          //     FirebaseFirestore.instance
                                          //         .collection(
                                          //             "/Convenor/classes/BS Information Technology/groups/7th-Semester-Results")
                                          //         .doc(widget.documentSnapshot[
                                          //             'regno1'])
                                          //         .update({
                                          //   "supervisory-evaluation":
                                          //       supervisory_percentage_mem1
                                          //           .toStringAsFixed(0),
                                          // });

                                          // var supervisory_results_mem2 =
                                          //     FirebaseFirestore.instance
                                          //         .collection(
                                          //             "/Convenor/classes/BS Information Technology/groups/7th-Semester-Results")
                                          //         .doc(widget.documentSnapshot[
                                          //             'regno2'])
                                          //         .update({
                                          //   "supervisory-evaluation":
                                          //       supervisory_percentage_mem2
                                          //           .toStringAsFixed(0),
                                          // });

                                          // var supervisory_results_mem3 =
                                          //     FirebaseFirestore.instance
                                          //         .collection(
                                          //             "/Convenor/classes/BS Information Technology/groups/7th-Semester-Results")
                                          //         .doc(widget.documentSnapshot[
                                          //             'regno3'])
                                          //         .update({
                                          //   "supervisory-evaluation":
                                          //       supervisory_percentage_mem3
                                          //           .toStringAsFixed(0),
                                          // });

//
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    Text("Internal Evaluation"),
                                                content: Text(
                                                    "Evaluation Successful"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.pop(context);
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             MidEvaluationResults(
                                                      //                 snap: widget
                                                      //                     .documentSnapshot)));
                                                      print(_attendance_mem1);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } // Perform validation
                                      },
                                      child: Text('Submit')),
                                  TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Clear form?'),
                                              content: Text(
                                                  'This will remove your answers from all questions and cannot be undone'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Clear'),
                                                  onPressed: () {
                                                    // logic to remove answers

                                                    setState(() {
                                                      formKey.currentState!
                                                          .reset();
                                                      _group_taskcompletion =
                                                          0.0;

                                                      _group_presentation = 0.0;
                                                      _group_intro = 0.0;
                                                      _group_SRS = 0.0;
                                                      _group_design = 0.0;
                                                      _group_testing = 0.0;
                                                      _group_GUI = 0.0;
                                                      _group_objectives = 0.0;
                                                      _group_video = 0.0;

//----------- Documentation  Sliders (Individual)----------- //
                                                      _individual_code_understanding_mem1 =
                                                          0.0;
                                                      _individual_code_understanding_mem2 =
                                                          0.0;
                                                      _individual_code_understanding_mem3 =
                                                          0.0;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text('Clear form'))
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class EvaluationForm extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  EvaluationForm({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<EvaluationForm> createState() => _EvaluationFormState();
}

class _EvaluationFormState extends State<EvaluationForm> {
  @override
  Widget build(BuildContext context) {
    // final data = documentSnapshot.data();
    return Scaffold(
      appBar: AppBar(title: Text("Data Form")),
      body: Form(
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 218, 220, 224),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 25, bottom: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Project ID *',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 330,
                            child: TextFormField(
                              initialValue: widget.documentSnapshot['fyp-id'],
                              decoration:
                                  InputDecoration(labelText: 'Your answer'),
                              // autovalidateMode:
                              //     AutovalidateMode.onUserInteraction,
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'This is a required question';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Text("Document ID: ${widget.documentSnapshot.id}"),
          ],
        ),
      ),
    );
  }
}

Future<UserData> getUserData() async {
  var user = await FirebaseAuth.instance.currentUser;
  // var userId = 'S5OGYR4RkqZ6xzKqLlrVBeXIXgG2';
  var userId = user!.uid;

  for (var i = 0; i < users.length; i++) {
    if (users[i]['userId'] == userId) {
      var userData = UserData.fromMap(users[i]);

      return userData;
    }
  }

  throw Exception('No UserData found for current user');
}
