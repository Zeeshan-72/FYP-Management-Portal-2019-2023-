// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, unused_import, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/AllGroups.dart';
import 'package:flutter_application_1/Supervisors_screens/co_groups.dart';
import 'package:flutter_application_1/Supervisors_screens/co_proposals.dart';

import 'package:flutter_application_1/Supervisors_screens/sup_groups.dart';
import 'package:flutter_application_1/convenor_screens/Allproposals.dart';
import 'package:flutter_application_1/convenor_screens/ConvenorProfile.dart';
import 'package:flutter_application_1/convenor_screens/Evaluations.dart';
import 'package:flutter_application_1/convenor_screens/bsit_groups.dart';

import 'package:flutter_application_1/convenor_screens/dashboard-convenor.dart';
import 'package:flutter_application_1/convenor_screens/manageevaluation.dart';
import 'package:flutter_application_1/convenor_screens/supervisor_dashboard.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Dashboard-Screen.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Evaluation.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Groups.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Profile.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/My-External-Group-Marksheet.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/My-External-Groups.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/external-accounts.dart';
import 'package:flutter_application_1/screens2/convenor-screens-2/final-evaluation-allocation.dart';
import 'package:flutter_application_1/screens2/student-screens-2/homepage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ExternalDashboard extends StatefulWidget {
  final int selectedIndex2;

  ExternalDashboard({required this.selectedIndex2});

  @override
  ExternalDashboardState createState() => ExternalDashboardState();
}

class ColorConstants {
  static Color blue = const Color(0xFF0D46BB);
}

final _auth = FirebaseAuth.instance;

var firebaseUser = FirebaseAuth.instance.currentUser;

class ExternalDashboardState extends State<ExternalDashboard>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int active = 0;
  @override
  void initState() {
    fetchUserData();
    super.initState();
    tabController = TabController(
        vsync: this, length: 4, initialIndex: widget.selectedIndex2)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Map<String, dynamic>? userData;

  Future<void> fetchUserData() async {
    var user = await FirebaseAuth.instance.currentUser;

    var userId = user!.uid;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('/External/accounts/Evaluators')
          .where('userid', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        userData = querySnapshot.docs.first.data() as Map<String, dynamic>?;
        setState(() {}); // Update the UI with the fetched user data
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  signOut() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign Out'),
            content: Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(false); // Dismiss the dialog and pass false
                },
              ),
              TextButton(
                child: Text('Sign Out'),
                onPressed: () async {
                  await auth.signOut();

                  // Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width < 1300 ? true : false,
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 32),
                child: Column(
                  children: [
                    Text(
                      userData != null ? userData!['Name'] : '',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'HelveticaNeue',
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        actions: <Widget>[
          const Icon(Icons.web),
          const SizedBox(width: 32),
          const Icon(Icons.account_circle),
          const SizedBox(width: 32),
          IconButton(
            padding: const EdgeInsets.all(0),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              signOut();
            },
          ),
          const SizedBox(width: 32),
        ],
        backgroundColor: ColorConstants.blue,
        // automaticallyImplyLeading: false,
      ),
      body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1300
              ? Container()
              : Card(
                  elevation: 2.0,
                  child: Container(
                      margin: const EdgeInsets.all(0),
                      height: MediaQuery.of(context).size.height,
                      width: 300,
                      color: Colors.white,
                      child: listDrawerItems(false)),
                ),
          SizedBox(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 310,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                ExternalDashboardScreen(),
                ExternalProfile(),
                MyExternalGroups(),
                MyExternalGroupMarksheet(),
              ],
            ),
          )
        ],
      ),
      drawer: Padding(
          padding: const EdgeInsets.only(
            top: 56,
          ),
          child: Drawer(child: listDrawerItems(true))),
    );
  }

  Widget listDrawerItems(bool drawerStatus) {
    return ListView(
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            // foregroundColor: Colors.white,
            backgroundColor: tabController.index == 0
                ? const Color(0xFF0D46BB)
                : Colors.white,
          ),
          // color: tabController.index == 0 ? Colors.grey[100] : Colors.white,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(0);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.dashboard,
                  color: tabController.index == 0 ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'HelveticaNeue',
                    color:
                        tabController.index == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ]),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            // foregroundColor: Colors.white,
            backgroundColor: tabController.index == 1
                ? const Color(0xFF0D46BB)
                : Colors.white,
          ),
          // color: tabController.index == 0 ? Colors.grey[100] : Colors.white,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(1);
            drawerStatus ? Navigator.pop(context) : print("");
          },

          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.account_box,
                  color: tabController.index == 1 ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'HelveticaNeue',
                    color:
                        tabController.index == 1 ? Colors.white : Colors.black,
                  ),
                ),
              ]),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            // foregroundColor: Colors.white,
            backgroundColor: tabController.index == 2
                ? const Color(0xFF0D46BB)
                : Colors.white,
          ),
          // color: tabController.index == 0 ? Colors.grey[100] : Colors.white,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(2);
            drawerStatus ? Navigator.pop(context) : print("");
          },

          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.account_box,
                  color: tabController.index == 2 ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Groups",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'HelveticaNeue',
                    color:
                        tabController.index == 2 ? Colors.white : Colors.black,
                  ),
                ),
              ]),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            // foregroundColor: Colors.white,
            backgroundColor: tabController.index == 3
                ? const Color(0xFF0D46BB)
                : Colors.white,
          ),
          // color: tabController.index == 0 ? Colors.grey[100] : Colors.white,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(3);
            drawerStatus ? Navigator.pop(context) : print("");
          },

          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.account_box,
                  color: tabController.index == 3 ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Evaluation Results",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'HelveticaNeue',
                    color:
                        tabController.index == 3 ? Colors.white : Colors.black,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
