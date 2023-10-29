// ignore_for_file: prefer_const_constructors, unused_import, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_label, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Supervisors_screens/dashboard.dart';
import 'package:flutter_application_1/Supervisors_screens/profile.dart';
import 'package:flutter_application_1/Supervisors_screens/sup_groups.dart';
import 'package:flutter_application_1/Supervisors_screens/super_proposals.dart';
import 'package:flutter_application_1/convenor_screens/8-bsit-supervisor-evaluation.dart';
import 'package:flutter_application_1/convenor_screens/ConvenorDashboard.dart';
import 'package:flutter_application_1/convenor_screens/bsit_groups.dart';
import 'package:flutter_application_1/convenor_screens/dashboard-convenor.dart';
import 'package:flutter_application_1/convenor_screens/manageevaluation.dart';
import 'package:flutter_application_1/convenor_screens/supervisor_dashboard.dart';

import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/myproposal.dart';
import 'package:flutter_application_1/screens2/8-Evaluations/8-Internal/8-BSIT-Results-till-Internal.dart';
import 'package:flutter_application_1/screens2/8-Evaluations/8-Internal/8-my-internal-groups.dart';
import 'package:flutter_application_1/screens2/8-Evaluations/8-Internal/my-group-internal-result.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/BSIT-External-Final-Result.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/BSIT-Overall-Result.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Dashboard-Screen.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Dashboard.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Evaluation.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Login.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/ExternalEvaluation.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/My-External-Group-Marksheet.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/My-External-Groups.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/external-accounts.dart';
import 'package:flutter_application_1/screens2/student-screens-2/homepage.dart';
import 'package:flutter_application_1/screens2/student-screens-2/student-dashboard.dart';
import 'package:flutter_application_1/screens2/student-screens-2/studentevaluation.dart';
import 'package:flutter_application_1/student_screens/member_form.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async';

import 'package:provider/provider.dart';

import 'screens/evaluation_screens/internal-evaluation.dart';
import 'screens2/8-Evaluations/8-Internal/final-internal-class-result.dart';
import 'screens2/External Evaluation/External-Group-Allocation.dart';
import 'screens2/student-screens-2/mygroup.dart';
import 'package:file_picker/file_picker.dart';
import 'package:english_words/english_words.dart';

import 'package:random_string/random_string.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

enum ScreenType {
  dashboard,
  profile,
  groups,
  proposals,
  evaluations,
  evaluations_8,
}

class ScreenModel with ChangeNotifier {
  ScreenType _selectedScreen = ScreenType.dashboard;

  ScreenType get selectedScreen => _selectedScreen;

  set selectedScreen(ScreenType value) {
    _selectedScreen = value;
    notifyListeners();
  }
}

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    // copyDocumentData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collectionGroup('External-Evaluation-Results')
//           // .orderBy('fyp-id')
//          .where('meevaluator', isEqualTo: '')
//           .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return ElevatedButton(
//               onPressed: () {
//                 print('Error: ${snapshot.error}');
//               },
//               child: Text(''));
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }

//         List<DocumentSnapshot> documents = snapshot.data!.docs;

//         return ListView.builder(
//           itemCount: documents.length,
//           itemBuilder: (BuildContext context, int index) {
//             Map<String, dynamic> data =
//                 documents[index].data() as Map<String, dynamic>;
//             String fypId = data['fyp-id'];
//             // Customize how you want to display the data in the list
//             return ListTile(
//               title: Text(fypId),
//             );
//           },
//         );
//       },
//     );
//   }
// }
