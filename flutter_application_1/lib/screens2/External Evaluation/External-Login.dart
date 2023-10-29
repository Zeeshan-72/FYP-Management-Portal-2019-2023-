// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, empty_catches, use_build_context_synchronously, sort_child_properties_last

import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/convenor_screens/ConvenorDashboard.dart';

import 'package:flutter_application_1/convenor_screens/convenor_password_change.dart';
import 'package:flutter_application_1/convenor_screens/convenor_signup.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Dashboard.dart';
import 'package:flutter_application_1/screens2/student-screens-2/homepage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class ExternalLogin extends StatefulWidget {
  ExternalLogin({super.key});

  @override
  State<ExternalLogin> createState() => _ExternalLoginState();
}

final _auth = FirebaseAuth.instance;

class _ExternalLoginState extends State<ExternalLogin> {
  @override
  void initState() {
    super.initState();
    fetchUserIds();
  }

  List<String> userIds = [];

  void fetchUserIds() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('/External/accounts/Evaluators')
          .get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        String userId = documentSnapshot['userid'];
        userIds.add(userId);
      }

      // Print the list of user IDs
      print(userIds);
    } catch (e) {
      print('Error fetching user IDs: $e');
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        if (userIds.contains(currentUserID)) {
          // User ID exists, perform login logic here

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ExternalDashboard(
                selectedIndex2: 0,
              ),
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
      key: _scaffoldKey,
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
                      'EXTERNAL EVALUATOR',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 52, fontWeight: FontWeight.w500),
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
                              RegExp regExp =
                                  RegExp(r'[a-zA-Z0-9]{3,20}@ntu\.edu\.pk');

                              var textNotNull = text ?? "";

                              if (textNotNull.isEmpty) {
                                return 'Email is required';
                              } else if (!regExp.hasMatch(textNotNull)) {
                                return 'Please enter your valid Email';
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
                              RegExp regex =
                                  RegExp(r"^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$");

                              var textNotNull = text ?? "";

                              if (textNotNull.isEmpty) {
                                return 'Password is required';
                              } else if (!regex.hasMatch(textNotNull)) {
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
