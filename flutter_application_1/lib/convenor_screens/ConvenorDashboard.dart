// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, unused_import

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
import 'package:flutter_application_1/screens2/External%20Evaluation/external-accounts.dart';
import 'package:flutter_application_1/screens2/convenor-screens-2/final-evaluation-allocation.dart';
import 'package:flutter_application_1/screens2/student-screens-2/homepage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../screens2/External Evaluation/External-Evaluation.dart';
import '../screens2/External Evaluation/ExternalEvaluation.dart';

class ConvenorDashboardScreen extends StatefulWidget {
  @override
  State<ConvenorDashboardScreen> createState() =>
      _ConvenorDashboardScreenState();
}

class _ConvenorDashboardScreenState extends State<ConvenorDashboardScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  //signout function
  @override
  Widget build(BuildContext context) {
    final screenModel = Provider.of<ScreenModel>(context);

    Widget selectedScreen;

    switch (screenModel.selectedScreen) {
      case ScreenType.dashboard:
        selectedScreen = ConvenorDashboard();
        break;
      case ScreenType.profile:
        selectedScreen = ConvenorProfile();
        break;
      case ScreenType.groups:
        selectedScreen = BSITGroups();

        break;
      case ScreenType.proposals:
        selectedScreen = AllProposals();
        break;

      case ScreenType.evaluations:
        selectedScreen = EvaluatorAllocationFinal();
        break;
      case ScreenType.evaluations_8:
        selectedScreen = Semester_8_Evaluation();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width < 1000 ? true : false,
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 32),
                child: Column(
                  children: const [
                    Text(
                      'Mr. Shahbaz Ahmad Sahi',
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
        backgroundColor: Colors.blue,
        // automaticallyImplyLeading: false,
      ),
      body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1000
              ? Container()
              : Card(
                  elevation: 2.0,
                  child: Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      height: MediaQuery.of(context).size.height,
                      width: 250,
                      color: Colors.white,
                      child: ListView(
                        padding: EdgeInsets.all(8),
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/four-squares-line-icon.svg",
                              color: Colors.grey,
                              height: 20,
                            ),
                            horizontalTitleGap: 0.0,
                            selected: screenModel.selectedScreen ==
                                ScreenType.dashboard,
                            title: Text(
                              'Dashboard',
                            ),
                            onTap: () => screenModel.selectedScreen =
                                ScreenType.dashboard,
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/young-businessman-icon.svg",
                              color: Colors.grey,
                              height: 20,
                            ),
                            horizontalTitleGap: 0.0,
                            selected: screenModel.selectedScreen ==
                                ScreenType.profile,
                            title: Text('Profile'),
                            onTap: () =>
                                screenModel.selectedScreen = ScreenType.profile,
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/groups.svg",
                              color: Colors.grey,
                              height: 25,
                            ),
                            horizontalTitleGap: 0.0,
                            selected:
                                screenModel.selectedScreen == ScreenType.groups,
                            title: Text('Groups'),
                            onTap: () =>
                                screenModel.selectedScreen = ScreenType.groups,
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/clipboard.svg",
                              color: Colors.grey,
                              height: 20,
                            ),
                            horizontalTitleGap: 0.0,
                            selected: screenModel.selectedScreen ==
                                ScreenType.proposals,
                            title: Text('Proposals'),
                            onTap: () => screenModel.selectedScreen =
                                ScreenType.proposals,
                          ),
                          ListTile(
                            leading: Icon(Icons.document_scanner),
                            horizontalTitleGap: 0.0,
                            selected: screenModel.selectedScreen ==
                                ScreenType.evaluations,
                            title: Text('Evaluations'),
                            onTap: () => screenModel.selectedScreen =
                                ScreenType.evaluations,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          Expanded(
            flex: 5,
            child: Container(child: selectedScreen),
          ),
        ],
      ),
      drawer: Padding(
          padding: const EdgeInsets.only(
            top: 56,
          ),
          child: Drawer(
            child: ListView(
              children: [
                ListTile(
                  selected: screenModel.selectedScreen == ScreenType.dashboard,
                  title: Text('Dashboard'),
                  onTap: () =>
                      screenModel.selectedScreen = ScreenType.dashboard,
                ),
                ListTile(
                  selected: screenModel.selectedScreen == ScreenType.profile,
                  title: Text('Profile'),
                  onTap: () => screenModel.selectedScreen = ScreenType.profile,
                ),
                ListTile(
                  selected: screenModel.selectedScreen == ScreenType.groups,
                  title: Text('Groups'),
                  onTap: () => screenModel.selectedScreen = ScreenType.groups,
                ),
                ListTile(
                  selected: screenModel.selectedScreen == ScreenType.proposals,
                  title: Text('Proposals'),
                  onTap: () =>
                      screenModel.selectedScreen = ScreenType.proposals,
                ),
                ListTile(
                  selected:
                      screenModel.selectedScreen == ScreenType.evaluations,
                  title: Text('Evaluations'),
                  onTap: () =>
                      screenModel.selectedScreen = ScreenType.evaluations,
                ),
              ],
            ),
          )),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final screenModel = Provider.of<ScreenModel>(context, listen: false);
          screenModel.selectedScreen = ScreenType.dashboard;
        },
        child: Text('Go to Form Screen'),
      ),
    );
  }
}

class ConvenorDashboard2 extends StatefulWidget {
  final int selectedIndex2;

  ConvenorDashboard2({required this.selectedIndex2});

  @override
  ConvenorDashboard2State createState() => ConvenorDashboard2State();
}

class ColorConstants {
  static Color blue = const Color(0xFF0D46BB);
}

final _auth = FirebaseAuth.instance;

var firebaseUser = FirebaseAuth.instance.currentUser;

String get Name => profilename('A5Yb79Mx1oYCD4yv6iBVpERJMP33');

profilename(String value) {
  String Name = '';
  if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
    return Name = 'Mr. Shahbaz Ahmad Sahi';
  } else if (value == 'W0RSGhwWvLUUgvMGkds9xVOLSaA3') {
    return Name = 'Waqar Ahmad';
  } else if (value == 'cpMIGGn4ZEfXe77uB4UOkJTQtu12') {
    return Name = 'Abdul Qayoom';
  } else if (value == 'RndCDn7CRKRz7uvzysR89Iga07f1') {
    return Name = 'Toqeer Mahmood';
  } else if (value == 'JLJV5AExTpg2IMgWVBC8sK3774q2') {
    return Name = 'Rehan Ashraf';
  } else if (value == 'UY') {
    Name = 'Sana Ikram';
  } else {
    return Name = 'User not found';
  }
}

class ConvenorDashboard2State extends State<ConvenorDashboard2>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int active = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
        vsync: this, length: 6, initialIndex: widget.selectedIndex2)
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

  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  signOut() async {
    await auth.signOut();

    // Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
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
                      Name,
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
                ConvenorDashboard(),
                ConvenorProfile(),
                BSITGroups(),
                AllProposals(),
                ManageEvaluation(),
                ExternalEvaluation_2(),
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
                  Icons.article,
                  color: tabController.index == 3 ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Proposals",
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
        ExpansionTile(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.assessment_rounded,
            size: 23.0,
            color: Colors.black,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 13.0,
            color: Colors.black,
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Evaluations",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: tabController.index == 4
                    ? const Color(0xFF0D46BB)
                    : Colors.white,
              ),
              onPressed: () {
                tabController.animateTo(4);
                drawerStatus ? Navigator.pop(context) : print("");
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 22, bottom: 22, right: 32, left: 25),
                  child: Row(children: [
                    Icon(
                      Icons.category,
                      color: tabController.index == 4
                          ? Colors.white
                          : Colors.black,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Internal Evaluation",
                      style: TextStyle(
                        fontSize: 15,
                        color: tabController.index == 4
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'HelveticaNeue',
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // foregroundColor: Colors.white,
                backgroundColor: tabController.index == 5
                    ? const Color(0xFF0D46BB)
                    : Colors.white,
              ),
              onPressed: () {
                tabController.animateTo(5);
                drawerStatus ? Navigator.pop(context) : print("");
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 22, bottom: 22, right: 22, left: 25),
                  child: Row(children: [
                    Icon(
                      Icons.category,
                      color: tabController.index == 5
                          ? Colors.white
                          : Colors.black,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "External Evaluation",
                      style: TextStyle(
                        fontSize: 15,
                        color: tabController.index == 5
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'HelveticaNeue',
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  HeroAnimation() {
    return SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                    '/Convenor/classes/BS Information Technology/groups/group-members')
                .where('co-supervisor', isEqualTo: 'Mr. Shahbaz Ahmad Sahi')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data?.size == 0) {
                return const Text('Supervisors not allocated yet');
              }
              return Column(
                children: [
                  ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                const Text('Main Supervisor'),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  document["mem1"],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text('Co Supervisor'),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  document["mem2"],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        );
                      }).toList()),
                ],
              );
            }));
  }

  Profile() {
    return const Text('profile');
  }
}
