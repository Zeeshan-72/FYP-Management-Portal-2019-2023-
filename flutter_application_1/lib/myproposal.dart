// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/DemoProposal.dart';
// ignore: unused_import
import 'package:flutter_application_1/convenor_screens/supervisor_dashboard.dart';
import 'package:flutter_application_1/student_screens/member_form.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart';

import 'package:flutter/material.dart';

class FYPManagementWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 16.0,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 139, 77, 53),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              ('Proposal 1'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Text(
                          'Design of appliance for real time fabric defect detection',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Approval Status',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              ('Accepted'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Edit'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Read'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Update'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Print'),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 16.0,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 139, 77, 53),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              ('Proposal 2'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Text(
                          'Some Random Proposal',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Approval Status',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              ('Rejected'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Edit'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Read'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Update'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Print'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Person {
  final String name;
  final int age;
  final String email;

  Person({required this.name, required this.age, required this.email});
}

class SearchableTable extends StatefulWidget {
  @override
  _SearchableTableState createState() => _SearchableTableState();
}

class _SearchableTableState extends State<SearchableTable> {
  String _selectedStatus = '';
  List<DataRow> _dataRows = [
    DataRow(
      cells: [
        DataCell(Text(
          '1',
          style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
        )),
        DataCell(Text(
          'FYP Management Portal',
          style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
        )),
        DataCell(Text(
          '23-Feb-2023',
          style: GoogleFonts.openSans(),
        )),
        DataCell(Container(

            // padding: EdgeInsets.all(10.0 * 0.75),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Theme(
              data: ThemeData(
                hoverColor: Colors.transparent,
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.description_rounded,
                    size: 20,
                  ),
                  color: Colors.blue),
            ))),
        DataCell(Container(

            // padding: EdgeInsets.all(10.0 * 0.75),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Color(0xFFFFA113).withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Theme(
              data: ThemeData(hoverColor: Colors.transparent),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: 20,
                ),
                color: Color(0xFFFFA113),
              ),
            ))),
        DataCell(Container(

            // padding: EdgeInsets.all(10.0 * 0.75),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Color(0xFF007EE5).withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Theme(
              data: ThemeData(hoverColor: Colors.transparent),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.picture_as_pdf,
                  size: 20,
                ),
                color: Color(0xFF007EE5),
              ),
            ))),
        DataCell(
          Container(
            width: 90,
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2)),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                ('Approved'),
                style: GoogleFonts.openSans(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    ),
    DataRow(
      cells: [
        DataCell(Text(
          '2',
          style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
        )),
        DataCell(
          Text(
            'Clinic X',
            style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
          ),
        ),
        DataCell(Text(
          '23-Feb-2023',
          style: GoogleFonts.openSans(),
        )),
        DataCell(Container(

            // padding: EdgeInsets.all(10.0 * 0.75),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Theme(
              data: ThemeData(
                hoverColor:
                    Colors.transparent, // Set hover color to transparent
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.description_rounded,
                    size: 20,
                  ),
                  color: Colors.blue),
            ))),
        DataCell(Container(

            // padding: EdgeInsets.all(10.0 * 0.75),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Color(0xFFFFA113).withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Theme(
              data: ThemeData(hoverColor: Colors.transparent),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: 20,
                ),
                color: Color(0xFFFFA113),
              ),
            ))),
        DataCell(Container(

            // padding: EdgeInsets.all(10.0 * 0.75),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Color(0xFF007EE5).withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Theme(
              data: ThemeData(hoverColor: Colors.transparent),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.picture_as_pdf,
                  size: 20,
                ),
                color: Color(0xFF007EE5),
              ),
            ))),
        DataCell(
          Container(
            width: 85,
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2)),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                ('Rejected'),
                style: GoogleFonts.openSans(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    ),
    DataRow(
      cells: [
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ],
    ),
    DataRow(
      cells: [
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ],
    ),
  ];

  List<DataRow> _filteredRows = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredRows = _dataRows;
  }

  void _filterRows(String searchTerm) {
    setState(() {
      _filteredRows = _dataRows.where((row) {
        final cellsText = row.cells
            .map((cell) => cell.child.toString().toLowerCase())
            .toList();
        return cellsText.any((text) => text.contains(searchTerm.toLowerCase()));
      }).toList();
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _filteredRows = _dataRows;
    });
  }

  void _filterByStatus(String status) {
    setState(() {
      _selectedStatus = status;
      if (status.isEmpty) {
        _filteredRows = _dataRows;
      } else {
        _filteredRows = _dataRows.where((row) {
          final statusCellText = row.cells[6].child.toString().toLowerCase();
          return statusCellText.contains(status.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(13),
          width: double.infinity,
          padding: EdgeInsets.all(13),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0 * 0.75),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SvgPicture.asset(
                      'assets/clipboard.svg',
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('My Proposals',
                          style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontSize: 24,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('23-FYP-304',
                          style: Theme.of(context).textTheme.bodyLarge)
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 500,
                color: Colors.white,
                // margin: EdgeInsets.symmetric(horizontal: 13, vertical: 16),
                padding: EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: 400,
                              child: TextField(
                                controller: _searchController,
                                onChanged: _filterRows,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  labelText: 'Search',
                                  prefixIcon: Icon(Icons.search),
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: _clearSearch,
                                        )
                                      : null,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 13),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 14.0,
                                ),
                              ),
                              onPressed: () {
                                setState(() {});

                                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                //   content: Text('PDF generated and saved'),
                                // ));
                                // _multipage();
                              },
                              icon: Icon(Icons.add),
                              label: Text("Add New"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: ScrollController(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: 1020,
                            child: DataTable(
                              dataRowHeight: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 238, 238, 238),
                                    width: 1.0),
                              ),
                              columns: [
                                DataColumn(
                                    label: Text(
                                  'Sr#',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Title',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                  label: Text(
                                    'Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                    label: Text(
                                  'Read',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Edit',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Print',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Status',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ],
                              rows: _filteredRows.asMap().entries.map((entry) {
                                final index = entry.key;
                                final dataRow = entry.value;
                                final isOddRow = index % 2 == 1;
                                final color =
                                    isOddRow ? Colors.grey[200]! : Colors.white;
                                return DataRow(
                                  color: MaterialStateColor.resolveWith(
                                      (states) => color),
                                  cells: dataRow.cells,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyProposal extends StatefulWidget {
  @override
  State<MyProposal> createState() => _MyProposalState();
}

class _MyProposalState extends State<MyProposal> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  List Zeeshan = [];

  var _supervisor;

  var _cosupervisor;
  var id;
  var storedocs;
  var _groupid1;

  // String get _groupid => dataaa();

  bool button1 = true;
  bool button2 = false;

  var shoaib;
  bool isEnabled = true;

  void enableElevatedButton() {
    if (shoaib['convenor-approval'] == 'abc') {
      setState() {
        isEnabled = true;
      }
    } else {
      setState() {
        isEnabled = false;
      }
    }
  }

  void _button1() {
    setState(() {
      button1 = false;
      button2 = true;
    });
  }

  void _button2() {
    setState(() {
      button1 = true;
      button2 = false;
    });
  }

  _getgroupid() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                '/Convenor/classes/BS Information Technology/groups/group-members')
            .where('fyp-id', isEqualTo: '23-FYP-304')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return const Center(child: Text('null'));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot groupid = snapshot.data!.docs[index];

              _groupid1 = groupid.id;

              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                storedocs = a;
                a['id'] = document.id;
              });

              if (snapshot.hasData) {
                return const Text('nukll');
              }

              return const Text('null');
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 232, 242, 244),
      body: StreamBuilder(
          stream:
              // FirebaseFirestore.instance
              //     .collection(
              //         '/Convenor/classes/BS Information Technology/groups/group-members')
              //     .where('fyp-id', isEqualTo: '23-FYP-307')
              //     .snapshots(),
              FirebaseFirestore.instance
                  .collection('FYP')
                  .doc('fyp(19-23)')
                  .collection('groups')
                  .doc(firebaseUser!.uid)
                  .collection('members')
                  .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data?.size == 0) {
              return Center(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
                width: 600,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Group is not created yet",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Click here to Submit"),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemberForm(),
                                ));

                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => const DemoProposal()));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 20),
                              textStyle: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          child: const Text('Submit Now'),
                        )
                      ],
                    )
                  ],
                ),
              ));
            }

            return Column(
              children: [
                // FYPManagementWidget(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];

                      if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 28, horizontal: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 179, 51, 51),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        document["group-id"],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Divider(
                                  height: 10,
                                  thickness: 5,
                                  color: Color.fromARGB(255, 57, 120, 125),
                                ),
                                getgroupinfo(document['group-id'])
                                // grpinfo(),

                                // firstproposal(document.id, document),
                                // secondproposal(document.id, document),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Text('null');
                    }),
              ],
            );
          }),
    );
  }

  getgroupinfo(String value) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                '/Convenor/classes/BS Information Technology/groups/group-members')
            .where('fyp-id', isEqualTo: value)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return Center(
                child: Container(
              margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
              width: 600,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Group is not submitted yet",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Click here to Submit"),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MemberForm(),
                              ));

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const DemoProposal()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 57, 120, 125),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 20),
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        child: const Text('Submit Now'),
                      )
                    ],
                  )
                ],
              ),
            ));
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];

                if (snapshot.hasData) {
                  return Column(
                    children: [
                      proposal1(document.id, document),
                      proposal2(document.id, document)
                    ],
                  );
                }
                return const Text('null');
              });
        });
  }

  getfeedbackinfo(String path, String prodoc1, var db) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(path)
            .doc(prodoc1)
            .collection('convenor-feedback')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "No feedback",
                      style: TextStyle(fontSize: 24),
                    ),
                  ]),
            );
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];

                if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Feedback',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(document['feedback'])
                      ],
                    ),
                  );
                }
                return const Text('null');
              });
        });
  }

  proposal1(String groupid, var groupsnapshot) {
    String topic = 'Main Topic Details';

    String path =
        '/Convenor/classes/BS Information Technology/groups/group-members/$groupid/proposals/proposals/proposal1';

    String prodoc = '';
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Convenor')
            .doc('classes')
            .collection('BS Information Technology')
            .doc('groups')
            .collection('group-members')
            .doc(groupid)
            .collection('proposals')
            .doc('proposals')
            .collection('proposal1')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return Center(
                child: Container(
              margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
              width: 600,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No proposals submitted yet",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Click here to Submit"),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DemoProposal(),
                              ));

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const DemoProposal()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 20),
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        child: const Text('Submit Now'),
                      )
                    ],
                  )
                ],
              ),
            ));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot db = snapshot.data!.docs[index];
              // shoaib = db;
              prodoc = db.id;

              if (snapshot.hasData) {
                return Container(
                  // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 139, 77, 53),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          ('Proposal 1'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      db["project-title"],
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Approval Status: ',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 180, 34, 34),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Text(
                                            db['convenor-approval'],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                // ElevatedButton(
                                //     onPressed: () {
                                //       showDialog(
                                //         context: context,
                                //         builder: (BuildContext context) =>
                                //             LayoutBuilder(
                                //           builder: (context, constraints) =>
                                //               const SimpleDialog(
                                //             contentPadding: EdgeInsets.all(15),
                                //             title:
                                //                 Text('Your feedback is here'),
                                //             children: [
                                //               Text('feedback')
                                //               // getfeedbackinfo(path, prodoc, db),
                                //             ],
                                //           ),
                                //         ),
                                //       );

                                //       // print(_groupid2);
                                //       // print(_groupid);

                                //       // showDialog(
                                //       //     context: context,
                                //       //     builder: (ctx) => Container(
                                //       //             child: AlertDialog(
                                //       //           insetPadding:
                                //       //               const EdgeInsets.symmetric(
                                //       //                   horizontal: 200,
                                //       //                   vertical: 20),
                                //       //           scrollable: true,
                                //       //           shape:
                                //       //               const RoundedRectangleBorder(
                                //       //                   borderRadius:
                                //       //                       BorderRadius.all(
                                //       //                           Radius.circular(
                                //       //                               20.0))),
                                //       //           content: SingleChildScrollView(
                                //       //             child: Container(
                                //       //               // width: double.infinity,
                                //       //               child:
                                //       //                   SingleChildScrollView(
                                //       //                 child: Column(
                                //       //                   children: <Widget>[
                                //       //                     getfeedbackinfo(
                                //       //                         path, prodoc, db),
                                //       //                     Text('Zeeshan'),
                                //       //                   ],
                                //       //                 ),
                                //       //               ),
                                //       //             ),
                                //       //           ),
                                //       //         )));
                                //     },
                                //     style: ElevatedButton.styleFrom(
                                //         primary: const Color.fromARGB(
                                //             255, 94, 84, 84),
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 25, vertical: 15),
                                //         textStyle: const TextStyle(
                                //           fontSize: 15,
                                //         )),
                                //     child: const Text('Feedback')),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      // print(_groupid2);
                                      // print(_groupid);

                                      showDialog(
                                          context: context,
                                          builder: (ctx) => Container(
                                                  child: AlertDialog(
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 200,
                                                        vertical: 20),
                                                scrollable: true,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                content: SingleChildScrollView(
                                                  child: Container(
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: <Widget>[
                                                          _readproposal1(
                                                              db,
                                                              groupsnapshot,
                                                              topic),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 39, 62, 187),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: const Text('Read')),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      // print(_groupid2);
                                      // print(_groupid);

                                      showDialog(
                                          context: context,
                                          builder: (ctx) => Container(
                                                  child: AlertDialog(
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 200,
                                                        vertical: 20),
                                                scrollable: true,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                content: SingleChildScrollView(
                                                  child: Container(
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: <Widget>[
                                                          _updateproposal1(
                                                              db,
                                                              groupsnapshot,
                                                              topic,
                                                              prodoc,
                                                              path),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            255, 94, 84, 84),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: const Text('Edit')),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _multipage(db, groupsnapshot, topic);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: const Text('Print')),
                              ],
                            ),
                          ],
                        ),
                        // getfeedbackinfo(path, prodoc, db),
                      ],
                    ),
                  ),
                );
              }

              return const Text('null');
            },
          );
        });
  }

  proposal2(String groupid, var groupsnapshot) {
    String topic = 'Main Topic Details';

    String path2 =
        '/Convenor/classes/BS Information Technology/groups/group-members/$groupid/proposals/proposals/proposal2';

    String prodoc = '';
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Convenor')
            .doc('classes')
            .collection('BS Information Technology')
            .doc('groups')
            .collection('group-members')
            .doc(groupid)
            .collection('proposals')
            .doc('proposals')
            .collection('proposal2')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // else if (snapshot.data?.size == 0) {
          //   return Center(
          //       child: Container(
          //     margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
          //     width: 600,
          //     height: 300,
          //     decoration: BoxDecoration(
          //         color: Colors.grey[200],
          //         borderRadius: BorderRadius.circular(20)),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         const Text(
          //           "No proposals submitted yet",
          //           style: TextStyle(fontSize: 24),
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         const Text("Click here to Submit"),
          //         const SizedBox(
          //           height: 50,
          //         ),
          //         Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             ElevatedButton(
          //               onPressed: () {
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) => const DemoProposal(),
          //                     ));

          //                 Navigator.of(context).push(MaterialPageRoute(
          //                     builder: (context) => const DemoProposal()));
          //               },
          //               style: ElevatedButton.styleFrom(
          //                   primary: const Color.fromARGB(255, 57, 120, 125),
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 60, vertical: 20),
          //                   textStyle: const TextStyle(
          //                       fontSize: 15, fontWeight: FontWeight.bold)),
          //               child: const Text('Submit Now'),
          //             )
          //           ],
          //         )
          //       ],
          //     ),
          //   ));
          // }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot db = snapshot.data!.docs[index];
              // shoaib = db;
              prodoc = db.id;

              if (snapshot.hasData) {
                return Container(
                  // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 139, 77, 53),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          ('Proposal 2'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      db["project-title"],
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Approval Status: ',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 180, 34, 34),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Text(
                                            db['convenor-approval'],
                                            // 'Accepted with Edits',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                // ElevatedButton(
                                //     onPressed: () {
                                //       showDialog(
                                //         context: context,
                                //         builder: (BuildContext context) =>
                                //             LayoutBuilder(
                                //           builder: (context, constraints) =>
                                //               const SimpleDialog(
                                //             contentPadding: EdgeInsets.all(15),
                                //             title:
                                //                 Text('Your feedback is here'),
                                //             children: [
                                //               Text('feedback')
                                //               // getfeedbackinfo(path, prodoc, db),
                                //             ],
                                //           ),
                                //         ),
                                //       );

                                //       // print(_groupid2);
                                //       // print(_groupid);

                                //       // showDialog(
                                //       //     context: context,
                                //       //     builder: (ctx) => Container(
                                //       //             child: AlertDialog(
                                //       //           insetPadding:
                                //       //               const EdgeInsets.symmetric(
                                //       //                   horizontal: 200,
                                //       //                   vertical: 20),
                                //       //           scrollable: true,
                                //       //           shape:
                                //       //               const RoundedRectangleBorder(
                                //       //                   borderRadius:
                                //       //                       BorderRadius.all(
                                //       //                           Radius.circular(
                                //       //                               20.0))),
                                //       //           content: SingleChildScrollView(
                                //       //             child: Container(
                                //       //               // width: double.infinity,
                                //       //               child:
                                //       //                   SingleChildScrollView(
                                //       //                 child: Column(
                                //       //                   children: <Widget>[
                                //       //                     getfeedbackinfo(
                                //       //                         path, prodoc, db),
                                //       //                     Text('Zeeshan'),
                                //       //                   ],
                                //       //                 ),
                                //       //               ),
                                //       //             ),
                                //       //           ),
                                //       //         )));
                                //     },
                                //     style: ElevatedButton.styleFrom(
                                //         primary: const Color.fromARGB(
                                //             255, 94, 84, 84),
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 25, vertical: 15),
                                //         textStyle: const TextStyle(
                                //           fontSize: 15,
                                //         )),
                                //     child: const Text('Feedback')),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      // print(_groupid2);
                                      // print(_groupid);

                                      showDialog(
                                          context: context,
                                          builder: (ctx) => Container(
                                                  child: AlertDialog(
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 200,
                                                        vertical: 20),
                                                scrollable: true,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                content: SingleChildScrollView(
                                                  child: Container(
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: <Widget>[
                                                          _readproposal1(
                                                              db,
                                                              groupsnapshot,
                                                              topic),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 39, 62, 187),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: const Text('Read')),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      // print(_groupid2);
                                      // print(_groupid);

                                      showDialog(
                                          context: context,
                                          builder: (ctx) => Container(
                                                  child: AlertDialog(
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 200,
                                                        vertical: 20),
                                                scrollable: true,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                content: SingleChildScrollView(
                                                  child: Container(
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: <Widget>[
                                                          _updateproposal1(
                                                              db,
                                                              groupsnapshot,
                                                              topic,
                                                              prodoc,
                                                              path2),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            255, 94, 84, 84),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: const Text('Edit')),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _multipage(db, groupsnapshot, topic);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    child: const Text('Print')),
                              ],
                            ),
                          ],
                        ),
                        // getfeedbackinfo(path2, prodoc, db),
                      ],
                    ),
                  ),
                );
              }

              return const Text('null');
            },
          );
        });
  }

  _feedback1(String path, String prodoc1, var db) {
    String feedback1 = '';
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(path)
            .doc(prodoc1)
            .collection('convenor-feedback')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return Center(
                child: Container(
              margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
              width: 600,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "No Feedback",
                      style: TextStyle(fontSize: 24),
                    ),
                  ]),
            ));
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot feedback = snapshot.data!.docs[index];

                // prodoc2 = db.id;

                if (snapshot.hasData) {
                  return SafeArea(
                      child: Column(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(db['project-title']),
                          // Text(feedback['feedback']),
                        ],
                      ),
                    )
                  ]));
                }
                return const Text('null');
              });
        });
  }

  _updateproposal1(
      var snap, var value2, String topic, String prodoc, String path) {
    var sample = value2;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final _group_id = TextEditingController();
    final _project_title = TextEditingController();

    final _industrialpartnerController1 = TextEditingController();
    final _problemstatementController1 = TextEditingController();
    final _objectivesController1 = TextEditingController();
    final _probbackgroundController1 = TextEditingController();
    final _proposedsolutionController1 = TextEditingController();
    final _relatedtechnologiesController1 = TextEditingController();

    final _proposedtoolsController1 = TextEditingController();
    final _proposedmethodogiesController1 = TextEditingController();
    final _projectrationaleController1 = TextEditingController();
    final _scheduleController1 = TextEditingController();

    _group_id.value = TextEditingValue(text: snap['group-id']);
    _project_title.value = TextEditingValue(text: snap['project-title']);

    _industrialpartnerController1.value =
        TextEditingValue(text: snap['industrial-partner']);

    _problemstatementController1.value =
        TextEditingValue(text: snap['problem-statement']);

    _objectivesController1.value = TextEditingValue(text: snap['objectives']);

    _probbackgroundController1.value =
        TextEditingValue(text: snap['problem-background']);

    _proposedsolutionController1.value =
        TextEditingValue(text: snap['proposed-solution']);

    _relatedtechnologiesController1.value =
        TextEditingValue(text: snap['related-technologies']);

    _proposedtoolsController1.value =
        TextEditingValue(text: snap['proposed-tools']);

    _proposedmethodogiesController1.value =
        TextEditingValue(text: snap['proposed-methodology']);

    _projectrationaleController1.value =
        TextEditingValue(text: snap['project-rationale']);

    _scheduleController1.value = TextEditingValue(text: snap['schedule']);

    return SafeArea(
        child: Column(children: [
      SingleChildScrollView(
          child: Column(children: [
        Container(),
        Container(
            width: 1400,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 28, horizontal: 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 57, 120, 125),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 45,
                                  ),
                                  Text(
                                    'BSIT FYP Proposal Submission',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "* Required ",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            "Group Details",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromARGB(
                                                  255, 57, 120, 125),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            '1.Group Id *',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Container(
                                              height: 50,
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  // maxLength: 5,
                                                  maxLines: 1,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller: _group_id,
                                                  // controller: _groupidController,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          const Text(
                                            "Main Topic Details",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromARGB(
                                                  255, 57, 120, 125),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            '2. Project Title *',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            child: Text(
                                              'Enter 8-15 words project title.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Container(
                                              height: 50,
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  // maxLength: 5,
                                                  maxLines: 1,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller: _project_title,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 90,
                                          ),
                                          const Text(
                                              '5. Describe the industrial partner *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            child: Text(
                                              'In case of industrial partner, please provide the details (name, address, and contact details) of industrial partner.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Container(
                                              height: 80,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: null,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      _industrialpartnerController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 90,
                                          ),
                                          const Text('6. Problem statement *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            child: Text(
                                              'Clear state the problem statement in 1-4 lines.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Container(
                                              // height: 90,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 5,
                                                  maxLines: 10,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  controller:
                                                      _problemstatementController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 90,
                                          ),
                                          const Text('7. Objectives *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            child: Text(
                                              'Clearly state 1-3 measurable objectives. Each object must start with "To".',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 3,
                                                  maxLines: 10,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      _objectivesController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 90,
                                          ),
                                          const Text(
                                              '8. Introduction and background of the problem *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            child: Text(
                                              'Concisely (5-10 lines) highlight the significance, background, and related work of the highlighted problem.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 5,
                                                  maxLines: 10,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      _probbackgroundController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                              '9. Proposed solution / Methodology *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 16.0),
                                            child: Text(
                                              'Briefly describe the proposed solution to problem. You may use the diagram to depict the proposed solution.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 5,
                                                  maxLines: 10,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      _proposedsolutionController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                              '10. Proposed tools and technologies *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 22.0),
                                            child: Text(
                                              'Write down possible tools, languages, databases, etc. that will be used in project.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 5,
                                                  maxLines: 10,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      _proposedtoolsController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                              '11. Related Technologies / Literature Review *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 22.0),
                                            child: Text(
                                              'Discuss at least two existing technologies which are related to your project. If your project is R&D then provide literature survey.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 5,
                                                  maxLines: 10,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      _relatedtechnologiesController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text('12. Project rationale *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 22.0),
                                            child: Text(
                                              'Provide the rationale of your idea in comparison to the existing.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 5,
                                                  maxLines: 10,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      _projectrationaleController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                              '13. Proposed Methodology *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 22.0),
                                            child: Text(
                                              'Describe your proposed software engineering methodology in case of computing application. If your project is R&D then provide research methodology.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 5,
                                                  maxLines: 10,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      _proposedmethodogiesController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                              '15. Schedule of activities and gantt chart *',
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 22.0),
                                            child: Text(
                                              'Provide activity name and tentative date.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines: 5,
                                                  maxLines: 10,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (text) {
                                                    RegExp regExp = RegExp(
                                                        r'[A-Za-z _.-]*$');

                                                    var textNotNull =
                                                        text ?? "";

                                                    if (textNotNull.isEmpty) {
                                                      return 'Answer is required';
                                                    } else if (!regExp.hasMatch(
                                                        textNotNull)) {
                                                      return 'Please Enter Correct Answer';
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      _scheduleController1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your answer',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30.0,
                                          ),
                                          SizedBox(
                                              height: 40,
                                              width: 170,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    var firebaseUser =
                                                        FirebaseAuth.instance
                                                            .currentUser;
                                                    var db = FirebaseFirestore
                                                        .instance
                                                        .collection(path)
                                                        .doc(prodoc)
                                                        .update({
                                                      'project-title':
                                                          _project_title.text,
                                                      "industrial-partner":
                                                          _industrialpartnerController1
                                                              .text,
                                                      "problem-statement":
                                                          _problemstatementController1
                                                              .text,
                                                      "objectives":
                                                          _objectivesController1
                                                              .text,
                                                      "problem-background":
                                                          _probbackgroundController1
                                                              .text,
                                                      "proposed-solution":
                                                          _proposedsolutionController1
                                                              .text,
                                                      "proposed-tools":
                                                          _proposedtoolsController1
                                                              .text,
                                                      "related-technologies":
                                                          _relatedtechnologiesController1
                                                              .text,
                                                      "project-rationale":
                                                          _projectrationaleController1
                                                              .text,
                                                      "proposed-methodology":
                                                          _proposedmethodogiesController1
                                                              .text,
                                                      "schedule":
                                                          _scheduleController1
                                                              .text,
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                                },

                                                // ignore: sort_child_properties_last
                                                child: const Text(
                                                  "Update",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                // onPressed: () {

                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color.fromARGB(
                                                            255, 57, 120, 125),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 60,
                                                        vertical: 20),
                                                    textStyle: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ))
                                        ],
                                      ),
                                    )),
                              )))
                    ])))
      ]))
    ]));
  }
}

_readproposal1(var snap, var value2, String topic) {
  var sample = value2;

  return SafeArea(
    child: Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(),
              Container(
                width: 1400,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 28, horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sample["fyp-id"],
                        style: const TextStyle(
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: 10,
                        thickness: 5,
                        color: Color.fromARGB(255, 57, 120, 125),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // const Divider(
                      //   height: 1,
                      //   thickness: 2,
                      //   color: Colors.blue,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'TITLE',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["project-title"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'INDUSTRIAL PARTNER',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["industrial-partner"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'PROBLEM STATEMENT',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["problem-statement"],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'OBJECTIVES',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["objectives"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'PROBLEM BACKGROUND',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["problem-background"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'PROPOSED SOLUTION',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["proposed-solution"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'PROPOSED TOOLS',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["proposed-tools"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'RELATED TECHNOLOGIES',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["related-technologies"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        ' PROJECT RATIONALE',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["project-rationale"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'PROPOSED METHODOLOGY',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snap["proposed-methodology"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // ImageNetwork(
                      //   image: imageUrl,
                      //   height: 396,
                      //   width: 515,
                      //   duration: 1500,
                      //   curve: Curves.easeIn,
                      //   onPointer: true,
                      //   debugPrint: false,
                      //   fullScreen: false,
                      //   fitAndroidIos: BoxFit.cover,
                      //   fitWeb: BoxFitWeb.cover,
                      //   borderRadius: BorderRadius.circular(70),
                      // ),
                      // const SizedBox(
                      //   height: 40,
                      // ),
                      const Text(
                        'GANTT CHART',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // ImageNetwork(
                      //   image: imageUrl2,
                      //   height: 396,
                      //   width: 515,
                      //   duration: 1500,
                      //   curve: Curves.easeIn,
                      //   onPointer: true,
                      //   debugPrint: false,
                      //   fullScreen: false,
                      //   fitAndroidIos: BoxFit.cover,
                      //   fitWeb: BoxFitWeb.cover,
                      //   borderRadius: BorderRadius.circular(70),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Text(
                        snap["schedule"],
                        style: const TextStyle(
                          fontFamily: 'Sans-serif',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              _multipage(snap, sample, topic);
            },
            child: const Text("Print")),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

_multipage(var snap, var snap2, String topic) async {
  final pdf = pw.Document();
  final db;

  var font = await PdfGoogleFonts.tinosRegular();
  var font_bold = await PdfGoogleFonts.tinosBold();

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  final netImage = await networkImage(
    'https://upload.wikimedia.org/wikipedia/en/e/e4/National_Textile_University_Logo.png',
  );

  // final netImage = await networkImage(snap['proposed-methodology-url']);
  dynamic data;

  title() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Zeeshan')
            // .doc('classes')
            // .collection('BS Information Technology')
            // .doc('groups')
            // .collection('group-members')
            // .where('group-id', isEqualTo: snap['group-id'])
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot db = snapshot.data!.docs[index];
                data = db;
                return Text('$db');
              });
        });
  }

  DocumentSnapshot snapshot;

  void getData() async {
    //use a Async-await function to get the data
    final data = await FirebaseFirestore.instance
        .collection("Zeeshan")
        .doc('EycajcosUCibiWDYtIDh')
        .get(); //get the data
    snapshot = data;
  }

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Center(
              child: pw.Container(
                  decoration: const pw.BoxDecoration(),
                  margin: const pw.EdgeInsets.symmetric(
                      vertical: 15, horizontal: 15),
                  width: double.infinity,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 15, bottom: 20),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            snap['group-id'],
                            style: pw.TextStyle(
                              fontSize: 28,
                              font: font,
                              // color: pw.Colors.blue,
                            ),
                          ),

                          pw.SizedBox(
                            height: 60,
                          ),
                          pw.Text('Project Proposal',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                fontSize: 24,
                                font: font_bold,
                              )),
                          pw.SizedBox(
                            height: 55,
                          ),
                          pw.Image(netImage, height: 140, width: 380),
                          // pw.Image(
                          //     pw.MemoryImage(
                          //       byteList,
                          //     ),
                          //     fit: pw.BoxFit.fitHeight),

                          // pw.Image(
                          //   image: NetworkImage(
                          //     'https://upload.wikimedia.org/wikipedia/en/e/e4/National_Textile_University_Logo.png',
                          //   ),
                          //   width: 350,
                          //   height: 200,
                          // ),
                          pw.SizedBox(
                            height: 50,
                          ),
                          pw.Text(
                            'Supervisor',
                            style: pw.TextStyle(
                              fontSize: 20,
                              font: font_bold,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            snap2['main-supervisor'],
                            style: pw.TextStyle(
                              fontSize: 18,
                              font: font,
                            ),
                          ),
                          pw.SizedBox(
                            height: 25,
                          ),
                          pw.Text(
                            'Group Details',
                            style: pw.TextStyle(
                              fontSize: 18,
                              font: font_bold,
                            ),
                          ),
                          pw.Text(
                            snap2['mem1'],
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                          pw.Text(
                            snap2['regno1'],
                            style: pw.TextStyle(fontSize: 14, font: font),
                          ),
                          pw.SizedBox(
                            height: 3,
                          ),
                          pw.Text(
                            snap2['mem2'],
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                          pw.Text(
                            snap2['regno2'],
                            style: pw.TextStyle(fontSize: 14, font: font),
                          ),
                          pw.SizedBox(
                            height: 3,
                          ),
                          pw.Text(
                            snap2['mem3'],
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                          pw.Text(
                            snap2['regno3'],
                            style: pw.TextStyle(fontSize: 14, font: font),
                          ),

                          pw.SizedBox(
                            height: 30,
                          ),
                          pw.Text(
                            'Department of Computer Science,',
                            style: pw.TextStyle(fontSize: 16, font: font_bold),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Text(
                            'National Textile University, Faisalabad',
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Text('Date: ${getCurrentDate()}',
                              style: pw.TextStyle(font: font, fontSize: 14)),
                        ]),
                  )))
        ];
        // Center
      }));
  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Container(
            margin:
                const pw.EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Divider(height: 10, thickness: 3),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                    'FYP Proposal',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 20,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    '$topic',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 18,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                    'A- Basic Information',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 20,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Table(
                      border: pw.TableBorder.all(),
                      defaultColumnWidth: const pw.FixedColumnWidth(80.0),
                      // defaultVerticalAlignment:
                      //     pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.TableRow(children: [
                          pw.Column(children: [
                            pw.Container(
                                padding: const pw.EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 2),
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.only(left: 14),
                                  child: pw.Text(
                                    'Title',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: 14,
                                      font: font_bold,
                                    ),
                                  ),
                                )),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(6.0),
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 5),
                                child: pw.Text(
                                  snap['project-title'],
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    font: font,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ])
                      ]),
                  pw.Table(
                      border: pw.TableBorder.all(),
                      defaultColumnWidth: const pw.FixedColumnWidth(80.0),
                      // defaultVerticalAlignment:
                      //     pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.TableRow(children: [
                          pw.Column(children: [
                            pw.Container(
                                padding: const pw.EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 2),
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.only(left: 14),
                                  child: pw.Text(
                                    'Project Type',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: 14,
                                      font: font_bold,
                                    ),
                                  ),
                                )),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(6.0),
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 5),
                                child: pw.Text(
                                  snap['project-type'],
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    font: font,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ])
                      ]),
                  pw.Table(
                      border: pw.TableBorder.all(),
                      defaultColumnWidth: const pw.FixedColumnWidth(80.0),
                      // defaultVerticalAlignment:
                      //     pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.TableRow(children: [
                          pw.Column(children: [
                            pw.Container(
                                padding: const pw.EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 2),
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.only(left: 14),
                                  child: pw.Text(
                                    'Project Category',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: 14,
                                      font: font_bold,
                                    ),
                                  ),
                                )),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(6.0),
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 5),
                                child: pw.Text(
                                  snap['project-category'],
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    font: font,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ])
                      ]),
                  pw.Table(
                      border: pw.TableBorder.all(),
                      defaultColumnWidth: const pw.FixedColumnWidth(80.0),
                      // defaultVerticalAlignment:
                      //     pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.TableRow(children: [
                          pw.Column(children: [
                            pw.Container(
                                padding: const pw.EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 2),
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.only(left: 14),
                                  child: pw.Text(
                                    'Industry Project',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: 14,
                                      font: font_bold,
                                    ),
                                  ),
                                )),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(6.0),
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 5),
                                child: pw.Text(
                                  snap['industrial-partner'],
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    font: font,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ])
                      ]),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'B-	Detail of FYP Idea',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 18,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'PROBLEM STATEMENT',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['problem-statement'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'OBJECTIVES',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['objectives'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROBLEM BACKGROUND',
                    style: pw.TextStyle(fontSize: 14, font: font_bold),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['problem-background'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROPOSED SOLUTION',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['proposed-solution'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROPOSED TOOLS',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['proposed-tools'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'RELATED TECHNOLOGIES',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['related-technologies'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROJECT RATIONALE',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['project-rationale'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'PROPOSED METHODOLOGY',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['proposed-methodology'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Text(
                    'GANTT CHART',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: font_bold,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    snap['schedule'],
                    style: pw.TextStyle(
                      fontSize: 13,
                      font: font,
                    ),
                  ),
                ]),
          ),
        ]; // Center
      }));

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/DemoProposal.dart';
// // ignore: unused_import
// import 'package:flutter_application_1/convenor_screens/supervisor_dashboard.dart';
// import 'package:flutter_application_1/student_screens/member_form.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:universal_html/html.dart';

// class MyProposal extends StatefulWidget {
//   @override
//   State<MyProposal> createState() => _MyProposalState();
// }

// class _MyProposalState extends State<MyProposal> {
//   var firebaseUser = FirebaseAuth.instance.currentUser;

//   List Zeeshan = [];

//   var _supervisor;

//   var _cosupervisor;
//   var id;
//   var storedocs;
//   var _groupid1;

//   // String get _groupid => dataaa();

//   bool button1 = true;
//   bool button2 = false;

//   var shoaib;
//   bool isEnabled = true;

//   void enableElevatedButton() {
//     if (shoaib['convenor-approval'] == 'abc') {
//       setState() {
//         isEnabled = true;
//       }
//     } else {
//       setState() {
//         isEnabled = false;
//       }
//     }
//   }

//   void _button1() {
//     setState(() {
//       button1 = false;
//       button2 = true;
//     });
//   }

//   void _button2() {
//     setState(() {
//       button1 = true;
//       button2 = false;
//     });
//   }

//   _getgroupid() {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(
//                 '/Convenor/classes/BS Information Technology/groups/group-members')
//             .where('fyp-id', isEqualTo: '23-FYP-304')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.data?.size == 0) {
//             return const Center(child: Text('null'));
//           }
//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: snapshot.data?.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               DocumentSnapshot groupid = snapshot.data!.docs[index];

//               _groupid1 = groupid.id;

//               snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map a = document.data() as Map<String, dynamic>;
//                 storedocs = a;
//                 a['id'] = document.id;
//               });

//               if (snapshot.hasData) {
//                 return const Text('nukll');
//               }

//               return const Text('null');
//             },
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: const Color.fromARGB(255, 232, 242, 244),
//       body: StreamBuilder(
//           stream:
//               // FirebaseFirestore.instance
//               //     .collection(
//               //         '/Convenor/classes/BS Information Technology/groups/group-members')
//               //     .where('fyp-id', isEqualTo: '23-FYP-307')
//               //     .snapshots(),
//               FirebaseFirestore.instance
//                   .collection('FYP')
//                   .doc('fyp(19-23)')
//                   .collection('groups')
//                   .doc('wBorkr50KobyriYorczQ2tGOSiz1')
//                   .collection('members')
//                   .snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.data?.size == 0) {
//               return Center(
//                   child: Container(
//                 margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
//                 width: 600,
//                 height: 300,
//                 decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(20)),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "No proposals submitted yet",
//                       style: TextStyle(fontSize: 24),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text("Click here to Submit"),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const DemoProposal(),
//                                 ));

//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => const DemoProposal()));
//                           },
//                           style: ElevatedButton.styleFrom(
//                               primary: const Color.fromARGB(255, 57, 120, 125),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 60, vertical: 20),
//                               textStyle: const TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold)),
//                           child: const Text('Submit Now'),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ));
//             }

//             return Column(
//               children: [
//                 ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data?.docs.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       DocumentSnapshot document = snapshot.data!.docs[index];

//                       if (snapshot.hasData) {
//                         return Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(17)),
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 20, horizontal: 155),
//                           width: double.infinity,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 28, horizontal: 50),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: const Color.fromARGB(
//                                             255, 179, 51, 51),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(12.0),
//                                       child: Text(
//                                         document["group-id"],
//                                         style: const TextStyle(
//                                             color: Colors.white, fontSize: 14),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 const Divider(
//                                   height: 10,
//                                   thickness: 5,
//                                   color: Color.fromARGB(255, 57, 120, 125),
//                                 ),
//                                 getgroupinfo(document['group-id'])
//                                 // grpinfo(),

//                                 // firstproposal(document.id, document),
//                                 // secondproposal(document.id, document),
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//                       return const Text('null');
//                     }),
//               ],
//             );
//           }),
//     );
//   }

//   getgroupinfo(String value) {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(
//                 '/Convenor/classes/BS Information Technology/groups/group-members')
//             .where('fyp-id', isEqualTo: value)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.data?.size == 0) {
//             return Center(
//                 child: Container(
//               margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
//               width: 600,
//               height: 300,
//               decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(20)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "No proposals submitted yet",
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text("Click here to Submit"),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const DemoProposal(),
//                               ));

//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => const DemoProposal()));
//                         },
//                         style: ElevatedButton.styleFrom(
//                             primary: const Color.fromARGB(255, 57, 120, 125),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 60, vertical: 20),
//                             textStyle: const TextStyle(
//                                 fontSize: 15, fontWeight: FontWeight.bold)),
//                         child: const Text('Submit Now'),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ));
//           }

//           return ListView.builder(
//               shrinkWrap: true,
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 DocumentSnapshot document = snapshot.data!.docs[index];

//                 if (snapshot.hasData) {
//                   return Column(
//                     children: [
//                       proposal1(document.id, document),
//                       proposal2(document.id, document)
//                     ],
//                   );
//                 }
//                 return const Text('null');
//               });
//         });
//   }

//   getfeedbackinfo(String path, String prodoc1, var db) {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(path)
//             .doc(prodoc1)
//             .collection('convenor-feedback')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.data?.size == 0) {
//             return SizedBox(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "No feedback",
//                       style: TextStyle(fontSize: 24),
//                     ),
//                   ]),
//             );
//           }

//           return ListView.builder(
//               shrinkWrap: true,
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 DocumentSnapshot document = snapshot.data!.docs[index];

//                 if (snapshot.hasData) {
//                   return Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         const Text(
//                           'Feedback',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Text(document['feedback'])
//                       ],
//                     ),
//                   );
//                 }
//                 return const Text('null');
//               });
//         });
//   }

//   proposal1(String groupid, var groupsnapshot) {
//     String topic = 'Main Topic Details';

//     String path =
//         '/Convenor/classes/BS Information Technology/groups/group-members/$groupid/proposals/proposals/proposal1';

//     String prodoc = '';
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Convenor')
//             .doc('classes')
//             .collection('BS Information Technology')
//             .doc('groups')
//             .collection('group-members')
//             .doc(groupid)
//             .collection('proposals')
//             .doc('proposals')
//             .collection('proposal1')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.data?.size == 0) {
//             return Center(
//                 child: Container(
//               margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
//               width: 600,
//               height: 300,
//               decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(20)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "No proposals submitted yet",
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text("Click here to Submit"),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const DemoProposal(),
//                               ));

//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => const DemoProposal()));
//                         },
//                         style: ElevatedButton.styleFrom(
//                             primary: const Color.fromARGB(255, 57, 120, 125),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 60, vertical: 20),
//                             textStyle: const TextStyle(
//                                 fontSize: 15, fontWeight: FontWeight.bold)),
//                         child: const Text('Submit Now'),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ));
//           }

//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: snapshot.data?.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               DocumentSnapshot db = snapshot.data!.docs[index];
//               // shoaib = db;
//               prodoc = db.id;

//               if (snapshot.hasData) {
//                 return Container(
//                   // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//                   width: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 30),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: const Color.fromARGB(
//                                               255, 139, 77, 53),
//                                           borderRadius:
//                                               BorderRadius.circular(8)),
//                                       child: const Padding(
//                                         padding: EdgeInsets.all(10.0),
//                                         child: Text(
//                                           ('Proposal 1'),
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 12),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 15,
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       db["project-title"],
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   child: Row(
//                                     children: [
//                                       const Text(
//                                         'Approval Status: ',
//                                         style: TextStyle(
//                                             fontSize: 16, color: Colors.black),
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color: const Color.fromARGB(
//                                                 255, 180, 34, 34),
//                                             borderRadius:
//                                                 BorderRadius.circular(4)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 20, vertical: 10),
//                                           child: Text(
//                                             db['convenor-approval'],
//                                             style: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 40,
//                                 ),
//                                 // ElevatedButton(
//                                 //     onPressed: () {
//                                 //       showDialog(
//                                 //         context: context,
//                                 //         builder: (BuildContext context) =>
//                                 //             LayoutBuilder(
//                                 //           builder: (context, constraints) =>
//                                 //               const SimpleDialog(
//                                 //             contentPadding: EdgeInsets.all(15),
//                                 //             title:
//                                 //                 Text('Your feedback is here'),
//                                 //             children: [
//                                 //               Text('feedback')
//                                 //               // getfeedbackinfo(path, prodoc, db),
//                                 //             ],
//                                 //           ),
//                                 //         ),
//                                 //       );

//                                 //       // print(_groupid2);
//                                 //       // print(_groupid);

//                                 //       // showDialog(
//                                 //       //     context: context,
//                                 //       //     builder: (ctx) => Container(
//                                 //       //             child: AlertDialog(
//                                 //       //           insetPadding:
//                                 //       //               const EdgeInsets.symmetric(
//                                 //       //                   horizontal: 200,
//                                 //       //                   vertical: 20),
//                                 //       //           scrollable: true,
//                                 //       //           shape:
//                                 //       //               const RoundedRectangleBorder(
//                                 //       //                   borderRadius:
//                                 //       //                       BorderRadius.all(
//                                 //       //                           Radius.circular(
//                                 //       //                               20.0))),
//                                 //       //           content: SingleChildScrollView(
//                                 //       //             child: Container(
//                                 //       //               // width: double.infinity,
//                                 //       //               child:
//                                 //       //                   SingleChildScrollView(
//                                 //       //                 child: Column(
//                                 //       //                   children: <Widget>[
//                                 //       //                     getfeedbackinfo(
//                                 //       //                         path, prodoc, db),
//                                 //       //                     Text('Zeeshan'),
//                                 //       //                   ],
//                                 //       //                 ),
//                                 //       //               ),
//                                 //       //             ),
//                                 //       //           ),
//                                 //       //         )));
//                                 //     },
//                                 //     style: ElevatedButton.styleFrom(
//                                 //         primary: const Color.fromARGB(
//                                 //             255, 94, 84, 84),
//                                 //         padding: const EdgeInsets.symmetric(
//                                 //             horizontal: 25, vertical: 15),
//                                 //         textStyle: const TextStyle(
//                                 //           fontSize: 15,
//                                 //         )),
//                                 //     child: const Text('Feedback')),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       // print(_groupid2);
//                                       // print(_groupid);

//                                       showDialog(
//                                           context: context,
//                                           builder: (ctx) => Container(
//                                                   child: AlertDialog(
//                                                 insetPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 200,
//                                                         vertical: 20),
//                                                 scrollable: true,
//                                                 shape:
//                                                     const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     20.0))),
//                                                 content: SingleChildScrollView(
//                                                   child: Container(
//                                                     width: double.infinity,
//                                                     child:
//                                                         SingleChildScrollView(
//                                                       child: Column(
//                                                         children: <Widget>[
//                                                           _readproposal1(
//                                                               db,
//                                                               groupsnapshot,
//                                                               topic),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )));
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                         primary:
//                                             Color.fromARGB(255, 39, 62, 187),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 25, vertical: 15),
//                                         textStyle: const TextStyle(
//                                           fontSize: 15,
//                                         )),
//                                     child: const Text('Read')),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       // print(_groupid2);
//                                       // print(_groupid);

//                                       showDialog(
//                                           context: context,
//                                           builder: (ctx) => Container(
//                                                   child: AlertDialog(
//                                                 insetPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 200,
//                                                         vertical: 20),
//                                                 scrollable: true,
//                                                 shape:
//                                                     const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     20.0))),
//                                                 content: SingleChildScrollView(
//                                                   child: Container(
//                                                     width: double.infinity,
//                                                     child:
//                                                         SingleChildScrollView(
//                                                       child: Column(
//                                                         children: <Widget>[
//                                                           _updateproposal1(
//                                                               db,
//                                                               groupsnapshot,
//                                                               topic,
//                                                               prodoc,
//                                                               path),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )));
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                         primary: const Color.fromARGB(
//                                             255, 94, 84, 84),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 25, vertical: 15),
//                                         textStyle: const TextStyle(
//                                           fontSize: 15,
//                                         )),
//                                     child: const Text('Edit')),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       _multipage(db, groupsnapshot, topic);
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 25, vertical: 15),
//                                         textStyle: const TextStyle(
//                                           fontSize: 15,
//                                         )),
//                                     child: const Text('Print')),
//                               ],
//                             ),
//                           ],
//                         ),
//                         getfeedbackinfo(path, prodoc, db),
//                       ],
//                     ),
//                   ),
//                 );
//               }

//               return const Text('null');
//             },
//           );
//         });
//   }

//   proposal2(String groupid, var groupsnapshot) {
//     String topic = 'Main Topic Details';

//     String path2 =
//         '/Convenor/classes/BS Information Technology/groups/group-members/$groupid/proposals/proposals/proposal2';

//     String prodoc = '';
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Convenor')
//             .doc('classes')
//             .collection('BS Information Technology')
//             .doc('groups')
//             .collection('group-members')
//             .doc(groupid)
//             .collection('proposals')
//             .doc('proposals')
//             .collection('proposal2')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.data?.size == 0) {
//             return Center(
//                 child: Container(
//               margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
//               width: 600,
//               height: 300,
//               decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(20)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "No proposals submitted yet",
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text("Click here to Submit"),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const DemoProposal(),
//                               ));

//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => const DemoProposal()));
//                         },
//                         style: ElevatedButton.styleFrom(
//                             primary: const Color.fromARGB(255, 57, 120, 125),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 60, vertical: 20),
//                             textStyle: const TextStyle(
//                                 fontSize: 15, fontWeight: FontWeight.bold)),
//                         child: const Text('Submit Now'),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ));
//           }

//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: snapshot.data?.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               DocumentSnapshot db = snapshot.data!.docs[index];
//               // shoaib = db;
//               prodoc = db.id;

//               if (snapshot.hasData) {
//                 return Container(
//                   // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//                   width: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 30),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: const Color.fromARGB(
//                                               255, 139, 77, 53),
//                                           borderRadius:
//                                               BorderRadius.circular(8)),
//                                       child: const Padding(
//                                         padding: EdgeInsets.all(10.0),
//                                         child: Text(
//                                           ('Proposal 1'),
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 12),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 15,
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       db["project-title"],
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   child: Row(
//                                     children: [
//                                       const Text(
//                                         'Approval Status: ',
//                                         style: TextStyle(
//                                             fontSize: 16, color: Colors.black),
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color: const Color.fromARGB(
//                                                 255, 180, 34, 34),
//                                             borderRadius:
//                                                 BorderRadius.circular(4)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 20, vertical: 10),
//                                           child: Text(
//                                             db['convenor-approval'],
//                                             // 'Accepted with Edits',
//                                             style: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 40,
//                                 ),
//                                 // ElevatedButton(
//                                 //     onPressed: () {
//                                 //       showDialog(
//                                 //         context: context,
//                                 //         builder: (BuildContext context) =>
//                                 //             LayoutBuilder(
//                                 //           builder: (context, constraints) =>
//                                 //               const SimpleDialog(
//                                 //             contentPadding: EdgeInsets.all(15),
//                                 //             title:
//                                 //                 Text('Your feedback is here'),
//                                 //             children: [
//                                 //               Text('feedback')
//                                 //               // getfeedbackinfo(path, prodoc, db),
//                                 //             ],
//                                 //           ),
//                                 //         ),
//                                 //       );

//                                 //       // print(_groupid2);
//                                 //       // print(_groupid);

//                                 //       // showDialog(
//                                 //       //     context: context,
//                                 //       //     builder: (ctx) => Container(
//                                 //       //             child: AlertDialog(
//                                 //       //           insetPadding:
//                                 //       //               const EdgeInsets.symmetric(
//                                 //       //                   horizontal: 200,
//                                 //       //                   vertical: 20),
//                                 //       //           scrollable: true,
//                                 //       //           shape:
//                                 //       //               const RoundedRectangleBorder(
//                                 //       //                   borderRadius:
//                                 //       //                       BorderRadius.all(
//                                 //       //                           Radius.circular(
//                                 //       //                               20.0))),
//                                 //       //           content: SingleChildScrollView(
//                                 //       //             child: Container(
//                                 //       //               // width: double.infinity,
//                                 //       //               child:
//                                 //       //                   SingleChildScrollView(
//                                 //       //                 child: Column(
//                                 //       //                   children: <Widget>[
//                                 //       //                     getfeedbackinfo(
//                                 //       //                         path, prodoc, db),
//                                 //       //                     Text('Zeeshan'),
//                                 //       //                   ],
//                                 //       //                 ),
//                                 //       //               ),
//                                 //       //             ),
//                                 //       //           ),
//                                 //       //         )));
//                                 //     },
//                                 //     style: ElevatedButton.styleFrom(
//                                 //         primary: const Color.fromARGB(
//                                 //             255, 94, 84, 84),
//                                 //         padding: const EdgeInsets.symmetric(
//                                 //             horizontal: 25, vertical: 15),
//                                 //         textStyle: const TextStyle(
//                                 //           fontSize: 15,
//                                 //         )),
//                                 //     child: const Text('Feedback')),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       // print(_groupid2);
//                                       // print(_groupid);

//                                       showDialog(
//                                           context: context,
//                                           builder: (ctx) => Container(
//                                                   child: AlertDialog(
//                                                 insetPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 200,
//                                                         vertical: 20),
//                                                 scrollable: true,
//                                                 shape:
//                                                     const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     20.0))),
//                                                 content: SingleChildScrollView(
//                                                   child: Container(
//                                                     width: double.infinity,
//                                                     child:
//                                                         SingleChildScrollView(
//                                                       child: Column(
//                                                         children: <Widget>[
//                                                           _readproposal1(
//                                                               db,
//                                                               groupsnapshot,
//                                                               topic),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )));
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                         primary:
//                                             Color.fromARGB(255, 39, 62, 187),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 25, vertical: 15),
//                                         textStyle: const TextStyle(
//                                           fontSize: 15,
//                                         )),
//                                     child: const Text('Read')),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       // print(_groupid2);
//                                       // print(_groupid);

//                                       showDialog(
//                                           context: context,
//                                           builder: (ctx) => Container(
//                                                   child: AlertDialog(
//                                                 insetPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 200,
//                                                         vertical: 20),
//                                                 scrollable: true,
//                                                 shape:
//                                                     const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     20.0))),
//                                                 content: SingleChildScrollView(
//                                                   child: Container(
//                                                     width: double.infinity,
//                                                     child:
//                                                         SingleChildScrollView(
//                                                       child: Column(
//                                                         children: <Widget>[
//                                                           _updateproposal1(
//                                                               db,
//                                                               groupsnapshot,
//                                                               topic,
//                                                               prodoc,
//                                                               path2),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )));
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                         primary: const Color.fromARGB(
//                                             255, 94, 84, 84),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 25, vertical: 15),
//                                         textStyle: const TextStyle(
//                                           fontSize: 15,
//                                         )),
//                                     child: const Text('Edit')),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       _multipage(db, groupsnapshot, topic);
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 25, vertical: 15),
//                                         textStyle: const TextStyle(
//                                           fontSize: 15,
//                                         )),
//                                     child: const Text('Print')),
//                               ],
//                             ),
//                           ],
//                         ),
//                         getfeedbackinfo(path2, prodoc, db),
//                       ],
//                     ),
//                   ),
//                 );
//               }

//               return const Text('null');
//             },
//           );
//         });
//   }

//   _feedback1(String path, String prodoc1, var db) {
//     String feedback1 = '';
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(path)
//             .doc(prodoc1)
//             .collection('convenor-feedback')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.data?.size == 0) {
//             return Center(
//                 child: Container(
//               margin: const EdgeInsets.fromLTRB(140, 70, 120, 0),
//               width: 600,
//               height: 300,
//               decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(20)),
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text(
//                       "No Feedback",
//                       style: TextStyle(fontSize: 24),
//                     ),
//                   ]),
//             ));
//           }

//           return ListView.builder(
//               shrinkWrap: true,
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 DocumentSnapshot feedback = snapshot.data!.docs[index];

//                 // prodoc2 = db.id;

//                 if (snapshot.hasData) {
//                   return SafeArea(
//                       child: Column(children: [
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Text(db['project-title']),
//                           // Text(feedback['feedback']),
//                         ],
//                       ),
//                     )
//                   ]));
//                 }
//                 return const Text('null');
//               });
//         });
//   }

//   _updateproposal1(
//       var snap, var value2, String topic, String prodoc, String path) {
//     var sample = value2;

//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//     final _group_id = TextEditingController();
//     final _project_title = TextEditingController();

//     final _industrialpartnerController1 = TextEditingController();
//     final _problemstatementController1 = TextEditingController();
//     final _objectivesController1 = TextEditingController();
//     final _probbackgroundController1 = TextEditingController();
//     final _proposedsolutionController1 = TextEditingController();
//     final _relatedtechnologiesController1 = TextEditingController();

//     final _proposedtoolsController1 = TextEditingController();
//     final _proposedmethodogiesController1 = TextEditingController();
//     final _projectrationaleController1 = TextEditingController();
//     final _scheduleController1 = TextEditingController();

//     _group_id.value = TextEditingValue(text: snap['group-id']);
//     _project_title.value = TextEditingValue(text: snap['project-title']);

//     _industrialpartnerController1.value =
//         TextEditingValue(text: snap['industrial-partner']);

//     _problemstatementController1.value =
//         TextEditingValue(text: snap['problem-statement']);

//     _objectivesController1.value = TextEditingValue(text: snap['objectives']);

//     _probbackgroundController1.value =
//         TextEditingValue(text: snap['problem-background']);

//     _proposedsolutionController1.value =
//         TextEditingValue(text: snap['proposed-solution']);

//     _relatedtechnologiesController1.value =
//         TextEditingValue(text: snap['related-technologies']);

//     _proposedtoolsController1.value =
//         TextEditingValue(text: snap['proposed-tools']);

//     _proposedmethodogiesController1.value =
//         TextEditingValue(text: snap['proposed-methodology']);

//     _projectrationaleController1.value =
//         TextEditingValue(text: snap['project-rationale']);

//     _scheduleController1.value = TextEditingValue(text: snap['schedule']);

//     return SafeArea(
//         child: Column(children: [
//       SingleChildScrollView(
//           child: Column(children: [
//         Container(),
//         Container(
//             width: 1400,
//             decoration: const BoxDecoration(color: Colors.white),
//             child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 28, horizontal: 50),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: <Widget>[
//                       Container(
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                           color: Color.fromARGB(255, 57, 120, 125),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(13.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               const SizedBox(
//                                 height: 3,
//                               ),
//                               Row(
//                                 children: const [
//                                   SizedBox(
//                                     width: 45,
//                                   ),
//                                   Text(
//                                     'BSIT FYP Proposal Submission',
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 20),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 3,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                           padding: const EdgeInsets.only(left: 0.0),
//                           child: Container(
//                               decoration:
//                                   const BoxDecoration(color: Colors.white),
//                               child: Form(
//                                 key: _formKey,
//                                 child: Padding(
//                                     padding: const EdgeInsets.all(30.0),
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets.only(left: 15.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           const Text(
//                                             "* Required ",
//                                             style: TextStyle(color: Colors.red),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           const Text(
//                                             "Group Details",
//                                             style: TextStyle(
//                                               fontSize: 22,
//                                               fontWeight: FontWeight.w900,
//                                               color: Color.fromARGB(
//                                                   255, 57, 120, 125),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           const Text(
//                                             '1.Group Id *',
//                                             style: TextStyle(fontSize: 18),
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 16.0),
//                                             child: Container(
//                                               height: 50,
//                                               width: double.infinity,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   // maxLength: 5,
//                                                   maxLines: 1,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller: _group_id,
//                                                   // controller: _groupidController,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 40,
//                                           ),
//                                           const Text(
//                                             "Main Topic Details",
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w900,
//                                               color: Color.fromARGB(
//                                                   255, 57, 120, 125),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Text(
//                                             '2. Project Title *',
//                                             style: TextStyle(fontSize: 18),
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 16.0),
//                                             child: Text(
//                                               'Enter 8-15 words project title.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 16.0),
//                                             child: Container(
//                                               height: 50,
//                                               width: double.infinity,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   // maxLength: 5,
//                                                   maxLines: 1,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller: _project_title,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 90,
//                                           ),
//                                           const Text(
//                                               '5. Describe the industrial partner *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 16.0),
//                                             child: Text(
//                                               'In case of industrial partner, please provide the details (name, address, and contact details) of industrial partner.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 16.0),
//                                             child: Container(
//                                               height: 80,
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   maxLines: null,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller:
//                                                       _industrialpartnerController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 90,
//                                           ),
//                                           const Text('6. Problem statement *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 16.0),
//                                             child: Text(
//                                               'Clear state the problem statement in 1-4 lines.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 16.0),
//                                             child: Container(
//                                               // height: 90,
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   minLines: 5,
//                                                   maxLines: 10,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   controller:
//                                                       _problemstatementController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 90,
//                                           ),
//                                           const Text('7. Objectives *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 16.0),
//                                             child: Text(
//                                               'Clearly state 1-3 measurable objectives. Each object must start with "To".',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 16.0),
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   minLines: 3,
//                                                   maxLines: 10,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller:
//                                                       _objectivesController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 90,
//                                           ),
//                                           const Text(
//                                               '8. Introduction and background of the problem *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 16.0),
//                                             child: Text(
//                                               'Concisely (5-10 lines) highlight the significance, background, and related work of the highlighted problem.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 16.0),
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   minLines: 5,
//                                                   maxLines: 10,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller:
//                                                       _probbackgroundController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           const Text(
//                                               '9. Proposed solution / Methodology *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 16.0),
//                                             child: Text(
//                                               'Briefly describe the proposed solution to problem. You may use the diagram to depict the proposed solution.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 16.0),
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   minLines: 5,
//                                                   maxLines: 10,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller:
//                                                       _proposedsolutionController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           const Text(
//                                               '10. Proposed tools and technologies *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 22.0),
//                                             child: Text(
//                                               'Write down possible tools, languages, databases, etc. that will be used in project.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 22.0),
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   minLines: 5,
//                                                   maxLines: 10,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller:
//                                                       _proposedtoolsController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           const Text(
//                                               '11. Related Technologies / Literature Review *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 22.0),
//                                             child: Text(
//                                               'Discuss at least two existing technologies which are related to your project. If your project is R&D then provide literature survey.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 22.0),
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   minLines: 5,
//                                                   maxLines: 10,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller:
//                                                       _relatedtechnologiesController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           const Text('12. Project rationale *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 22.0),
//                                             child: Text(
//                                               'Provide the rationale of your idea in comparison to the existing.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 22.0),
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   minLines: 5,
//                                                   maxLines: 10,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller:
//                                                       _projectrationaleController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           const Text(
//                                               '13. Proposed Methodology *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 22.0),
//                                             child: Text(
//                                               'Describe your proposed software engineering methodology in case of computing application. If your project is R&D then provide research methodology.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 22.0),
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   minLines: 5,
//                                                   maxLines: 10,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller:
//                                                       _proposedmethodogiesController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           const Text(
//                                               '15. Schedule of activities and gantt chart *',
//                                               style: TextStyle(fontSize: 18)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           const Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 22.0),
//                                             child: Text(
//                                               'Provide activity name and tentative date.',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 22.0),
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey)),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: TextFormField(
//                                                   keyboardType:
//                                                       TextInputType.multiline,
//                                                   minLines: 5,
//                                                   maxLines: 10,
//                                                   autovalidateMode:
//                                                       AutovalidateMode
//                                                           .onUserInteraction,
//                                                   validator: (text) {
//                                                     RegExp regExp = RegExp(
//                                                         r'[A-Za-z _.-]*$');

//                                                     var textNotNull =
//                                                         text ?? "";

//                                                     if (textNotNull.isEmpty) {
//                                                       return 'Answer is required';
//                                                     } else if (!regExp.hasMatch(
//                                                         textNotNull)) {
//                                                       return 'Please Enter Correct Answer';
//                                                     }
//                                                     return null;
//                                                   },
//                                                   controller:
//                                                       _scheduleController1,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: InputBorder.none,
//                                                     hintText:
//                                                         'Enter your answer',
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 30.0,
//                                           ),
//                                           SizedBox(
//                                               height: 40,
//                                               width: 170,
//                                               child: ElevatedButton(
//                                                 onPressed: () {
//                                                   if (_formKey.currentState!
//                                                       .validate()) {
//                                                     var firebaseUser =
//                                                         FirebaseAuth.instance
//                                                             .currentUser;
//                                                     var db = FirebaseFirestore
//                                                         .instance
//                                                         .collection(path)
//                                                         .doc(prodoc)
//                                                         .update({
//                                                       'project-title':
//                                                           _project_title.text,
//                                                       "industrial-partner":
//                                                           _industrialpartnerController1
//                                                               .text,
//                                                       "problem-statement":
//                                                           _problemstatementController1
//                                                               .text,
//                                                       "objectives":
//                                                           _objectivesController1
//                                                               .text,
//                                                       "problem-background":
//                                                           _probbackgroundController1
//                                                               .text,
//                                                       "proposed-solution":
//                                                           _proposedsolutionController1
//                                                               .text,
//                                                       "proposed-tools":
//                                                           _proposedtoolsController1
//                                                               .text,
//                                                       "related-technologies":
//                                                           _relatedtechnologiesController1
//                                                               .text,
//                                                       "project-rationale":
//                                                           _projectrationaleController1
//                                                               .text,
//                                                       "proposed-methodology":
//                                                           _proposedmethodogiesController1
//                                                               .text,
//                                                       "schedule":
//                                                           _scheduleController1
//                                                               .text,
//                                                     });
//                                                     Navigator.pop(context);
//                                                   }
//                                                 },

//                                                 // ignore: sort_child_properties_last
//                                                 child: const Text(
//                                                   "Update",
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),

//                                                 // onPressed: () {

//                                                 style: ElevatedButton.styleFrom(
//                                                     primary:
//                                                         const Color.fromARGB(
//                                                             255, 57, 120, 125),
//                                                     padding: const EdgeInsets
//                                                             .symmetric(
//                                                         horizontal: 60,
//                                                         vertical: 20),
//                                                     textStyle: const TextStyle(
//                                                         fontSize: 15,
//                                                         fontWeight:
//                                                             FontWeight.bold)),
//                                               ))
//                                         ],
//                                       ),
//                                     )),
//                               )))
//                     ])))
//       ]))
//     ]));
//   }
// }

// _readproposal1(var snap, var value2, String topic) {
//   var sample = value2;

//   return SafeArea(
//     child: Column(
//       children: [
//         SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(),
//               Container(
//                 width: 1400,
//                 decoration: const BoxDecoration(color: Colors.white),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 28, horizontal: 50),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         sample["fyp-id"],
//                         style: const TextStyle(
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const Divider(
//                         height: 10,
//                         thickness: 5,
//                         color: Color.fromARGB(255, 57, 120, 125),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),

//                       // const Divider(
//                       //   height: 1,
//                       //   thickness: 2,
//                       //   color: Colors.blue,
//                       // ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         'TITLE',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["project-title"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         'INDUSTRIAL PARTNER',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["industrial-partner"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         'PROBLEM STATEMENT',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["problem-statement"],
//                         style: const TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         'OBJECTIVES',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["objectives"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         'PROBLEM BACKGROUND',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["problem-background"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         'PROPOSED SOLUTION',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["proposed-solution"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         'PROPOSED TOOLS',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["proposed-tools"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         'RELATED TECHNOLOGIES',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["related-technologies"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         ' PROJECT RATIONALE',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["project-rationale"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       const Text(
//                         'PROPOSED METHODOLOGY',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         snap["proposed-methodology"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       // ImageNetwork(
//                       //   image: imageUrl,
//                       //   height: 396,
//                       //   width: 515,
//                       //   duration: 1500,
//                       //   curve: Curves.easeIn,
//                       //   onPointer: true,
//                       //   debugPrint: false,
//                       //   fullScreen: false,
//                       //   fitAndroidIos: BoxFit.cover,
//                       //   fitWeb: BoxFitWeb.cover,
//                       //   borderRadius: BorderRadius.circular(70),
//                       // ),
//                       // const SizedBox(
//                       //   height: 40,
//                       // ),
//                       const Text(
//                         'GANTT CHART',
//                         style: TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontFamily: 'Sans-serif',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       // ImageNetwork(
//                       //   image: imageUrl2,
//                       //   height: 396,
//                       //   width: 515,
//                       //   duration: 1500,
//                       //   curve: Curves.easeIn,
//                       //   onPointer: true,
//                       //   debugPrint: false,
//                       //   fullScreen: false,
//                       //   fitAndroidIos: BoxFit.cover,
//                       //   fitWeb: BoxFitWeb.cover,
//                       //   borderRadius: BorderRadius.circular(70),
//                       // ),
//                       // const SizedBox(
//                       //   height: 10,
//                       // ),
//                       Text(
//                         snap["schedule"],
//                         style: const TextStyle(
//                           fontFamily: 'Sans-serif',
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         ElevatedButton(
//             onPressed: () {
//               _multipage(snap, sample, topic);
//             },
//             child: const Text("Print")),
//         const SizedBox(
//           height: 10,
//         ),
//       ],
//     ),
//   );
// }

// _multipage(var snap, var snap2, String topic) async {
//   final pdf = pw.Document();
//   final db;

//   var font = await PdfGoogleFonts.tinosRegular();
//   var font_bold = await PdfGoogleFonts.tinosBold();

//   String getCurrentDate() {
//     var date = DateTime.now().toString();

//     var dateParse = DateTime.parse(date);

//     var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
//     return formattedDate.toString();
//   }

//   final netImage = await networkImage(
//     'https://upload.wikimedia.org/wikipedia/en/e/e4/National_Textile_University_Logo.png',
//   );

//   // final netImage = await networkImage(snap['proposed-methodology-url']);
//   dynamic data;

//   title() {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Zeeshan')
//             // .doc('classes')
//             // .collection('BS Information Technology')
//             // .doc('groups')
//             // .collection('group-members')
//             // .where('group-id', isEqualTo: snap['group-id'])
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           return ListView.builder(
//               shrinkWrap: true,
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 DocumentSnapshot db = snapshot.data!.docs[index];
//                 data = db;
//                 return Text('$db');
//               });
//         });
//   }

//   DocumentSnapshot snapshot;

//   void getData() async {
//     //use a Async-await function to get the data
//     final data = await FirebaseFirestore.instance
//         .collection("Zeeshan")
//         .doc('EycajcosUCibiWDYtIDh')
//         .get(); //get the data
//     snapshot = data;
//   }

//   pdf.addPage(pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         return <pw.Widget>[
//           pw.Center(
//               child: pw.Container(
//                   decoration: const pw.BoxDecoration(),
//                   margin: const pw.EdgeInsets.symmetric(
//                       vertical: 15, horizontal: 15),
//                   width: double.infinity,
//                   child: pw.Padding(
//                     padding: const pw.EdgeInsets.only(top: 15, bottom: 20),
//                     child: pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text(
//                             snap['group-id'],
//                             style: pw.TextStyle(
//                               fontSize: 28,
//                               font: font,
//                               // color: pw.Colors.blue,
//                             ),
//                           ),

//                           pw.SizedBox(
//                             height: 60,
//                           ),
//                           pw.Text('Project Proposal',
//                               textAlign: pw.TextAlign.center,
//                               style: pw.TextStyle(
//                                 fontSize: 24,
//                                 font: font_bold,
//                               )),
//                           pw.SizedBox(
//                             height: 55,
//                           ),
//                           pw.Image(netImage, height: 140, width: 380),
//                           // pw.Image(
//                           //     pw.MemoryImage(
//                           //       byteList,
//                           //     ),
//                           //     fit: pw.BoxFit.fitHeight),

//                           // pw.Image(
//                           //   image: NetworkImage(
//                           //     'https://upload.wikimedia.org/wikipedia/en/e/e4/National_Textile_University_Logo.png',
//                           //   ),
//                           //   width: 350,
//                           //   height: 200,
//                           // ),
//                           pw.SizedBox(
//                             height: 50,
//                           ),
//                           pw.Text(
//                             'Supervisor',
//                             style: pw.TextStyle(
//                               fontSize: 20,
//                               font: font_bold,
//                             ),
//                           ),
//                           pw.SizedBox(height: 10),
//                           pw.Text(
//                             snap2['main-supervisor'],
//                             style: pw.TextStyle(
//                               fontSize: 18,
//                               font: font,
//                             ),
//                           ),
//                           pw.SizedBox(
//                             height: 25,
//                           ),
//                           pw.Text(
//                             'Group Details',
//                             style: pw.TextStyle(
//                               fontSize: 18,
//                               font: font_bold,
//                             ),
//                           ),
//                           pw.Text(
//                             snap2['mem1'],
//                             style: pw.TextStyle(fontSize: 16, font: font),
//                           ),
//                           pw.Text(
//                             snap2['regno1'],
//                             style: pw.TextStyle(fontSize: 14, font: font),
//                           ),
//                           pw.SizedBox(
//                             height: 3,
//                           ),
//                           pw.Text(
//                             snap2['mem2'],
//                             style: pw.TextStyle(fontSize: 16, font: font),
//                           ),
//                           pw.Text(
//                             snap2['regno2'],
//                             style: pw.TextStyle(fontSize: 14, font: font),
//                           ),
//                           pw.SizedBox(
//                             height: 3,
//                           ),
//                           pw.Text(
//                             snap2['mem3'],
//                             style: pw.TextStyle(fontSize: 16, font: font),
//                           ),
//                           pw.Text(
//                             snap2['regno3'],
//                             style: pw.TextStyle(fontSize: 14, font: font),
//                           ),

//                           pw.SizedBox(
//                             height: 30,
//                           ),
//                           pw.Text(
//                             'Department of Computer Science,',
//                             style: pw.TextStyle(fontSize: 16, font: font_bold),
//                           ),
//                           pw.SizedBox(
//                             height: 8,
//                           ),
//                           pw.Text(
//                             'National Textile University, Faisalabad',
//                             style: pw.TextStyle(fontSize: 16, font: font),
//                           ),
//                           pw.SizedBox(
//                             height: 8,
//                           ),
//                           pw.Text('Date: ${getCurrentDate()}',
//                               style: pw.TextStyle(font: font, fontSize: 14)),
//                         ]),
//                   )))
//         ];
//         // Center
//       }));
//   pdf.addPage(pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         return <pw.Widget>[
//           pw.Container(
//             margin:
//                 const pw.EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
//             child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Divider(height: 10, thickness: 3),
//                   pw.SizedBox(
//                     height: 20,
//                   ),
//                   pw.Text(
//                     'FYP Proposal',
//                     textAlign: pw.TextAlign.center,
//                     style: pw.TextStyle(
//                       fontSize: 20,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(height: 20),
//                   pw.Text(
//                     '$topic',
//                     textAlign: pw.TextAlign.center,
//                     style: pw.TextStyle(
//                       fontSize: 18,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 10,
//                   ),
//                   pw.Text(
//                     'A- Basic Information',
//                     textAlign: pw.TextAlign.center,
//                     style: pw.TextStyle(
//                       fontSize: 20,
//                       font: font,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 20,
//                   ),
//                   pw.Table(
//                       border: pw.TableBorder.all(),
//                       defaultColumnWidth: const pw.FixedColumnWidth(80.0),
//                       // defaultVerticalAlignment:
//                       //     pw.TableCellVerticalAlignment.middle,
//                       children: [
//                         pw.TableRow(children: [
//                           pw.Column(children: [
//                             pw.Container(
//                                 padding: const pw.EdgeInsets.symmetric(
//                                     vertical: 6, horizontal: 2),
//                                 alignment: pw.Alignment.centerLeft,
//                                 child: pw.Padding(
//                                   padding: const pw.EdgeInsets.only(left: 14),
//                                   child: pw.Text(
//                                     'Title',
//                                     textAlign: pw.TextAlign.left,
//                                     style: pw.TextStyle(
//                                       fontSize: 14,
//                                       font: font_bold,
//                                     ),
//                                   ),
//                                 )),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               padding: const pw.EdgeInsets.all(6.0),
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Padding(
//                                 padding: const pw.EdgeInsets.only(left: 5),
//                                 child: pw.Text(
//                                   snap['project-title'],
//                                   textAlign: pw.TextAlign.left,
//                                   style: pw.TextStyle(
//                                     fontSize: 14,
//                                     font: font,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ])
//                       ]),
//                   pw.Table(
//                       border: pw.TableBorder.all(),
//                       defaultColumnWidth: const pw.FixedColumnWidth(80.0),
//                       // defaultVerticalAlignment:
//                       //     pw.TableCellVerticalAlignment.middle,
//                       children: [
//                         pw.TableRow(children: [
//                           pw.Column(children: [
//                             pw.Container(
//                                 padding: const pw.EdgeInsets.symmetric(
//                                     vertical: 6, horizontal: 2),
//                                 alignment: pw.Alignment.centerLeft,
//                                 child: pw.Padding(
//                                   padding: const pw.EdgeInsets.only(left: 14),
//                                   child: pw.Text(
//                                     'Project Type',
//                                     textAlign: pw.TextAlign.left,
//                                     style: pw.TextStyle(
//                                       fontSize: 14,
//                                       font: font_bold,
//                                     ),
//                                   ),
//                                 )),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               padding: const pw.EdgeInsets.all(6.0),
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Padding(
//                                 padding: const pw.EdgeInsets.only(left: 5),
//                                 child: pw.Text(
//                                   snap['project-type'],
//                                   textAlign: pw.TextAlign.left,
//                                   style: pw.TextStyle(
//                                     fontSize: 14,
//                                     font: font,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ])
//                       ]),
//                   pw.Table(
//                       border: pw.TableBorder.all(),
//                       defaultColumnWidth: const pw.FixedColumnWidth(80.0),
//                       // defaultVerticalAlignment:
//                       //     pw.TableCellVerticalAlignment.middle,
//                       children: [
//                         pw.TableRow(children: [
//                           pw.Column(children: [
//                             pw.Container(
//                                 padding: const pw.EdgeInsets.symmetric(
//                                     vertical: 6, horizontal: 2),
//                                 alignment: pw.Alignment.centerLeft,
//                                 child: pw.Padding(
//                                   padding: const pw.EdgeInsets.only(left: 14),
//                                   child: pw.Text(
//                                     'Project Category',
//                                     textAlign: pw.TextAlign.left,
//                                     style: pw.TextStyle(
//                                       fontSize: 14,
//                                       font: font_bold,
//                                     ),
//                                   ),
//                                 )),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               padding: const pw.EdgeInsets.all(6.0),
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Padding(
//                                 padding: const pw.EdgeInsets.only(left: 5),
//                                 child: pw.Text(
//                                   snap['project-category'],
//                                   textAlign: pw.TextAlign.left,
//                                   style: pw.TextStyle(
//                                     fontSize: 14,
//                                     font: font,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ])
//                       ]),
//                   pw.Table(
//                       border: pw.TableBorder.all(),
//                       defaultColumnWidth: const pw.FixedColumnWidth(80.0),
//                       // defaultVerticalAlignment:
//                       //     pw.TableCellVerticalAlignment.middle,
//                       children: [
//                         pw.TableRow(children: [
//                           pw.Column(children: [
//                             pw.Container(
//                                 padding: const pw.EdgeInsets.symmetric(
//                                     vertical: 6, horizontal: 2),
//                                 alignment: pw.Alignment.centerLeft,
//                                 child: pw.Padding(
//                                   padding: const pw.EdgeInsets.only(left: 14),
//                                   child: pw.Text(
//                                     'Industry Project',
//                                     textAlign: pw.TextAlign.left,
//                                     style: pw.TextStyle(
//                                       fontSize: 14,
//                                       font: font_bold,
//                                     ),
//                                   ),
//                                 )),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               padding: const pw.EdgeInsets.all(6.0),
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Padding(
//                                 padding: const pw.EdgeInsets.only(left: 5),
//                                 child: pw.Text(
//                                   snap['industrial-partner'],
//                                   textAlign: pw.TextAlign.left,
//                                   style: pw.TextStyle(
//                                     fontSize: 14,
//                                     font: font,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ])
//                       ]),
//                   pw.SizedBox(height: 20),
//                   pw.Text(
//                     'B-	Detail of FYP Idea',
//                     textAlign: pw.TextAlign.center,
//                     style: pw.TextStyle(
//                       fontSize: 18,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(height: 20),
//                   pw.Text(
//                     'PROBLEM STATEMENT',
//                     textAlign: pw.TextAlign.center,
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 8,
//                   ),
//                   pw.Text(
//                     snap['problem-statement'],
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 15,
//                   ),
//                   pw.Text(
//                     'OBJECTIVES',
//                     style: pw.TextStyle(
//                       fontSize: 14,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 8,
//                   ),
//                   pw.Text(
//                     snap['objectives'],
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 15,
//                   ),
//                   pw.Text(
//                     'PROBLEM BACKGROUND',
//                     style: pw.TextStyle(fontSize: 14, font: font_bold),
//                   ),
//                   pw.SizedBox(
//                     height: 8,
//                   ),
//                   pw.Text(
//                     snap['problem-background'],
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 15,
//                   ),
//                   pw.Text(
//                     'PROPOSED SOLUTION',
//                     style: pw.TextStyle(
//                       fontSize: 14,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 8,
//                   ),
//                   pw.Text(
//                     snap['proposed-solution'],
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 15,
//                   ),
//                   pw.Text(
//                     'PROPOSED TOOLS',
//                     style: pw.TextStyle(
//                       fontSize: 14,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 8,
//                   ),
//                   pw.Text(
//                     snap['proposed-tools'],
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 15,
//                   ),
//                   pw.Text(
//                     'RELATED TECHNOLOGIES',
//                     style: pw.TextStyle(
//                       fontSize: 14,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 8,
//                   ),
//                   pw.Text(
//                     snap['related-technologies'],
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 15,
//                   ),
//                   pw.Text(
//                     'PROJECT RATIONALE',
//                     style: pw.TextStyle(
//                       fontSize: 14,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 8,
//                   ),
//                   pw.Text(
//                     snap['project-rationale'],
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 15,
//                   ),
//                   pw.Text(
//                     'PROPOSED METHODOLOGY',
//                     style: pw.TextStyle(
//                       fontSize: 14,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 8,
//                   ),
//                   pw.Text(
//                     snap['proposed-methodology'],
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 15,
//                   ),
//                   pw.Text(
//                     'GANTT CHART',
//                     style: pw.TextStyle(
//                       fontSize: 14,
//                       font: font_bold,
//                     ),
//                   ),
//                   pw.SizedBox(
//                     height: 8,
//                   ),
//                   pw.Text(
//                     snap['schedule'],
//                     style: pw.TextStyle(
//                       fontSize: 13,
//                       font: font,
//                     ),
//                   ),
//                 ]),
//           ),
//         ]; // Center
//       }));

//   Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
// }
