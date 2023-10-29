// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/student_screens/mygroup.dart';
import 'package:flutter_application_1/student_screens/student_dashboard.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MemberForm extends StatefulWidget {
  @override
  _MemberFormState createState() => _MemberFormState();
}

List<Map> availableclass = [
  {'class': 'BS Information Technology', "isChecked": false},
  {'class': 'BS Computer Science', "isChecked": false},
  {
    'class': 'BS Software Engineering',
    "isChecked": false,
  },
];

TextEditingController _name1Controller = TextEditingController();
TextEditingController _name2Controller = TextEditingController();
TextEditingController _name3Controller = TextEditingController();

TextEditingController _reg1Controller = TextEditingController();
TextEditingController _reg2Controller = TextEditingController();
TextEditingController _reg3Controller = TextEditingController();
TextEditingController _fieldController = TextEditingController();

@override
void dispose() {
  _name1Controller.dispose();
  _name2Controller.dispose();
  _name3Controller.dispose();
  _reg2Controller.dispose();
  _reg3Controller.dispose();
  _fieldController.dispose();
}

var dept;
var project;

int CS_id = 100;
int IT_id = 300;
int SE_id = 200;

class _MemberFormState extends State<MemberForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 232, 242, 244),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 120),
            child: Column(children: <Widget>[
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 57, 120, 125),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'FYP (19-23) Group Information',
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'This form collects the FYP group information. Only one member per group shall fill the form.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Required *",
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Group Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 57, 120, 125),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          ' Select your Class*',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              for (int i = 0; i < availableclass.length; i++)
                                RadioListTile(
                                  value: i,
                                  groupValue: _groupValue,
                                  title: Text(availableclass[i]["class"]),
                                  onChanged: (newValue) => setState(() {
                                    _groupValue = newValue!;
                                    dept = availableclass[i]["class"];
                                  }),
                                  activeColor:
                                      const Color.fromARGB(255, 57, 120, 125),
                                  selected: false,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                            'Enter the details of the group members (minimum 1, maximum 3)'),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('1. First member name *'),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            RegExp regExp = RegExp(r'[A-Za-z ]+$');

                            var textNotNull = text ?? "";

                            if (textNotNull.isEmpty) {
                              return 'Name is required';
                            } else if (!regExp.hasMatch(textNotNull)) {
                              return 'Please Enter Correct Name';
                            }
                            return null;
                          },
                          controller: _name1Controller,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.9),
                            ),
                            hintText: 'Enter your answer',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('2. First member registration *'),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            var textNotNull = text ?? "";

                            if (textNotNull.isEmpty) {
                              return 'Registration No is required';
                            }
                          },
                          inputFormatters: [
                            MaskTextInputFormatter(
                              mask: "##-YYY-YY-####",
                              filter: {
                                "#": RegExp(r'[0-9]'),
                                "Y": RegExp(r'[A-Z]')
                              },
                            )
                          ],
                          controller: _reg1Controller,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.9),
                            ),
                            hintText: 'XX-NTU-CS-XXXX',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('3. Second member name *'),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            RegExp regExp = RegExp(r'[[A-Za-z ]+$');

                            var textNotNull = text ?? "";

                            if (textNotNull.isEmpty) {
                              return null;
                            } else if (!regExp.hasMatch(textNotNull)) {
                              return 'Please Enter Correct Name';
                            }
                            return null;
                          },
                          controller: _name2Controller,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.9),
                            ),
                            hintText: 'Enter your answer',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('4.Second member registration number *'),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            RegExp regExp = RegExp(r'[A-Za-z0-9]+$');

                            var textNotNull = text ?? "";

                            if (textNotNull.isEmpty) {
                              return null;
                            } else if (!regExp.hasMatch(textNotNull)) {
                              return 'Please Enter Correct Reg No';
                            }
                            return null;
                          },
                          inputFormatters: [
                            MaskTextInputFormatter(
                              mask: "##-YYY-YY-####",
                              filter: {
                                "#": RegExp(r'[0-9]'),
                                "Y": RegExp(r'[A-Z]')
                              },
                            )
                          ],
                          controller: _reg2Controller,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.9),
                            ),
                            hintText: 'XX-NTU-CS-XXXX',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('5.Third member name (if any) *'),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            RegExp regExp = RegExp(r'[[A-Za-z ]+$');

                            var textNotNull = text ?? "";

                            if (textNotNull.isEmpty) {
                              return null;
                            } else if (!regExp.hasMatch(textNotNull)) {
                              return 'Please Enter Correct Name';
                            }
                            return null;
                          },
                          controller: _name3Controller,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.9),
                            ),
                            hintText: 'Enter your answer',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                            '6.Third member registration number (if any)*'),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            RegExp regExp = RegExp(r'[A-Z0-9]+$');

                            var textNotNull = text ?? "";

                            if (textNotNull.isEmpty) {
                              return null;
                            } else if (!regExp.hasMatch(textNotNull)) {
                              return 'Please Enter Correct Reg No';
                            }
                            return null;
                          },
                          inputFormatters: [
                            MaskTextInputFormatter(
                              mask: "##-YYY-YY-####",
                              filter: {
                                "#": RegExp(r'[0-9]'),
                                "Y": RegExp(r'[A-Z]')
                              },
                            )
                          ],
                          controller: _reg3Controller,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.9),
                            ),
                            hintText: 'XX-NTU-CS-XXXX',
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          child: const Text('Next'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MemberForm2(),
                                  ),
                                );
                              });
                            }
                            ;
                          },
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 57, 120, 125),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 20),
                              textStyle: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

class MemberForm2 extends StatefulWidget {
  const MemberForm2({Key? key}) : super(key: key);

  @override
  _MemberForm2State createState() => _MemberForm2State();
}

int get fyp_id => groupids(dept);

String? assignedGroupId;

groupids(String Department) {
  int fyp_id = 99;
  if (Department == 'Information Technology') {
    return fyp_id = 300;
  } else if (Department == 'BS Software Engineering') {
    return fyp_id = 200;
  } else if (Department == 'BS Computer Science') {
    return fyp_id = 100;
  } else {
    return null;
  }
}

class _MemberForm2State extends State<MemberForm2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  List<Map> availablefields = [
    {'Field': 'Research and development', "isChecked": false},
    {'Field': 'Mobile/Web/Desktop App', "isChecked": false},
    {
      'Field': 'Hardware related',
      "isChecked": false,
    },
    {'Field': 'Networks related', "isChecked": false},
  ];

  String? getgroupid = '';

  @override
  void initState() {
    super.initState();
    getMaxGroupIdAndStore();
  }

  void getMaxGroupIdAndStore() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collectionGroup('members')
        .orderBy('group-id', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic>? data =
          snapshot.docs.first.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('group-id')) {
        String maxGroupId = data['group-id'] as String;
        String numericPart = maxGroupId.split('-')[2];
        int incrementedNumericPart = int.parse(numericPart) + 1;
        String incrementedGroupId = maxGroupId.replaceFirst(
            numericPart, incrementedNumericPart.toString());

        // Create a new variable and assign the value of group-id to it
        String assignedGroupId = maxGroupId;

        getgroupid = incrementedGroupId;

        await FirebaseFirestore.instance
            .collection('your_destination_collection')
            .doc('your_document_id')
            .set({'group-id': incrementedGroupId});

        print('Maximum group-id: $maxGroupId');
        print('Incremented group-id stored successfully: $incrementedGroupId');
        print('Assigned group-id: $assignedGroupId');
      } else {
        print('The "group-id" field is missing in the document.');
      }
    } else {
      print('No documents found in the collection group.');
    }
  }

  // String get path => ConvenorPath(firebaseUser!.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 232, 242, 244),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 150),
            child: Column(children: <Widget>[
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 57, 120, 125),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(45, 15, 0, 10),
                  child: Text(
                    'FYP (19-23) Group Information',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(45, 15, 0, 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Required *",
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Project details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 57, 120, 125),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Select the category/area of the project'),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          '7. Preferred area of project (may choose multiple) *',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              children: availablefields.map((field) {
                            return Row(
                              children: [
                                Checkbox(
                                    value: field["isChecked"],
                                    onChanged: (newValue) {
                                      setState(() {
                                        field["isChecked"] = newValue;

                                        project = field["Field"];
                                        print(project);
                                        //  project = newValue.toString();
                                      });

                                      // project = field["isChecked"];
                                    }),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  field["Field"],
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            );
                          }).toList()),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              child: const Text('Back',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 57, 120, 125),
                                  )),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 224, 221, 221),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 20),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 57, 120, 125),
                                  )),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                              child: const Text('Submit'),
                              onPressed: () {
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            title: const Text(
                                              "Group Registration",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  insertinSubCollection();
                                                  print(getgroupid);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.pop(ctx);
                                                  Navigator.pop(ctx);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Mygroup(),
                                                      ));
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                            content: const Text("Successful",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 20, 107, 23))),
                                          ));
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 57, 120, 125),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 20),
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  Future<void> insertinSubCollection() async {
    var groupid;
    groupids(dept);

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collectionGroup('members')
        .orderBy('group-id', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic>? data =
          snapshot.docs.first.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('group-id')) {
        String maxGroupId = data['group-id'] as String;
        String numericPart = maxGroupId.split('-')[2];
        int incrementedNumericPart = int.parse(numericPart) + 1;
        String incrementedGroupId = maxGroupId.replaceFirst(
            numericPart, incrementedNumericPart.toString());

        groupid = incrementedGroupId;
      }
    }

    var firebaseUser = FirebaseAuth.instance.currentUser;

    var convenor = FirebaseFirestore.instance.collection(
        '/Convenor/classes/BS Information Technology/groups/group-members');

    convenor.add({});

    var db = FirebaseFirestore.instance
        .collection("FYP")
        .doc("fyp(19-23)")
        .collection('groups')
        .doc(firebaseUser!.uid)
        .collection("members");

    db.add({
      // "fyp-id": '23-FYP-${fyp_id + 1}',
      'group-id': getgroupid,
      'accepted-idea': '',
      'fyp-id': getgroupid,
      "mem1": _name1Controller.text,
      "regno1": _reg1Controller.text,
      "mem2": _name2Controller.text,
      "regno2": _reg2Controller.text,
      "mem3": _name3Controller.text,
      "regno3": _reg3Controller.text,
      "class": dept,
      "field": project,
      "co-supervisor": '',
      "main-supervisor": '',
      'internal1': '',
      'internal2': '',
    });
    CS_id++;
    // fyp_id++;

    var deptdb = FirebaseFirestore.instance
        .collection("Convenor")
        .doc('classes')
        .collection(dept)
        .doc('groups')
        .collection('group-members');
    deptdb.add({
      // "fyp-id": '23-FYP-$fyp_id',
      'group-id': getgroupid,
      'accepted-idea': '',
      'fyp-id': getgroupid,
      "mem1": _name1Controller.text,
      "regno1": _reg1Controller.text,
      "mem2": _name2Controller.text,
      "regno2": _reg2Controller.text,
      "mem3": _name3Controller.text,
      "regno3": _reg3Controller.text,
      "class": dept,
      "field": project,
      "co-supervisor": '',
      "main-supervisor": '',
      'internal1': '',
      'internal2': '',
    });
    CS_id++;
  }
}
