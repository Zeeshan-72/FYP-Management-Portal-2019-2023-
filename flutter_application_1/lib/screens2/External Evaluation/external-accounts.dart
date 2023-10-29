// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:csv/csv.dart';
import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:random_string/random_string.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io' as io;
import 'dart:async';

import 'package:universal_html/html.dart' show AnchorElement;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as ios;
import 'dart:convert';

import '../../../main.dart';

class ExternalEvaluatorData extends StatefulWidget {
  const ExternalEvaluatorData({super.key});

  @override
  State<ExternalEvaluatorData> createState() => _ExternalEvaluatorDataState();
}

class _ExternalEvaluatorDataState extends State<ExternalEvaluatorData> {
  Future<void> deleteDocumentAndUser(
      String documentId, String email, String password) async {
    try {
      // Delete document from "External" collection
      await FirebaseFirestore.instance
          .collection('External')
          .doc('accounts')
          .collection('Evaluators')
          .doc(documentId)
          .delete();

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('$error'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
            // Handle error as needed
          });
    }
  }

//---------------------------------- CSV Upload and Create Accounts --------------------------- //

  String? _csvFileName;
  List<List<dynamic>> _csvData = [];

  void _importCSV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      PlatformFile file = result.files.single;
      _csvFileName = file.name;

      String csvString = String.fromCharCodes(file.bytes!);

      CsvToListConverter().convert(csvString).forEach((row) {
        _csvData.add(row);
      });

      _showUploadSuccessDialog();
    }
  }

  void _showUploadSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('CSV Uploaded'),
        content: Text('File: $_csvFileName'),
        actions: [
          ElevatedButton(
            onPressed: () {
              _createAccountsAndStoreData();
              Navigator.of(context).pop();
            },
            child: Text('Create Accounts'),
          ),
        ],
      ),
    );
  }

  String _generateRandomPassword() {
    return randomAlphaNumeric(10);
  }

  void _createAccountsAndStoreData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference accountsCollection =
        FirebaseFirestore.instance.collection('/External/accounts/Evaluators');

    for (var i = 1; i < _csvData.length; i++) {
      String name = _csvData[i][1];
      String email = _csvData[i][2];
      String affiliation = _csvData[i][3];
      String password = _generateRandomPassword();

      try {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final accountData = {
          'Name': name,
          'Email': email,
          'Password': password,
          'Affiliation': affiliation,
          'userid': userCredential.user!.uid,
        };

        await accountsCollection.add(accountData);
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'email-already-in-use') {
          errorMessage = 'An account with this email already exists.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Please enter a valid email address.';
        } else {
          errorMessage = 'Account creation failed. Please try again later.';
        }

        // Account creation error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('External Evaluators',
                              style: GoogleFonts.roboto(
                                  fontSize: 24, fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MyFormDialog();
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    // backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          3.0), // Adjust the border radius as needed
                                      side: BorderSide(
                                          color: Colors
                                              .blue), // Set the border color
                                    ),
                                  ),
                                  child: Text(
                                    'Add New',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                  onPressed: _importCSV,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          3.0), // Adjust the border radius as needed
                                      side: BorderSide(
                                          color: Colors
                                              .blue), // Set the border color
                                    ),
                                  ),
                                  child: Text(
                                    'Import',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                              onPressed: createExcel,
                              icon: Icon(Icons.local_print_shop),
                              label: Text('Print'))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('External')
                            .doc('accounts')
                            .collection('Evaluators')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!.docs;
                            if (data.isEmpty) {
                              return Container(
                                height: 200,
                                child: Center(
                                  child: Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue[200]),
                                    child: Center(
                                      child: Text('No Account is created yet',
                                          style: GoogleFonts.openSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return DataTable(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(214, 214, 214, 1)),
                                ),
                                dataRowHeight: 60,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'Sr#',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Name',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Affiliation',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Email',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Delete',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ],
                                rows: data.asMap().entries.map((entry) {
                                  final index = entry.key + 1;
                                  final account = entry.value;
                                  final rowIndex = entry.key;
                                  final isEvenRow = rowIndex % 2 == 0;
                                  final backgroundColor = isEvenRow
                                      ? Colors.white
                                      : Colors.grey.shade200;

                                  return DataRow(
                                      color: MaterialStateColor.resolveWith(
                                          (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.08);
                                        } else if (states
                                            .contains(MaterialState.hovered)) {
                                          return Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.04);
                                        }
                                        return backgroundColor;
                                      }),
                                      cells: [
                                        DataCell(Text(index.toString())),
                                        DataCell(Text(account['Name'])),
                                        DataCell(Text(account['Affiliation'])),
                                        DataCell(Text(account['Email'])),
                                        DataCell(IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red[600],
                                          ),
                                          onPressed: () {
                                            deleteDocumentAndUser(
                                                account.id,
                                                account['Email'],
                                                account['Password']);
                                          },
                                        )),
                                      ]);
                                }).toList(),
                              );
                            }
                          } else {
                            return Center(child: Text('No data found.'));
                          }
                        },
                      ),
                    ]))));
  }

  static Future<void> createExcel() async {
    final evenColor = "#9CC2E5";
    final oddColor = "#FFFFFF";

    final QuerySnapshot<Object?> querySnapshot = await FirebaseFirestore
        .instance
        .collection('External')
        .doc('accounts')
        .collection('Evaluators')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final List<DocumentSnapshot<Object?>> supervisorDocuments =
          querySnapshot.docs;

      final ios.Workbook workbook = ios.Workbook();
      final ios.Worksheet sheet = workbook.worksheets[0];
      int rowIndex = 2; // Start from row 6

      for (int i = 0; i < supervisorDocuments.length; i++) {
        final DocumentSnapshot<Object?> supervisorDocument =
            supervisorDocuments[i];
        Map<String, dynamic>? supervisorData =
            supervisorDocument.data() as Map<String, dynamic>?;

        if (supervisorData != null) {
          ios.Range range = sheet.getRangeByName('A$rowIndex:E$rowIndex');

          range.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;

          ios.Range range2 =
              sheet.getRangeByName('A${rowIndex + 1}:E${rowIndex + 1}');

          range2.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;

          ios.Range range3 =
              sheet.getRangeByName('A${rowIndex + 2}:E${rowIndex + 2}');

          range3.cellStyle.borders.all.lineStyle = ios.LineStyle.thin;

          // range.cellStyle.borders.all.color = '#0000000';

          if (rowIndex % 2 == 0) {
            sheet.getRangeByName('A$rowIndex:E$rowIndex').cellStyle.backColor =
                evenColor;
          } else {
            sheet.getRangeByName('A$rowIndex:E$rowIndex').cellStyle.backColor =
                oddColor;
          }

          if (rowIndex % 2 == 0) {
            sheet
                .getRangeByName('A${rowIndex + 1}:E${rowIndex + 1}')
                .cellStyle
                .backColor = evenColor;
          } else {
            sheet
                .getRangeByName('A${rowIndex + 1}:E${rowIndex + 1}')
                .cellStyle
                .backColor = oddColor;
          }

          if (rowIndex % 2 == 0) {
            sheet
                .getRangeByName('A${rowIndex + 2}:E${rowIndex + 2}')
                .cellStyle
                .backColor = evenColor;
          } else {
            sheet
                .getRangeByName('A${rowIndex + 2}:E${rowIndex + 2}')
                .cellStyle
                .backColor = oddColor;
          }

          // Set data from supervisorData in Excel cells
          sheet.getRangeByName('A$rowIndex').setText((i + 1).toString());
          sheet.getRangeByName('B$rowIndex').setText(supervisorData['Name']);
          sheet
              .getRangeByName('C$rowIndex')
              .setText(supervisorData['Affiliation']);
          sheet.getRangeByName('D$rowIndex').setText(supervisorData['Email']);
          sheet
              .getRangeByName('E$rowIndex')
              .setText(supervisorData['Password']);

          rowIndex += 1; // Increment row index for the next set of data
        }
      }

// -------------------------------------------- Reg No ------------------------------ //

      sheet.getRangeByName('A1').setText('Sr#');
      sheet.getRangeByName('A1').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('A1').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('A1').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('A1').cellStyle.vAlign = ios.VAlignType.center;

      sheet.getRangeByName('A1').cellStyle.bold = true;
      sheet.getRangeByName('A1').cellStyle.fontSize = 12;

// -------------------------------------------- Name ------------------------------ //
      sheet.getRangeByName('B1').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('B1').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('B1').merge();
      sheet.getRangeByName('B1').setText('Name');
      sheet.getRangeByName('B1').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('B1').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('B1').columnWidth = 40;
      sheet.getRangeByName('B1').cellStyle.bold = true;
      sheet.getRangeByName('B1').cellStyle.fontSize = 12;

// -------------------------------------------- MARKS ------------------------------ //

      sheet.getRangeByName('C1').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('C1').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('C1').setText('Affiliation');
      sheet.getRangeByName('C1').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('C1').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('C1').columnWidth = 22;
      sheet.getRangeByName('C1').cellStyle.bold = true;
      sheet.getRangeByName('C1').cellStyle.fontSize = 12;

// -------------------------------------------- Co Supervisor ------------------------------ //

      sheet.getRangeByName('D1').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('D1').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('D1').setText('Email');
      sheet.getRangeByName('D1').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('D1').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('D1').cellStyle.bold = true;
      sheet.getRangeByName('D1').cellStyle.fontSize = 12;
      sheet.getRangeByName('D1').columnWidth = 22;

// -------------------------------------------- Group Members ------------------------------ //

      sheet.getRangeByName('E1').cellStyle.backColor = '#4472C4';
      sheet.getRangeByName('E1').cellStyle.fontColor = '#ffffff';
      sheet.getRangeByName('E1').setText('Password');
      sheet.getRangeByName('E1').cellStyle.hAlign = ios.HAlignType.center;
      sheet.getRangeByName('E1').cellStyle.vAlign = ios.VAlignType.center;
      sheet.getRangeByName('E1').cellStyle.bold = true;
      sheet.getRangeByName('E1').columnWidth = 23;
      sheet.getRangeByName('E1').cellStyle.fontSize = 12;

// -------------------------------------------- Set Data ------------------------------ //

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      if (kIsWeb) {
        AnchorElement(
            href:
                'data:application/octet-stream;charset=utf-16le;base64, ${base64.encode(bytes)}')
          ..setAttribute('download', 'External-Account-Details.xlsx')
          ..click();
      } else {
        final String path = (await getApplicationDocumentsDirectory()).path;
        final String fileName = '$path/Results.xlsx';

        final io.File file = io.File(fileName);

        await file.writeAsBytes(bytes, flush: true);

        OpenFile.open(fileName);
      }
    }
  }
}

class MyFormDialog extends StatefulWidget {
  @override
  _MyFormDialogState createState() => _MyFormDialogState();
}

class _MyFormDialogState extends State<MyFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _autoGeneratePassword = false;

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _generateRandomPassword() {
    const chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#\$&";
    Random rnd = Random();
    String password = "";
    int passwordLength = 8 + rnd.nextInt(3); // Random length between 8 and 10

    for (int i = 0; i < passwordLength; i++) {
      password += chars[rnd.nextInt(chars.length)];
    }

    return password;
  }

  void _toggleAutoGeneratePassword(bool? value) {
    setState(() {
      _autoGeneratePassword = value ?? false;
      if (_autoGeneratePassword) {
        _passwordController.text = _generateRandomPassword();
      }
    });
  }

  bool _showPassword = false;

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _regeneratePassword() {
    setState(() {
      _passwordController.text = _generateRandomPassword();
    });
  }

  void _clearForm() {
    setState(() {
      _nameController.clear();
      _designationController.clear();
      _emailController.clear();
      _passwordController.clear();
      _formKey.currentState?.reset();
    });
  }

  void _pasteEmail() {
    String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      List<String> nameParts = name.split(' ');
      String firstName = nameParts[0].toLowerCase();
      String email = '$firstName@ntu.edu.pk';
      setState(() {
        _emailController.text = email;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, submit the form
      // Perform your form submission logic here
      String name = _nameController.text;
      String designation = _designationController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        // Create Firebase account
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        final accountData = {
          'Name': name,
          'Email': email,
          'Password': password,
          'Affiliation': designation,
          "userid": userCredential.user!.uid
        };
        await FirebaseFirestore.instance
            .collection('External')
            .doc('accounts')
            .collection('Evaluators')
            .add(accountData);
        // Account creation successful
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Account created successfully!'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    // Perform any further actions or navigate to the next screen
                  },
                ),
              ],
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'email-already-in-use') {
          errorMessage = 'An account with this email already exists.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Please enter a valid email address.';
        } else {
          errorMessage = 'Account creation failed. Please try again later.';
        }

        // Account creation error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: AlertDialog(
        title: Text(
          'Add External Evaluators',
          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        content: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _designationController,
                  decoration: InputDecoration(
                    labelText: 'Affiliation',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Affiliation';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.content_paste),
                      onPressed: _pasteEmail,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email';
                    }
                    if (!RegExp(r'^\w+@ntu\.edu\.pk$').hasMatch(value)) {
                      return 'Please enter a valid email address (e.g., name@ntu.edu.pk)';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return 'Password must contain at least one digit';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _autoGeneratePassword,
                      onChanged: _toggleAutoGeneratePassword,
                    ),
                    Text('Auto Generate Password'),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 18)),
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
              SizedBox(
                width: 15,
              ),
              TextButton(
                onPressed: _clearForm,
                child: Text('Clear'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
