// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/convenor_screens/convenor_login.dart';
import 'package:google_fonts/google_fonts.dart';

class ConvenorPasswordChange extends StatefulWidget {
  const ConvenorPasswordChange({super.key});

  @override
  State<ConvenorPasswordChange> createState() => _ConvenorPasswordChangeState();
}

class _ConvenorPasswordChangeState extends State<ConvenorPasswordChange> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    resetPassword() async {
      // resetPassword();

      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        // Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 1, 75, 4),
            content: Text('Password reset email has been sent successfully')));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 194, 28, 16),
              content: Text('User not found')));
        }
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ConvenorLogin()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 100,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Reset Password',
                        style: GoogleFonts.bebasNeue(fontSize: 52),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Recieve an Email to change your password',
                        style: TextStyle(
                          fontSize: 16,
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
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: emailController,
                              onChanged: (text) {
                                // email = text;
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
                                  return 'Please enter your valid faculty Email';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: 'Email'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              resetPassword();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: const SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: Center(
                                    child: Text(
                                  "Reset Password",
                                  style: TextStyle(fontSize: 20),
                                ))),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
