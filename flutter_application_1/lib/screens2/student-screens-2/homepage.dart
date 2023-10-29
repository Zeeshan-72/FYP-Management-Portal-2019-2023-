// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Supervisors_screens/dashboard.dart';
import 'package:flutter_application_1/Supervisors_screens/profile.dart';
import 'package:flutter_application_1/Supervisors_screens/sup_groups.dart';
import 'package:flutter_application_1/Supervisors_screens/super_proposals.dart';
import 'package:flutter_application_1/Supervisors_screens/supervisor_login.dart';
import 'package:flutter_application_1/convenor_screens/convenor_login.dart';
import 'package:flutter_application_1/convenor_screens/supervisor_dashboard.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/evaluation_screens/internal-evaluation.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Login.dart';
import 'package:flutter_application_1/student_screens/student_login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [Body()],
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 460,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FYP\nMANAGEMENT\nPORTAL',

                style: GoogleFonts.lato(
                  fontSize: 45,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 10, 10, 10),
                ),
                // TextStyle(
                //   fontSize: 45,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "If you don't have an account",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "You can",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      print(MediaQuery.of(context).size.width);
                    },
                    child: Text(
                      "Register here!",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'images/illustration-2.png',
                width: 300,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),

        // Image.asset(
        //   'images/illustration-1.png',
        //   width: 300,
        // ),
        // MediaQuery.of(context).size.width >= 1300 //Responsive
        //     ? Image.asset(
        //         'images/illustration-1.png',
        //         width: 300,
        //       )
        //     : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: Container(
            width: 320,
            child: Column(children: [
              Row(children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey[300],
                    height: 50,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("You are a"),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey[400],
                    height: 50,
                  ),
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                child: const SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Center(
                        child: Text(
                      "Student",
                      style: TextStyle(fontSize: 20),
                    ))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentLogin(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: const Center(
                        child: Text(
                      "Supervisor",
                      style: TextStyle(fontSize: 20),
                    ))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupervisorLogin(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                  decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              )),
              ElevatedButton(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: const Center(
                        child: Text(
                      "Convenor",
                      style: TextStyle(fontSize: 20),
                    ))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConvenorLogin(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                  decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              )),
              ElevatedButton(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: const Center(
                        child: Text(
                      "External",
                      style: TextStyle(fontSize: 20),
                    ))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExternalLogin(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey[300],
                    height: 50,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Or continue with"),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey[400],
                    height: 50,
                  ),
                ),
              ]),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentLogin(),
                          ),
                        );
                      }),
                      child: _loginWithButton(image: 'images/student.png')),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupervisorLogin(),
                          ),
                        );
                      },
                      child: _loginWithButton(
                        image: 'images/supervisor.png',
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConvenorLogin(),
                          ),
                        );
                      },
                      child: _loginWithButton(image: 'images/teacher.png')),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _loginWithButton({required String image, bool isActive = false}) {
    return Container(
      width: 90,
      height: 70,
      decoration: isActive
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 10,
                  blurRadius: 30,
                )
              ],
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey),
            ),
      child: Center(
          child: Container(
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 15,
                  )
                ],
              )
            : BoxDecoration(),
        child: Image.asset(
          '$image',
          width: 50,
        ),
      )),
    );
  }
}
