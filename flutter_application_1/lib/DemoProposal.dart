// ignore_for_file: sort_child_properties_last, unused_element, unnecessary_null_comparison, non_constant_identifier_names, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/myproposal.dart';
import 'package:flutter_application_1/new.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:uuid/uuid.dart';
import 'package:oktoast/oktoast.dart';

class DemoProposal extends StatefulWidget {
  const DemoProposal({super.key});

  @override
  _DemoProposalState createState() => _DemoProposalState();
}

TextEditingController _groupidController = TextEditingController();

TextEditingController _titleController1 = TextEditingController();
TextEditingController _type1Controller1 = TextEditingController();

TextEditingController _industrialpartnerController1 = TextEditingController();
TextEditingController _problemstatementController1 = TextEditingController();
TextEditingController _objectiesController1 = TextEditingController();
TextEditingController _probbackgroundController1 = TextEditingController();
TextEditingController _proposedsolutionController1 = TextEditingController();
TextEditingController _relatedtechnologiesController1 = TextEditingController();

TextEditingController _proposedtoolsController1 = TextEditingController();
TextEditingController _proposedmethodogiesController1 = TextEditingController();
TextEditingController _projectrationaleController1 = TextEditingController();
TextEditingController _scheduleController1 = TextEditingController();

String proposed_methodology_url = '';
String ganttchart_url = '';

var projecttype;
var category;

class _DemoProposalState extends State<DemoProposal> {
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  bool checkedValue5 = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _groupValue = -1;

  List listitem = [
    'Industrial',
    'Textile related',
    'Research and Development',
    'Freelancing Project',
    'Own Idea'
  ];

  List<Map> projectcategory = [
    {'Field': 'Web Based', "isChecked": false},
    {'Field': 'Mobile App', "isChecked": false},
    {
      'Field': 'Computer Application',
      "isChecked": false,
    },
    {'Field': 'Research and Development', "isChecked": false},
    {'Field': 'Others', "isChecked": false},
  ];

  List<Widget> itemPhotosWidgetList = <Widget>[];

  List<Widget> itemPhotosWidgetList_gantt = <Widget>[];

  late final String title;

  final ImagePicker _picker = ImagePicker();

  late io.File file;
  List<XFile>? photo = <XFile>[];
  List<XFile>? photo_gantt = <XFile>[];

  List<XFile> itemImagesList = <XFile>[];
  List<XFile> itemImagesList_gantt = <XFile>[];

  List<String> downloadUrl = <String>[];
  List<String> downloadGanttUrl = <String>[];

  bool uploading = false;

  pickPhotoFromGallery() async {
    photo = await _picker.pickMultiImage();
    if (photo != null) {
      setState(() {
        itemImagesList = itemImagesList + photo!;
        addImage();
        photo!.clear();
      });
    }
  }

  addImage() {
    for (var bytes in photo!) {
      itemPhotosWidgetList.add(Padding(
        padding: const EdgeInsets.all(1.0),
        child: SizedBox(
          height: 90.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.image_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Image Attached'),
                    ],
                  ),

                  // kIsWeb
                  //     ? Image.network(io.File(bytes.path).path)
                  //     : Image.file(
                  //         io.File(bytes.path),
                  //       ),
                ],
              ),
            ),
          ),
        ),
      ));
    }
  }

  pickPhotoFromGallery_Gantt() async {
    photo_gantt = await _picker.pickMultiImage();
    if (photo_gantt != null) {
      setState(() {
        itemImagesList = itemImagesList_gantt + photo_gantt!;
        addImage_Gantt();
        photo!.clear();
      });
    }
  }

  addImage_Gantt() {
    for (var bytes in photo_gantt!) {
      itemPhotosWidgetList_gantt.add(Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 90.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.image_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Image Attached'),
                    ],
                  ),

                  // kIsWeb
                  //     ? Image.network(io.File(bytes.path).path)
                  //     : Image.file(
                  //         io.File(bytes.path),
                  //       ),
                ],
              ),
            ),
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext dx) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 232, 242, 244),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 250),
                  child: Column(children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 57, 120, 125),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 45,
                                ),
                                Text(
                                  'BSIT FYP Proposal Submission',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "* Required ",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Group Details",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color:
                                            Color.fromARGB(255, 57, 120, 125),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const Text(
                                      '1.Group Id *',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            // maxLength: 5,
                                            maxLines: 1,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller: _groupidController,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                      "Main Topic Details",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color:
                                            Color.fromARGB(255, 57, 120, 125),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    const Text(
                                      '2. Project Title *',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Enter 8-15 words project title.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            // maxLength: 5,
                                            maxLines: 1,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller: _titleController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('3. Project Type *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 45,
                                        width: 340,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              focusColor: Colors.grey[200],
                                              hint: const Text(
                                                "Enter your Answer",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              value: projecttype,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  projecttype = newValue;
                                                });
                                              },
                                              // autovalidateMode:
                                              //     AutovalidateMode.always,
                                              // validator: (value) {
                                              //   RegExp regExp =
                                              //       RegExp(r'[A-Za-z _.-]*$');

                                              //   var textNotNull = value ?? "";

                                              //   if (textNotNull == null) {
                                              //     return 'Answer is required';
                                              //   }
                                              //   return null;
                                              // },
                                              items: listitem.map((valueItem) {
                                                return DropdownMenuItem(
                                                  value: valueItem,
                                                  child: Text(valueItem),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('4. Project Category *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                        children: projectcategory.map((field) {
                                      return Row(
                                        children: [
                                          Checkbox(
                                              value: field["isChecked"],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  field["isChecked"] = newValue;

                                                  category = field["Field"];
                                                  print(category);
                                                });
                                              }),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            field["Field"],
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      );
                                    }).toList()),

                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '5. Describe the industrial partner *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'In case of industrial partner, please provide the details (name, address, and contact details) of industrial partner.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 80,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _industrialpartnerController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),

                                    const Text('6. Problem statement *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Clear state the problem statement in 1-4 lines.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            controller:
                                                _problemstatementController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('7. Objectives *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Clearly state 1-3 measurable objectives. Each object must start with "To".',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller: _objectiesController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '8. Introduction and background of the problem *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Concisely (5-10 lines) highlight the significance, background, and related work of the highlighted problem.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _probbackgroundController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '9. Proposed solution / Methodology *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Briefly describe the proposed solution to problem. You may use the diagram to depict the proposed solution.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _proposedsolutionController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '10. Proposed tools and technologies *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Write down possible tools, languages, databases, etc. that will be used in project.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _proposedtoolsController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '11. Related Technologies / Literature Review *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Discuss at least two existing technologies which are related to your project. If your project is R&D then provide literature survey.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _relatedtechnologiesController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('12. Project rationale *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Provide the rationale of your idea in comparison to the existing.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _projectrationaleController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('13. Proposed Methodology *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Describe your proposed software engineering methodology in case of computing application. If your project is R&D then provide research methodology.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _proposedmethodogiesController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    // const Text(
                                    //     '14. Document Upload, Related to proposed methodology. (if any) ',
                                    //     style: TextStyle(fontSize: 18)),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // const Padding(
                                    //   padding: EdgeInsets.only(left: 22.0),
                                    //   child: Text(
                                    //     'File number limit: 1 Single file size limit: 10MB Allowed file types: Images',
                                    //     style: TextStyle(
                                    //         color: Colors.grey, fontSize: 16),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.only(left: 22.0),
                                    //   child: Container(
                                    //     height: 50,
                                    //     width: 200,
                                    //     child: Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(left: 10.0),
                                    //       child: Container(
                                    //         decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(12.0),
                                    //         ),
                                    //         width: 400,
                                    //         height: 20.0,
                                    //         child: Center(
                                    //           child: itemPhotosWidgetList
                                    //                   .isEmpty
                                    //               ? Center(
                                    //                   child: MaterialButton(
                                    //                     onPressed:
                                    //                         pickPhotoFromGallery,
                                    //                     child: Container(
                                    //                       child: Center(
                                    //                         child: Row(
                                    //                           crossAxisAlignment:
                                    //                               CrossAxisAlignment
                                    //                                   .center,
                                    //                           mainAxisAlignment:
                                    //                               MainAxisAlignment
                                    //                                   .start,
                                    //                           children: const [
                                    //                             Icon(
                                    //                               Icons
                                    //                                   .file_upload_outlined,
                                    //                               size: 27,
                                    //                             ),
                                    //                             SizedBox(
                                    //                               width: 10,
                                    //                             ),
                                    //                             Text(
                                    //                                 'Upload File'),
                                    //                           ],
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 )
                                    //               : SingleChildScrollView(
                                    //                   scrollDirection:
                                    //                       Axis.vertical,
                                    //                   child: Wrap(
                                    //                     spacing: 5.0,
                                    //                     direction:
                                    //                         Axis.horizontal,
                                    //                     children:
                                    //                         itemPhotosWidgetList,
                                    //                     alignment: WrapAlignment
                                    //                         .spaceEvenly,
                                    //                     runSpacing: 10.0,
                                    //                   ),
                                    //                 ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    const Text(
                                        '15. Schedule of activities and gantt chart *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Provide activity name and tentative date.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller: _scheduleController1,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // const Text(
                                    //     '14. Document Upload, Related to Gantt Chart. (if any) ',
                                    //     style: TextStyle(fontSize: 18)),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // const Padding(
                                    //   padding: EdgeInsets.only(left: 22.0),
                                    //   child: Text(
                                    //     'File number limit: 1 Single file size limit: 10MB Allowed file types: Images',
                                    //     style: TextStyle(
                                    //         color: Colors.grey, fontSize: 16),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.only(left: 22.0),
                                    //   child: Container(
                                    //     height: 50,
                                    //     width: 200,
                                    //     child: Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(left: 10.0),
                                    //       child: Container(
                                    //         decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(12.0),
                                    //         ),
                                    //         width: 400,
                                    //         height: 20.0,
                                    //         child: Center(
                                    //           child: itemPhotosWidgetList
                                    //                   .isEmpty
                                    //               ? Center(
                                    //                   child: MaterialButton(
                                    //                     onPressed:
                                    //                         pickPhotoFromGallery_Gantt,
                                    //                     child: Container(
                                    //                       child: Center(
                                    //                         child: Row(
                                    //                           crossAxisAlignment:
                                    //                               CrossAxisAlignment
                                    //                                   .center,
                                    //                           mainAxisAlignment:
                                    //                               MainAxisAlignment
                                    //                                   .start,
                                    //                           children: const [
                                    //                             Icon(
                                    //                               Icons
                                    //                                   .file_upload_outlined,
                                    //                               size: 27,
                                    //                             ),
                                    //                             SizedBox(
                                    //                               width: 10,
                                    //                             ),
                                    //                             Text(
                                    //                                 'Upload File'),
                                    //                           ],
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 )
                                    //               : SingleChildScrollView(
                                    //                   scrollDirection:
                                    //                       Axis.vertical,
                                    //                   child: Wrap(
                                    //                     spacing: 5.0,
                                    //                     direction:
                                    //                         Axis.horizontal,
                                    //                     children:
                                    //                         itemPhotosWidgetList,
                                    //                     alignment: WrapAlignment
                                    //                         .spaceEvenly,
                                    //                     runSpacing: 10.0,
                                    //                   ),
                                    //                 ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 50,
                                    // ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 170,
                                          child: ElevatedButton(
                                            child: const Text(
                                              'Back',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 53, 95, 53)),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              // if (_formKey.currentState!
                                              //     .validate()) {
                                              //   setState(() {
                                              //     Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             const Proposal2(),
                                              //       ),
                                              //     );
                                              //   });
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 214, 205, 205),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 60,
                                                        vertical: 20),
                                                textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 64, 109, 66),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        SizedBox(
                                            height: 40,
                                            width: 170,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // ? null
                                                // : () {
                                                //     upload();
                                                //     // upload_Gantt();
                                                //     // Navigator.push(
                                                //     //   context,
                                                //     //   MaterialPageRoute(
                                                //     //       builder: (context) => const Test()),
                                                //     // );

                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Proposal2(),
                                                        ));
                                                  });
                                                }
                                              },
                                              child: uploading
                                                  ? const SizedBox(
                                                      child:
                                                          CircularProgressIndicator(),
                                                      height: 15.0,
                                                    )
                                                  : const Text(
                                                      "Next",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),

                                              // onPressed: () {

                                              style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(
                                                      255, 57, 120, 125),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 60,
                                                      vertical: 20),
                                                  textStyle: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        )));
  }

  upload() async {
    String productId = await uplaodImageAndSaveItemInfo();
    setState(() {
      uploading = false;
    });
    showToast("Image Uploaded Successfully");
  }

  upload_Gantt() async {
    String productId_Gantt = await uplaodImageAndSaveItemInfo_Gantt();
    setState(() {
      uploading = false;
    });
    showToast("Image Uploaded Successfully");
  }

  Future<String> uplaodImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    PickedFile? pickedFile;
    String? productId = const Uuid().v4();
    for (int i = 0; i < itemImagesList.length; i++) {
      file = io.File(itemImagesList[i].path);
      pickedFile = PickedFile(file.path);

      await uploadImageToStorage(pickedFile, productId);
    }
    return productId;
  }

  Future<String> uplaodImageAndSaveItemInfo_Gantt() async {
    setState(() {
      uploading = true;
    });
    PickedFile? pickedFile_Gantt;
    String? productId_Gantt = const Uuid().v4();
    for (int i = 0; i < itemImagesList.length; i++) {
      file = io.File(itemImagesList[i].path);
      pickedFile_Gantt = PickedFile(file.path);

      await uploadImageToStorage(pickedFile_Gantt, productId_Gantt);
    }
    return productId_Gantt;
  }

  uploadImageToStorage_Gantt(
      PickedFile? pickedFile_Gantt, String productId_Gantt) async {
    String? pId_Gantt = const Uuid().v4();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('Items/$productId_Gantt/product_$pId_Gantt');
    await reference.putData(
      await pickedFile_Gantt!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    String value2 = await reference.getDownloadURL();
    downloadGanttUrl.add(value2);

    proposed_methodology_url = value2;
    ganttchart_url = value2;

    var db = FirebaseFirestore.instance.collection("zeeshan");
  }

  uploadImageToStorage(PickedFile? pickedFile, String productId) async {
    String? pId = const Uuid().v4();
    Reference reference =
        FirebaseStorage.instance.ref().child('Items/$productId/product_$pId');
    await reference.putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    String value = await reference.getDownloadURL();
    downloadUrl.add(value);

    proposed_methodology_url = value;

    var db = FirebaseFirestore.instance.collection("zeeshan");

    db.add({
      "url": value,
    });
  }
}

class Proposal2 extends StatefulWidget {
  const Proposal2({super.key});

  @override
  _Proposal2State createState() => _Proposal2State();
}

TextEditingController _titleController2 = TextEditingController();
TextEditingController _type1Controller2 = TextEditingController();

TextEditingController _industrialpartnerController2 = TextEditingController();
TextEditingController _problemstatementController2 = TextEditingController();
TextEditingController _objectiesController2 = TextEditingController();
TextEditingController _probbackgroundController2 = TextEditingController();
TextEditingController _proposedsolutionController2 = TextEditingController();
TextEditingController _relatedtechnologiesController2 = TextEditingController();

TextEditingController _proposedtoolsController2 = TextEditingController();
TextEditingController _proposedmethodogiesController2 = TextEditingController();
TextEditingController _projectrationaleController2 = TextEditingController();
TextEditingController _scheduleController2 = TextEditingController();

var projecttype2;

class _Proposal2State extends State<Proposal2> {
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  bool checkedValue5 = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _groupValue = -1;
  var category2;

  List listitem = [
    'Industrial',
    'Textile related',
    'Research and Development',
    'Freelancing Project',
    'Own Idea'
  ];

  List<Map> projectcategory = [
    {'Field': 'Web Based', "isChecked": false},
    {'Field': 'Mobile App', "isChecked": false},
    {
      'Field': 'Computer Application',
      "isChecked": false,
    },
    {'Field': 'Research and Development', "isChecked": false},
    {'Field': 'Others', "isChecked": false},
  ];

  @override
  Widget build(BuildContext dx) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 232, 242, 244),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 250),
                  child: Column(children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 57, 120, 125),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 45,
                                ),
                                Text(
                                  'BSIT FYP Proposal Submission',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "* Required ",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "FYP Topic (Option 2)",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color:
                                            Color.fromARGB(255, 57, 120, 125),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const Text(
                                      '15. Project Title *',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Enter 8-15 words project title.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            // maxLength: 5,
                                            maxLines: 1,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller: _titleController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('16. Project Type *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 45,
                                        width: 340,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              focusColor: Colors.grey[200],
                                              hint: const Text(
                                                "Enter your Answer",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              value: projecttype2,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  projecttype2 = newValue;
                                                });
                                              },
                                              // autovalidateMode:
                                              //     AutovalidateMode.always,
                                              // validator: (value) {
                                              //   RegExp regExp =
                                              //       RegExp(r'[A-Za-z _.-]*$');

                                              //   var textNotNull = value ?? "";

                                              //   if (textNotNull == null) {
                                              //     return 'Answer is required';
                                              //   }
                                              //   return null;
                                              // },
                                              items: listitem.map((valueItem) {
                                                return DropdownMenuItem(
                                                  value: valueItem,
                                                  child: Text(valueItem),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('17. Project Category *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                        children: projectcategory.map((field) {
                                      return Row(
                                        children: [
                                          Checkbox(
                                              value: field["isChecked"],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  field["isChecked"] = newValue;

                                                  category2 = field["Field"];
                                                  print(category2);
                                                });
                                              }),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            field["Field"],
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      );
                                    }).toList()),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '18. Describe the industrial partner *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'In case of industrial partner, please provide the details (name, address, and contact details) of industrial partner.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 80,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _industrialpartnerController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('19. Problem statement *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Clear state the problem statement in 1-4 lines.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            controller:
                                                _problemstatementController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('20. Objectives *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Clearly state 1-3 measurable objectives. Each object must start with "To".',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller: _objectiesController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '21. Introduction and background of the problem *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Concisely (5-10 lines) highlight the significance, background, and related work of the highlighted problem.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _probbackgroundController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '22. Proposed solution / Methodology *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Briefly describe the proposed solution to problem. You may use the diagram to depict the proposed solution.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _proposedsolutionController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '23. Proposed tools and technologies *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Write down possible tools, languages, databases, etc. that will be used in project.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _proposedtoolsController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '24. Related Technologies / Literature Review *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Discuss at least two existing technologies which are related to your project. If your project is R&D then provide literature survey.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _relatedtechnologiesController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('25. Project rationale *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Provide the rationale of your idea in comparison to the existing.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _projectrationaleController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text('26. Proposed Methodology *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Describe your proposed software engineering methodology in case of computing application. If your project is R&D then provide research methodology.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller:
                                                _proposedmethodogiesController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    const Text(
                                        '27. Schedule of activities and gantt chart *',
                                        style: TextStyle(fontSize: 18)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Text(
                                        'Provide activity name and tentative date.',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 22.0),
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (text) {
                                              RegExp regExp =
                                                  RegExp(r'[A-Za-z _.-]*$');

                                              var textNotNull = text ?? "";

                                              if (textNotNull.isEmpty) {
                                                return 'Answer is required';
                                              } else if (!regExp
                                                  .hasMatch(textNotNull)) {
                                                return 'Please Enter Correct Answer';
                                              }
                                              return null;
                                            },
                                            controller: _scheduleController2,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your answer',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    method1(),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    // Row(children: [
                                    SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        child: const Text(
                                          'Back',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 53, 95, 53)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const proposal1(),
                                                ),
                                              );
                                            });
                                          }
                                          ;
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 214, 205, 205),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 60, vertical: 20),
                                            textStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 64, 109, 66),
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),

                                    // ]),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        )));
  }

  method1() {
    return SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                    '/Convenor/classes/BS Information Technology/groups/group-members')
                .where('fyp-id', isEqualTo: _groupidController.text)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((document) {
                    return SizedBox(
                      height: 40,
                      width: 170,
                      child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              // StoreProposal();
                              var firebaseUser =
                                  FirebaseAuth.instance.currentUser;
                              var db = FirebaseFirestore.instance
                                  .collection("FYP")
                                  .doc("fyp(19-23)")
                                  .collection('groups')
                                  .doc(firebaseUser!.uid)
                                  .collection("project")
                                  .doc('proposals')
                                  .collection('proposal1');

                              db.add({
                                "group-id": _groupidController.text,
                                "project-title": _titleController1.text,
                                "project-type": projecttype,
                                "project-category": category,
                                "industrial-partner":
                                    _industrialpartnerController1.text,
                                "problem-statement":
                                    _problemstatementController1.text,
                                "objectives": _objectiesController1.text,
                                "problem-background":
                                    _probbackgroundController1.text,
                                "proposed-solution":
                                    _proposedsolutionController1.text,
                                "proposed-tools":
                                    _proposedtoolsController1.text,
                                "related-technologies":
                                    _relatedtechnologiesController1.text,
                                "project-rationale":
                                    _projectrationaleController1.text,
                                "proposed-methodology":
                                    _proposedmethodogiesController1.text,
                                "schedule": _scheduleController1.text,
                                'supervisor-approval': 'pending',
                                'co-supervisor-approval': 'pending',
                                'convenor-approval': 'pending',
                                'proposed-methodology-url':
                                    proposed_methodology_url,
                                'ganttchart-url': ganttchart_url,
                              });

                              var dc = FirebaseFirestore.instance
                                  .collection(
                                      '/Convenor/classes/BS Information Technology/groups/group-members')
                                  .doc(document.id)
                                  .collection('proposals')
                                  .doc('proposals')
                                  .collection('proposal1');

                              dc.add({
                                "group-id": _groupidController.text,
                                "project-title": _titleController1.text,
                                "project-type": projecttype,
                                "project-category": category,
                                "industrial-partner":
                                    _industrialpartnerController1.text,
                                "problem-statement":
                                    _problemstatementController1.text,
                                "objectives": _objectiesController1.text,
                                "problem-background":
                                    _probbackgroundController1.text,
                                "proposed-solution":
                                    _proposedsolutionController1.text,
                                "proposed-tools":
                                    _proposedtoolsController1.text,
                                "related-technologies":
                                    _relatedtechnologiesController1.text,
                                "project-rationale":
                                    _projectrationaleController1.text,
                                "proposed-methodology":
                                    _proposedmethodogiesController1.text,
                                "schedule": _scheduleController1.text,
                                'supervisor-approval': 'pending',
                                'co-supervisor-approval': 'pending',
                                'convenor-approval': 'pending',
                                'proposed-methodology-url':
                                    proposed_methodology_url,
                                'ganttchart-url': ganttchart_url,
                              });

                              var cn = FirebaseFirestore.instance
                                  .collection("FYP")
                                  .doc("fyp(19-23)")
                                  .collection('groups')
                                  .doc(firebaseUser.uid)
                                  .collection("project")
                                  .doc('proposals')
                                  .collection('proposal2');

                              cn.add({
                                "group-id": _groupidController.text,
                                "project-title": _titleController2.text,
                                "project-type": projecttype2,
                                "project-category": category2,
                                "industrial-partner":
                                    _industrialpartnerController2.text,
                                "problem-statement":
                                    _problemstatementController2.text,
                                "objectives": _objectiesController2.text,
                                "problem-background":
                                    _probbackgroundController2.text,
                                "proposed-solution":
                                    _proposedsolutionController2.text,
                                "proposed-tools":
                                    _proposedtoolsController2.text,
                                "related-technologies":
                                    _relatedtechnologiesController2.text,
                                "project-rationale":
                                    _projectrationaleController2.text,
                                "proposed-methodology":
                                    _proposedmethodogiesController2.text,
                                "schedule": _scheduleController2.text,
                                'supervisor-approval': 'pending',
                                'co-supervisor-approval': 'pending',
                                'convenor-approval': 'pending',
                                'proposed-methodology-url': '',
                                'ganttchart-url': '',
                              });

                              var cm = FirebaseFirestore.instance
                                  .collection(
                                      '/Convenor/classes/BS Information Technology/groups/group-members')
                                  .doc(document.id)
                                  .collection('proposals')
                                  .doc('proposals')
                                  .collection('proposal2');

                              cm.add({
                                "group-id": _groupidController.text,
                                "project-title": _titleController2.text,
                                "project-type": projecttype2,
                                "project-category": category2,
                                "industrial-partner":
                                    _industrialpartnerController2.text,
                                "problem-statement":
                                    _problemstatementController2.text,
                                "objectives": _objectiesController2.text,
                                "problem-background":
                                    _probbackgroundController2.text,
                                "proposed-solution":
                                    _proposedsolutionController2.text,
                                "proposed-tools":
                                    _proposedtoolsController2.text,
                                "related-technologies":
                                    _relatedtechnologiesController2.text,
                                "project-rationale":
                                    _projectrationaleController2.text,
                                "proposed-methodology":
                                    _proposedmethodogiesController2.text,
                                "schedule": _scheduleController2.text,
                                'supervisor-approval': 'pending',
                                'co-supervisor-approval': 'pending',
                                'convenor-approval': 'pending',
                                'proposed-methodology-url': '',
                                'ganttchart-url': '',
                                'internal1': '',
                                'internal2': '',
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyProposal(),
                                  ));

                              // Navigator.pop(dx);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 57, 120, 125),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 20),
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    );
                  }).toList());
            }));
  }

  void StoreProposal() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var db = FirebaseFirestore.instance
        .collection("FYP")
        .doc("fyp(19-23)")
        .collection('groups')
        .doc(firebaseUser!.uid)
        .collection("project")
        .doc('proposals')
        .collection('proposal1');

    db.add({
      "group-id": _groupidController.text,
      "project-title": _titleController1.text,
      "project-type": projecttype,
      "project-category": category,
      "industrial-partner": _industrialpartnerController1.text,
      "problem-statement": _problemstatementController1.text,
      "objectives": _objectiesController1.text,
      "problem-background": _probbackgroundController1.text,
      "proposed-solution": _proposedsolutionController1.text,
      "proposed-tools": _proposedtoolsController1.text,
      "related-technologies": _relatedtechnologiesController1.text,
      "project-rationale": _projectrationaleController1.text,
      "proposed-methodology": _proposedmethodogiesController1.text,
      "schedule": _scheduleController1.text,
    });

    var dc = FirebaseFirestore.instance
        .collection('Convenor')
        .doc('classes')
        .collection('BS Information Technology')
        .doc('groups')
        .collection('projects')
        .doc('proposals')
        .collection('proposal1');

    dc.add({
      "group-id": _groupidController.text,
      "project-title": _titleController1.text,
      "project-type": projecttype,
      "project-category": category,
      "industrial-partner": _industrialpartnerController1.text,
      "problem-statement": _problemstatementController1.text,
      "objectives": _objectiesController1.text,
      "problem-background": _probbackgroundController1.text,
      "proposed-solution": _proposedsolutionController1.text,
      "proposed-tools": _proposedtoolsController1.text,
      "related-technologies": _relatedtechnologiesController1.text,
      "project-rationale": _projectrationaleController1.text,
      "proposed-methodology": _proposedmethodogiesController1.text,
      "schedule": _scheduleController1.text,
    });

    var cn = FirebaseFirestore.instance
        .collection("FYP")
        .doc("fyp(19-23)")
        .collection('groups')
        .doc(firebaseUser.uid)
        .collection("project")
        .doc('proposals')
        .collection('proposal2');

    cn.add({
      "group-id": _groupidController.text,
      "project-title": _titleController2.text,
      "project-type": projecttype2,
      "project-category": category2,
      "industrial-partner": _industrialpartnerController2.text,
      "problem-statement": _problemstatementController2.text,
      "objectives": _objectiesController2.text,
      "problem-background": _probbackgroundController2.text,
      "proposed-solution": _proposedsolutionController2.text,
      "proposed-tools": _proposedtoolsController2.text,
      "related-technologies": _relatedtechnologiesController2.text,
      "project-rationale": _projectrationaleController2.text,
      "proposed-methodology": _proposedmethodogiesController2.text,
      "schedule": _scheduleController2.text,
    });

    var cm = FirebaseFirestore.instance
        .collection('Convenor')
        .doc('classes')
        .collection('BS Information Technology')
        .doc('groups')
        .collection('projects')
        .doc('proposals')
        .collection('proposal2');

    cm.add({
      "group-id": _groupidController.text,
      "project-title": _titleController2.text,
      "project-type": projecttype2,
      "project-category": category2,
      "industrial-partner": _industrialpartnerController2.text,
      "problem-statement": _problemstatementController2.text,
      "objectives": _objectiesController2.text,
      "problem-background": _probbackgroundController2.text,
      "proposed-solution": _proposedsolutionController2.text,
      "proposed-tools": _proposedtoolsController2.text,
      "related-technologies": _relatedtechnologiesController2.text,
      "project-rationale": _projectrationaleController2.text,
      "proposed-methodology": _proposedmethodogiesController2.text,
      "schedule": _scheduleController2.text,
    });
  }
}
