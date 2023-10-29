// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, empty_catches, use_build_context_synchronously, sort_child_properties_last

import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/student_screens/forgetpassword.dart';

import 'package:flutter_application_1/student_screens/student_signup.dart';
import 'package:flutter_application_1/student_screens/student_dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class StudentLogin extends StatefulWidget {
  StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

final _auth = FirebaseAuth.instance;

class _StudentLoginState extends State<StudentLogin> {
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
        if (_formKey.currentState!.validate()) {
          // User ID exists, perform login logic here

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDashboard(),
            ),
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
                      Icons.school,
                      size: 120,
                      color: Colors.deepPurple,
                    ),

                    Text(
                      'STUDENT PORTAL',
                      style: GoogleFonts.bebasNeue(fontSize: 52),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'FYP (19-23)',
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
                              RegExp regExp = RegExp(
                                  r'[a-zA-Z0-9]{3,20}@student\.ntu\.edu\.pk');

                              var textNotNull = text ?? "";

                              if (textNotNull.isEmpty) {
                                return 'Email is required';
                              } else if (!regExp.hasMatch(textNotNull)) {
                                return 'Please enter your valid NTU Email';
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
                          child: const SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: Center(
                                  child: Text(
                                "Login",
                                style: TextStyle(fontSize: 20),
                              ))),
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple,
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
                              builder: ((context) => StudentPasswordChange())));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 20,
                    ),

                    // not a member.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not a member? ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextButton(
                            onPressed: () {
                              CircularProgressIndicator();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => StudentSignup())));
                            },
                            child: Text(
                              ' Register Now',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
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
