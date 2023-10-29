// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConvenorProfile extends StatefulWidget {
  const ConvenorProfile({super.key});

  @override
  State<ConvenorProfile> createState() => _ConvenorProfileState();
}

class _ConvenorProfileState extends State<ConvenorProfile> {
  final borderRadius = BorderRadius.circular(5);

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
    {"userId": "cpMIGGn4ZEfXe77uB4UOkJTQtu12", "name": "Dr. Abdul Qayoom"},
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

  var _currentUseremail = FirebaseAuth.instance.currentUser!.email;

  var _currentUserId = FirebaseAuth.instance.currentUser!.uid;

  String _currentUserName = '';

  @override
  void initState() {
    super.initState();

    for (var user in userList) {
      if (user['userId'] == _currentUserId) {
        _currentUserName = user['name'];
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    
    Scaffold(
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
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 46, 170, 250),
                    Color.fromARGB(255, 31, 47, 152),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      // height: 50,
                      // width: 50,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: borderRadius),
                      child: ClipRRect(
                        borderRadius: borderRadius,
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
                          "$_currentUserName",
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
                                text: 'Designation: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text: ' Convenor',
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
                  border: TableBorder.all(width: 1.0, color: Colors.black),
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
                                child: Text('$_currentUserName')),
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
                                  'Designation',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Convenor')),
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
                                child: Text('$_currentUseremail')),
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
                  border: TableBorder.all(width: 1.0, color: Colors.black),
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
                                child: Text('$_currentUseremail')),
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
