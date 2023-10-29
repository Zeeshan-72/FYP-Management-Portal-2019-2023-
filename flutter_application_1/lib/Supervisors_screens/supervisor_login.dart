// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, empty_catches, use_build_context_synchronously, sort_child_properties_last

import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Supervisors_screens/supervisor_password_change.dart';
import 'package:flutter_application_1/Supervisors_screens/supervisor_signup.dart';

import 'package:flutter_application_1/convenor_screens/convenor_signup.dart';
import 'package:flutter_application_1/convenor_screens/supervisor_dashboard.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class SupervisorLogin extends StatefulWidget {
  SupervisorLogin({super.key});

  @override
  State<SupervisorLogin> createState() => _SupervisorLoginState();
}

final _auth = FirebaseAuth.instance;
final List<Map<String, dynamic>> userList = [
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
var firebaseUser = FirebaseAuth.instance.currentUser;

var _currentUserId = FirebaseAuth.instance.currentUser!.uid;

String email = "example@ntu.edu.pk";

class _SupervisorLoginState extends State<SupervisorLogin> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      String enteredEmail = email;
      String enteredPassword = pass;

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );

        String currentUserID = userCredential.user!.uid;
        if (email.endsWith("@ntu.edu.pk")) {
          // User ID exists, perform login logic here

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SupervisorDashboardScreen(
                      selectedIndex2: 0,
                    )),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('Login successful!'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // User ID does not exist
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User does not exist.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        // Error occurred during login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[600],
            content: Text('Login failed. Please check your credentials.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 500,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 120,
                      color: Colors.deepPurple,
                    ),

                    Text(
                      'Supervisor Portal',
                      style: GoogleFonts.bebasNeue(fontSize: 52),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'FYP(19-23)',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    // Email Text field.
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            onChanged: (text) {
                              email = text;
                            },
                            autofocus: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (text) {
                              RegExp regExp =
                                  RegExp(r'[a-zA-Z0-9]{3,20}@ntu\.edu\.pk');

                              var textNotNull = text ?? "";

                              if (textNotNull.isEmpty) {
                                return 'Email is required';
                              } else if (!regExp.hasMatch(textNotNull)) {
                                return 'Please enter your valid Faculty Email';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Email'),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //Password Field.

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (text) {
                              RegExp regExp = RegExp(
                                  r'^(?=.?[A-Z])(?=.?[a-z])(?=.*?[0-9]).{8,}$');

                              var textNotNull = text ?? "";

                              if (textNotNull.isEmpty) {
                                return 'Password is required';
                              } else if (!regExp.hasMatch(textNotNull)) {
                                return 'Must contain both uppercase and lowercase letters and numbers';
                              }

                              return null;
                            },
                            onChanged: (text) {
                              pass = text;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Password'),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // Sign in Button

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Center(
                        child: ElevatedButton(
                          child: SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    TextButton(
                        onPressed: () {
                          CircularProgressIndicator();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  SupervisorPasswordChange())));
                        },
                        child: Text(
                          'Reset Password?',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
