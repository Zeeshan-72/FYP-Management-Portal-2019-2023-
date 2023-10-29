// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/myproposal.dart';
import 'package:flutter_application_1/screens2/student-screens-2/homepage.dart';
import 'package:flutter_application_1/student_screens/member_form.dart';
import 'package:flutter_application_1/student_screens/mygroup.dart';
import 'package:flutter_application_1/student_screens/myproposal.dart';

import 'package:flutter_flushbar/flutter_flushbar.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext Dashboard) {
    // to get size
    var size = MediaQuery.of(context).size;

    // style

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                height: 64,
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  'https://img.icons8.com/color/344/user-male-circle--v1.png'),
                            ),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              'Student Dashboard',
                              style: TextStyle(
                                  fontFamily: "Open Sans",
                                  color: Colors.deepPurple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'FYP(19-23)',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple,
                                  fontFamily: "Open Sans"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: InkWell(
                        child: const Image(
                          image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/6568/6568636.png',
                          ),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: new Text("Logout"),
                                    content: const Text(
                                        "Are you sure, do you want to logout?"),
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          TextButton(
                                            child: const Text('No'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Yes'),
                                            onPressed: () {
                                              _auth.signOut();
                                              Navigator.pop(context);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          HomePage()));

                                              Flushbar(
                                                backgroundColor: Color.fromRGBO(
                                                    239, 83, 80, 1),
                                                titleText: const Text('Logout'),
                                                messageText: const Text(
                                                    'You\'ve Logged out'),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ).show(context);
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ));
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 75,
                  crossAxisSpacing: 35,
                  primary: false,
                  crossAxisCount: 5,
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26)),
                      elevation: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Mygroup(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              'https://img.icons8.com/external-flaticons-flat-flat-icons/344/external-group-100-most-used-icons-flaticons-flat-flat-icons.png',
                              height: 138,
                            ),
                            const Text('My Group',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26)),
                      elevation: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              'https://img.icons8.com/external-flaticons-flat-flat-icons/344/external-supervisor-character-icons-flaticons-flat-flat-icons.png',
                              height: 128,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text('My Supervisor',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26)),
                      elevation: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProposal(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              'https://img.icons8.com/external-gradient-design-circle/344/external-computer-activities-gradient-design-circle-4.png',
                              height: 128,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text('My Proposal',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26)),
                      elevation: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              'https://img.icons8.com/color/344/report-card.png',
                              height: 128,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text('Grade Book',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26)),
                      elevation: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          // checkdata;
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const MemberForm(),
                          //   ),
                          // );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              'https://img.icons8.com/ultraviolet/344/settings.png',
                              height: 128,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Settings',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkdata() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                "/FYP/fyp(19-23)/BS Information Technology/groups/member")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(child: const CircularProgressIndicator());
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemberForm(),
                ));
          }
          return ListView();
        });
  }

  Signout() {
    FirebaseAuth.instance.signOut();
  }
}
