// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyGroup extends StatefulWidget {
  @override
  State<MyGroup> createState() => _MyGroupState();
}

class _MyGroupState extends State<MyGroup> {
  bool _isclicked = true;
  bool _isgroupclicked = true;
  bool _issupervisorclicked = true;
  // Generate sample items
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(13),
            width: double.infinity,
            padding: EdgeInsets.all(13),
            // color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0 * 0.75),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SvgPicture.asset(
                        'assets/student-person-3-svgrepo-com.svg',
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('BSIT 2019 - 2023',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w600)),
                        Text('Department of Computer Science',
                            style: Theme.of(context).textTheme.bodyLarge)
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Group Id',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          child: Text('23-FYP-304'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.withOpacity(0.1),
                          ),
                        )),
                    SizedBox(
                      width: 70,
                    ),
                    Expanded(
                      child: Text('Project Title',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        child: Expanded(child: Text('FYP Management Portal')),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    TextButton.icon(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () {
                          setState(() {
                            _isclicked = !_isclicked;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.black,
                        ),
                        label: Text(
                          'You',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _isclicked,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white,
                    child: DataTable(
                      columnSpacing: 20, // Adjust the spacing between columns
                      horizontalMargin: 10, // Adjust the horizontal margin
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Registartion No'),
                        ),
                        DataColumn(
                          label: Text('Role'),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      color: Colors.blue,
                                      child: Text(
                                        'ZJ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Add some spacing between the first letter and the full name
                                  Expanded(child: Text('Zeeshan javed'))
                                ],
                              ),
                            ),
                            DataCell(Text('19-NTU-CS-1172')),
                            DataCell(Text('Team Lead')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    TextButton.icon(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () {
                          setState(() {
                            _isgroupclicked = !_isgroupclicked;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.black,
                        ),
                        label: Text(
                          'Members',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _isgroupclicked,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white,
                    child: DataTable(
                      columnSpacing: 20, // Adjust the spacing between columns
                      horizontalMargin: 10, // Adjust the horizontal margin
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Registartion No'),
                        ),
                        DataColumn(
                          label: Text('Role'),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      color: Colors.blue,
                                      child: Text(
                                        'AA',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Add some spacing between the first letter and the full name
                                  Expanded(child: Text('Alina Arshad'))
                                ],
                              ),
                            ),
                            DataCell(Text('19-NTU-CS-1136')),
                            DataCell(Text('Member')),
                          ],
                        ),
                        // Add more DataRow widgets for additional rows
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      color: Colors.blue,
                                      child: Text(
                                        'MZ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                      width:
                                          8), // Add some spacing between the first letter and the full name
                                  Expanded(child: Text('Muhammad Zohran'))
                                ],
                              ),
                            ),
                            DataCell(Text('19-NTU-CS-1159')),
                            DataCell(Text('Member')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    TextButton.icon(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () {
                          setState(() {
                            _issupervisorclicked = !_issupervisorclicked;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.black,
                        ),
                        label: Text(
                          'Supervisors',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _issupervisorclicked,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white,
                    child: DataTable(
                      columnSpacing: 20, // Adjust the spacing between columns
                      horizontalMargin: 10, // Adjust the horizontal margin
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Designation'),
                        ),
                        DataColumn(
                          label: Text('Role'),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      color: Colors.blue,
                                      child: Text(
                                        'WA',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Add some spacing between the first letter and the full name
                                  Expanded(child: Text('Mr. Waqar Ahmad'))
                                ],
                              ),
                            ),
                            DataCell(Text('Assistant Professor')),
                            DataCell(Text('Main Supervisor')),
                          ],
                        ),
                        // Add more DataRow widgets for additional rows
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      color: Colors.blue,
                                      child: Text(
                                        'SS',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                      width:
                                          8), // Add some spacing between the first letter and the full name
                                  Expanded(child: Text('Mr Shahbaz Ahmad Sahi'))
                                ],
                              ),
                            ),
                            DataCell(Text('Lecturer')),
                            DataCell(Text('Co-Supervisor')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      )),
    );
  }
}
