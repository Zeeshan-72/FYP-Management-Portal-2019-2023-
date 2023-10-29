// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, empty_catches, use_build_context_synchronously, sort_child_properties_last

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/convenor_screens/supervisor_dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class SupervisorSignup extends StatefulWidget {
  SupervisorSignup({super.key});

  @override
  State<SupervisorSignup> createState() => _SupervisorSignupState();
}

final _auth = FirebaseAuth.instance;

class _SupervisorSignupState extends State<SupervisorSignup> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 500,
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
                    'FYP (19-23)',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  // Email Text field.
                  Form(
                    key: _formKey,
                    child: Padding(
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
                                border: InputBorder.none,
                                hintText: 'Enter Your Faculty Email'),
                          ),
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
                          onChanged: (text) {
                            pass = text;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            RegExp regExp = RegExp(
                                r'^(?=.?[A-Z])(?=.?[a-z])(?=.*?[0-9]).{8,}$');

                            var textNotNull = text ?? "";

                            if (textNotNull.isEmpty) {
                              return 'Password is required';
                            } else if (!regExp.hasMatch(textNotNull)) {
                              return 'Must be 8 digit long and Alphanumeric with one uppercase';
                            }

                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Your Password'),
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
                          height: 55,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          try {
                            final credential = FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: email,
                                  password: pass,
                                )
                                .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            SupervisorDashboardScreen(
                                              selectedIndex2: 0,
                                            )))));

                            Flushbar(
                              backgroundColor: Colors.blue,
                              titleText: const Text('New User Created'),
                              messageText: const Text('Welcome!'),
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
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
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
