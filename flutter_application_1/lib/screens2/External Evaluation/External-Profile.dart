// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExternalProfile extends StatefulWidget {
  @override
  State<ExternalProfile> createState() => _ExternalProfileState();
}

class _ExternalProfileState extends State<ExternalProfile> {
  Map<String, dynamic>? userData;
  bool showSelection = false;

  bool _showDropDown = true;
  var evaluator2;

  var evaluator1;

  int numberOfDocuments = 0;
  Map<String, int> nameDocumentCount = {};

  var selectedName;
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

  final borderRadius = BorderRadius.circular(5);

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: EdgeInsets.all(2),
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xFF0D46BB)),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      // height: 50,
                      // width: 50,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData != null ? userData!['Name'] : '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Role: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text: ' External Evaluator',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'BSIT (Department of Computer Sciences)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    )
                  ],
                )
                //  CircleAvatar(
                //   backgroundImage: NetworkImage(
                //       'https://avatars3.githubusercontent.com/u/14101776?s=460&v=4'),
                //   radius: 50.0,
                // ),

                ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.black,
                    )),
                    TextSpan(
                      text: ' Personal Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Color.fromARGB(255, 241, 230, 241)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Table(
                  border: TableBorder.all(
                      width: 1.0, color: Color.fromRGBO(158, 158, 158, 1)),
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Full Name',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  userData != null ? userData!['Name'] : '',
                                )),
                            Container()
                          ],
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Affiliation',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  userData != null
                                      ? userData!['Affiliation']
                                      : '',
                                )),
                            Container()
                          ],
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'CNIC',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text('xxxxx-xxxxxxx-x')),
                            Container()
                          ],
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  userData != null ? userData!['Email'] : '',
                                )),
                            Container()
                          ],
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Gender',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Male')),
                            Container()
                          ],
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Religion',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Muslim')),
                            Container()
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                      Icons.account_box,
                      size: 32,
                      color: Colors.black,
                    )),
                    TextSpan(
                      text: ' Account Information',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Color.fromARGB(255, 241, 230, 241)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Table(
                  border: TableBorder.all(
                      width: 1.0, color: Color.fromRGBO(158, 158, 158, 1)),
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Login Email',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  userData != null ? userData!['Email'] : '',
                                )),
                            Container()
                          ],
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Phone',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text('03xx-xxxxxxx')),
                            Container()
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
