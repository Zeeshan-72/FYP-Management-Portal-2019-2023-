// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, empty_catches, use_build_context_synchronously, sort_child_properties_last

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/student_screens/member_form.dart';
import 'package:flutter_application_1/student_screens/student_dashboard.dart';
import 'package:flutter_application_1/student_screens/student_login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class StudentSignup extends StatefulWidget {
  StudentSignup({super.key});

  @override
  State<StudentSignup> createState() => _StudentSignupState();
}

final _auth = FirebaseAuth.instance;

class _StudentSignupState extends State<StudentSignup> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController regnoController = TextEditingController();
  var _selectedProgram;
  final TextEditingController groupidController = TextEditingController();

  final TextEditingController emailController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

  String email = '';
  String pass = '';

  bool _programTouched = false;
  String _password = '';
  String _confirmPassword = '';
  bool _passwordVisible = false;

  String _text = '';

  final List<String> _programs = [
    'BSIT',
    'BSSE',
    'BSCS',
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController1.text,
        password: passwordController2.text,
      );
      // Signup successful, show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup Successful'),
          duration: Duration(seconds: 2),
        ),
      );
      // Navigate to StudentDashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StudentDashboard()),
      );
    } catch (e) {
      // Signup failed, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup Failed: $e'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Signup failed: $e');
    }
  }

  // void checkEmailVerification() async {
  //   User? user = _auth.currentUser;
  //   if (user != null && user.emailVerified) {
  //     // Email already verified, navigate to the dashboard screen
  //     navigateToLoginScreen();
  //   }
  // }

  // Future<void> signUpWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);

  //     // Send email verification
  //     await userCredential.user!.sendEmailVerification();

  //     // Show success message or navigate to the next screen
  //     // You can use SnackBar, AlertDialog, or Navigator to handle UI feedback
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Success'),
  //           content: Text(
  //               'A verification email has been sent to your email address. Please verify to proceed.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 // navigateToLoginScreen();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     // Show error message
  //     // You can use SnackBar, AlertDialog, or any other method to display the error to the user
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text(e.toString()),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // void navigateToLoginScreen() {
  //   // Replace the current screen with the dashboard screen
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => StudentLogin(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Image.asset(
                    'images/illustration-2.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  // color: Color.fromARGB(0, 60, 111, 254),
                  color: Colors.deepPurple,
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(40),
                  height: MediaQuery.of(context).size.height,
                  // height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.school,
                        size: 90,
                        color: Colors.deepPurple,
                      ),
                      Text(
                        'Register Now',
                        style: GoogleFonts.bebasNeue(fontSize: 42),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'FYP (19-23)',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Full Name',
                                        style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      margin: EdgeInsets.all(10),
                                      // padding: EdgeInsets.symmetric(
                                      //     horizontal: 10,),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextFormField(
                                        controller: nameController,
                                        autofocus: true,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        // controller: textController2,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 12.0),
                                        ),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Registration No',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      width: 50,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextFormField(
                                        controller: regnoController,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        // controller: textController2,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 12.0),
                                        ),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                        // inputFormatters: [
                                        //   MaskTextInputFormatter(
                                        //     mask: "19-NTU-CS-####",
                                        //     filter: {
                                        //       "#": RegExp(r'[0-9]'),
                                        //       "Y": RegExp(r'[A-Z]')
                                        //     },
                                        //   )
                                        // ],
                                        validator: (text) {
                                          RegExp regExp = RegExp(
                                              r'^\d{2}-[A-Z]{3}-[A-Z]{2}-\d{4}$');

                                          var textNotNull = text ?? "";

                                          if (textNotNull.isEmpty) {
                                            return 'Registration No. is required';
                                          } else if (!regExp
                                              .hasMatch(textNotNull)) {
                                            return 'Please enter your valid NTU Registration No. e.g 19-NTU-CS-1172';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Section',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DropdownButtonFormField<String>(
                                            value: _selectedProgram,
                                            hint: Text(
                                              'Select a program',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                              ),
                                            ),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedProgram = newValue!;
                                                _programTouched = true;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 12.0),
                                            ),
                                            items: _programs.map((program) {
                                              return DropdownMenuItem<String>(
                                                value: program,
                                                child: Text(program),
                                              );
                                            }).toList(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                          if (_programTouched &&
                                              _selectedProgram == null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12),
                                              child: Text(
                                                'Please select a program',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12.0),
                                              ),
                                            ),
                                        ],
                                      ),

                                      // display the validation message if no program is selected
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Email',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      width: 50,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextFormField(
                                        controller: emailController1,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 12.0),
                                        ),
                                        validator: (text) {
                                          RegExp regExp = RegExp(
                                              r'[a-zA-Z0-9]{3,20}@student\.ntu\.edu\.pk');

                                          var textNotNull = text ?? "";

                                          if (textNotNull.isEmpty) {
                                            return 'Email is required';
                                          } else if (!regExp
                                              .hasMatch(textNotNull)) {
                                            return 'Please enter your valid NTU Email';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Password',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      // padding: EdgeInsets.symmetric(
                                      //     horizontal: 10,),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextFormField(
                                        obscureText: !_passwordVisible,
                                        controller: passwordController2,
                                        autofocus: true,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        // controller: textController2,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey,
                                              size: 15,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 12.0),
                                        ),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                        validator: (text) {
                                          RegExp regExp = RegExp(
                                              r'^(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{8,}$');

                                          var textNotNull = text ?? "";

                                          if (textNotNull.isEmpty) {
                                            return 'Password is required';
                                          } else if (!regExp
                                              .hasMatch(textNotNull)) {
                                            return 'Must be 8 digit long and Alphanumeric with one uppercase';
                                          }

                                          return null;
                                        },
                                        onChanged: (text) {
                                          _password = text;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Confirm Password',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      width: 50,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          // border: OutlineInputBorder(),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 12.0),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please confirm your password';
                                          }
                                          if (value != _password) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          _confirmPassword = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0,
                                  ),
                                  child: Container(),
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 17, horizontal: 15)),
                                    onPressed: signUp,
                                    child: Text('Create Account')))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController1.text.trim(),
        password: passwordController2.text,
      );
      if (!userCredential.user!.emailVerified) {
        _showMessage('Please verify your email address');
        await userCredential.user!.sendEmailVerification();
        _showMessage('Verification email has been sent');
      } else {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'User not found. Please check your email and password.';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password. Please check your email and password.';
      } else {
        message = 'An error occurred. Please try again later.';
      }
      _showMessage(message);
    }
  }

  void _showMessage(String message) {
    print(message);
    // _scaffoldKey.currentState.showSnackBar(SnackBar(
    //   content: Text(message),
    //   duration: Duration(seconds: 3),
    // ));
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to the Dashboard!'),
      ),
    );
  }
}
