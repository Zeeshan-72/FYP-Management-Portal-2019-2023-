// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Supervisors_screens/co_groups.dart';
import 'package:flutter_application_1/Supervisors_screens/dashboard.dart';
import 'package:flutter_application_1/Supervisors_screens/co_proposals.dart';
import 'package:flutter_application_1/screens/evaluation_screens/internal-evaluation.dart';
import 'package:flutter_application_1/Supervisors_screens/profile.dart';
import 'package:flutter_application_1/Supervisors_screens/sup_groups.dart';
import 'package:flutter_application_1/Supervisors_screens/super_proposals.dart';
import 'package:flutter_application_1/screens2/student-screens-2/homepage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SupervisorDashboardScreen extends StatefulWidget {
  SupervisorDashboardScreen({required this.selectedIndex2});

  final int selectedIndex2;

  @override
  SupervisorDashboardScreenState createState() =>
      SupervisorDashboardScreenState();
}

class ColorConstants {
  static Color blue = const Color(0xFF0D46BB);
}

final _auth = FirebaseAuth.instance;

var firebaseUser = FirebaseAuth.instance.currentUser;

String get Name => profilename(firebaseUser!.uid);

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
  } else if (value == 'S5OGYR4RkqZ6xzKqLlrVBeXIXgG2') {
    return Name = 'Muhammad Asif';
  } else {
    return Name = 'User not found';
  }
}

class SupervisorDashboardScreenState extends State<SupervisorDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int active = 0;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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

  final List<Map<String, dynamic>> userList = [
    {
      "userId": "Hopu7hxZy2aIWzz0sWNMvnPxvzG3",
      "name": "Dr. Muhammad Asif Habib"
    },
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
    {
      "userId": "A5Yb79Mx1oYCD4yv6iBVpERJMP33",
      "name": "Mr. Shahbaz Ahmad Sahi"
    },
    {"userId": "VK7qNqiWeucWOTWPyCSfCawWcF02", "name": "Mr. Muhammad Naeem"},
    {"userId": "GpVmXTKEpYSJg6zX8li91E3dTod2", "name": "Mr. Arsal Mahmood"},
    {"userId": "", "name": "Mr. Muhammad Nouman"},
    {"userId": "", "name": "Miss Sana Ikram"},
    {"userId": "UokwmyYyaxN0ZdSCn4UmXRhX4VA3", "name": "Miss Sara Naeem"},
    {"userId": "", "name": "Miss Kainat Rizwan"},
    {"userId": "", "name": "Miss Humael Hassan"},
    {"userId": "", "name": "Miss Saira Ishtiaq"},
  ];
  var firebaseUser = FirebaseAuth.instance.currentUser;

  var _currentUserId = FirebaseAuth.instance.currentUser!.uid;
  // var _currentUserId = 'A5Yb79Mx1oYCD4yv6iBVpERJMP33';

  String _currentUserName = '';

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        vsync: this, length: 7, initialIndex: widget.selectedIndex2)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });

    for (var user in userList) {
      if (user['userId'] == _currentUserId) {
        _currentUserName = user['name'];
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final screenModel = Provider.of<ScreenModel>(context);
    // Widget selectedScreen;
    // bool showExtraListTiles = false;

    // switch (screenModel.selectedScreen) {
    //   case ScreenType.dashboard:
    //     selectedScreen = SupervisorDashboard();
    //     break;
    //   case ScreenType.profile:
    //     selectedScreen = SupervisorProfile();
    //     break;
    //   case ScreenType.groups:
    //     selectedScreen = sup_groups();

    //     break;
    //   case ScreenType.proposals:
    //     selectedScreen = SuperProposals();
    //     break;
    //   case ScreenType.evaluations:
    //     selectedScreen = InternalEvaluation();

    //     break;
    //   case ScreenType.evaluations_8:
    //     selectedScreen = Semester_8_Evaluation();
    //     break;
    // }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width < 1300 ? true : false,
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 32),
                child: Text(
                  '$_currentUserName',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeue',
                  ),
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
                      width: 250,
                      color: Colors.white,
                      child: listDrawerItems(false)),
                ),
          SizedBox(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 270,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                SupervisorDashboard(),
                SupervisorProfile(),
                sup_groups(),
                co_groups(),
                SuperProposals(),
                CoProposals(),
                InternalEvaluation(),
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
        ExpansionTile(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.group,
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
              "My Groups",
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
                backgroundColor: tabController.index == 2
                    ? const Color(0xFF0D46BB)
                    : Colors.white,
              ),
              onPressed: () {
                tabController.animateTo(2);
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
                      color: tabController.index == 2
                          ? Colors.white
                          : Colors.black,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Main Supervision",
                      style: TextStyle(
                        fontSize: 15,
                        color: tabController.index == 2
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
                backgroundColor: tabController.index == 3
                    ? const Color(0xFF0D46BB)
                    : Colors.white,
              ),
              onPressed: () {
                tabController.animateTo(3);
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
                      color: tabController.index == 3
                          ? Colors.white
                          : Colors.black,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Co Supervision",
                      style: TextStyle(
                        fontSize: 15,
                        color: tabController.index == 3
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
        ExpansionTile(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.group,
            size: 23.0,
            color: Colors.black,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 13.0,
            color: Colors.black,
          ),
          title: Align(
            alignment: Alignment.topLeft,
            child: const Text(
              "Proposals",
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
                      top: 22, bottom: 32, right: 22, left: 25),
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
                      "Main-Supervision",
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
                      "Co Supervision",
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            // foregroundColor: Colors.white,
            backgroundColor: tabController.index == 6
                ? const Color(0xFF0D46BB)
                : Colors.white,
          ),
          // color: tabController.index == 0 ? Colors.grey[100] : Colors.white,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(6);
            drawerStatus ? Navigator.pop(context) : print("");
          },

          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.account_box,
                  color: tabController.index == 6 ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Internal Evaluation",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'HelveticaNeue',
                    color:
                        tabController.index == 6 ? Colors.white : Colors.black,
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
//
//
// Scaffold(
//   appBar: AppBar(
//     automaticallyImplyLeading:
//         MediaQuery.of(context).size.width < 1000 ? true : false,
//     title: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(left: 32),
//             child: Column(
//               children: [
//                 Text(
//                   '$_currentUserName',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'HelveticaNeue',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ]),
//     actions: <Widget>[
//       const Icon(Icons.web),
//       const SizedBox(width: 32),
//       const Icon(Icons.account_circle),
//       const SizedBox(width: 32),
//       IconButton(
//         padding: const EdgeInsets.all(0),
//         icon: const Icon(Icons.exit_to_app),
//         onPressed: () {
//           Navigator.pop(context);
//           // signOut();
//         },
//       ),
//       const SizedBox(width: 32),
//     ],
//     backgroundColor: Colors.blue,
//     // automaticallyImplyLeading: false,
//   ),
//   body: Row(
//     children: <Widget>[
//       MediaQuery.of(context).size.width < 1000
//           ? Container()
//           : Card(
//               elevation: 2.0,
//               child: Expanded(
//                 flex: 1,
//                 child: Container(
//                   margin: const EdgeInsets.all(0),
//                   height: MediaQuery.of(context).size.height,
//                   width: 250,
//                   color: Colors.white,
//                   child: ListView(
//                     padding: EdgeInsets.all(8),
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(8),
//                       ),
//                       ListTile(
//                         leading: SvgPicture.asset(
//                           "assets/four-squares-line-icon.svg",
//                           color: Colors.grey,
//                           height: 20,
//                         ),
//                         horizontalTitleGap: 0.0,
//                         selected: screenModel.selectedScreen ==
//                             ScreenType.dashboard,
//                         title: Text(
//                           'Dashboard',
//                         ),
//                         onTap: () => screenModel.selectedScreen =
//                             ScreenType.dashboard,
//                       ),
//                       ListTile(
//                         leading: SvgPicture.asset(
//                           "assets/young-businessman-icon.svg",
//                           color: Colors.grey,
//                           height: 20,
//                         ),
//                         horizontalTitleGap: 0.0,
//                         selected: screenModel.selectedScreen ==
//                             ScreenType.profile,
//                         title: Text('Profile'),
//                         onTap: () =>
//                             screenModel.selectedScreen = ScreenType.profile,
//                       ),
//                       ListTile(
//                         leading: SvgPicture.asset(
//                           "assets/groups.svg",
//                           color: Colors.grey,
//                           height: 25,
//                         ),
//                         horizontalTitleGap: 0.0,
//                         selected:
//                             screenModel.selectedScreen == ScreenType.groups,
//                         title: Text('Groups'),
//                         onTap: () =>
//                             screenModel.selectedScreen = ScreenType.groups,
//                       ),
//                       ListTile(
//                         leading: SvgPicture.asset(
//                           "assets/clipboard.svg",
//                           color: Colors.grey,
//                           height: 20,
//                         ),
//                         horizontalTitleGap: 0.0,
//                         selected: screenModel.selectedScreen ==
//                             ScreenType.proposals,
//                         title: Text('Proposals'),
//                         onTap: () => screenModel.selectedScreen =
//                             ScreenType.proposals,
//                       ),
//                       ExpansionTile(
//                         leading: Icon(Icons.document_scanner),
//                         // horizontalTitleGap: 0.0,
//                         title: Text('Evaluations'),
//                         onExpansionChanged: (isExpanded) {
//                           if (isExpanded) {
//                             // Perform any actions when the tile is expanded
//                           } else {
//                             // Perform any actions when the tile is collapsed
//                           }
//                         },
//                         children: [
//                           ListTile(
//                             title: Text('Semester 7'),
//                             selected: screenModel.selectedScreen ==
//                                 ScreenType.evaluations,
//                             onTap: () => screenModel.selectedScreen =
//                                 ScreenType.evaluations,
//                           ),
//                           ListTile(
//                             title: Text('Semester 8'),
//                             selected: screenModel.selectedScreen ==
//                                 ScreenType.evaluations,
//                             onTap: () => screenModel.selectedScreen =
//                                 ScreenType.evaluations_8,
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//       Expanded(
//         flex: 5,
//         child: Container(child: selectedScreen),
//       ),
//     ],
//   ),
//   drawer: Padding(
//       padding: const EdgeInsets.only(
//         top: 56,
//       ),
//       child: Drawer(
//         child: ListView(
//           children: [
//             ListTile(
//               selected: screenModel.selectedScreen == ScreenType.dashboard,
//               title: Text('Dashboard'),
//               onTap: () =>
//                   screenModel.selectedScreen = ScreenType.dashboard,
//             ),
//             ListTile(
//               selected: screenModel.selectedScreen == ScreenType.profile,
//               title: Text('Profile'),
//               onTap: () => screenModel.selectedScreen = ScreenType.profile,
//             ),
//             ListTile(
//               selected: screenModel.selectedScreen == ScreenType.groups,
//               title: Text('Groups'),
//               onTap: () => screenModel.selectedScreen = ScreenType.groups,
//             ),
//             ListTile(
//               selected: screenModel.selectedScreen == ScreenType.proposals,
//               title: Text('Proposals'),
//               onTap: () =>
//                   screenModel.selectedScreen = ScreenType.proposals,
//             ),
//             ListTile(
//               selected:
//                   screenModel.selectedScreen == ScreenType.evaluations,
//               title: Text('Evaluations'),
//               onTap: () =>
//                   screenModel.selectedScreen = ScreenType.evaluations,
//             ),
//           ],
//         ),
//       )),
// );

// class Profile extends StatelessWidget {
//   const Profile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           final screenModel = Provider.of<ScreenModel>(context, listen: false);
//           screenModel.selectedScreen = ScreenType.dashboard;
//         },
//         child: Text('Go to Form Screen'),
//       ),
//     );
//   }
// }

class Semester_8_Evaluation extends StatelessWidget {
  const Semester_8_Evaluation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
          child: Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue[200]),
              child: Center(
                child: Text('Internal & External Evaluations are Pending yet!',
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ))),
    ]);
  }
}
