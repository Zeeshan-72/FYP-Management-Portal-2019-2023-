// ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'dart:js_util';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/appBarActionItems.dart';

import 'package:flutter_application_1/component/header.dart';
import 'package:flutter_application_1/component/historyTable.dart';
import 'package:flutter_application_1/component/infoCard.dart';
import 'package:flutter_application_1/component/paymentDetailList.dart';
import 'package:flutter_application_1/component/sideMenu.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_application_1/config/size_config.dart';
import 'package:flutter_application_1/convenor_screens/ConvenorDashboard.dart';
import 'package:flutter_application_1/convenor_screens/supervisor_dashboard.dart';
import 'package:flutter_application_1/screens2/External%20Evaluation/External-Dashboard.dart';
import 'package:flutter_application_1/style/colors.dart';
import 'package:flutter_application_1/style/style.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_import

import 'package:flutter_application_1/main.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ExternalDashboardScreen extends StatefulWidget {
  @override
  State<ExternalDashboardScreen> createState() =>
      _ExternalDashboardScreenState();
}

class _ExternalDashboardScreenState extends State<ExternalDashboardScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  final List<Map<String, dynamic>> userList = [
    {
      "userId": "Hopu7hxZy2aIWzz0sWNMvnPxvzG3",
      "name": "Dr. Muhammad Asif Habib"
    },
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
    {
      "userId": "A5Yb79Mx1oYCD4yv6iBVpERJMP33",
      "name": "Mr. Shahbaz Ahmad Sahi"
    },
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

  // var _currentUserId = FirebaseAuth.instance.currentUser!.uid;
  var _currentUserId = 'A5Yb79Mx1oYCD4yv6iBVpERJMP33';

  String _currentUserName = '';

  int _EvaluationCount = 0;
  int _SupervisionCount = 0;
  int _CoSupervisionCount = 0;
  @override
  void initState() {
    super.initState();

    for (var user in userList) {
      if (user['userId'] == _currentUserId) {
        _currentUserName = user['name'];
        break;
      }
    }
    _fetchEvaluationCount();
    _fetchSupervisionCount();
    _fetchCoSupervisionCount();
  }

  Future<void> _fetchEvaluationCount() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('/Evaluations/evaluations/Internal')
        .doc('internal-evaluators')
        .collection('$_currentUserName')
        .get();
    setState(() {
      _EvaluationCount = querySnapshot.docs.length;
    });
  }

  Future<void> _fetchSupervisionCount() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(
            '/Convenor/classes/BS Information Technology/groups/group-members')
        .get();
    setState(() {
      _SupervisionCount = querySnapshot.docs.length;
    });
  }

  Future<void> _fetchCoSupervisionCount() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('supervisor')
        .doc('supervisor')
        .collection('$_currentUserName')
        .doc('groups')
        .collection('co-supervision')
        .get();
    setState(() {
      _CoSupervisionCount = querySnapshot.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
      // key: _drawerKey,
      // // drawer: const SizedBox(width: 100, child: SideMenu()),
      // appBar: !Responsive.isDesktop(context)
      //     ? AppBar(
      //         elevation: 0,
      //         backgroundColor: AppColors.white,
      //         leading: IconButton(
      //             onPressed: () {
      //               _drawerKey.currentState!.openDrawer();
      //             },
      //             icon: const Icon(Icons.menu, color: AppColors.black)),
      //         actions: [
      //           const AppBarActionItems(),
      //         ],
      //       )
      //     : const PreferredSize(
      //         preferredSize: Size.zero,
      //         child: SizedBox(),
      //       ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConvenorHeader(),

                        // ),
                        ConvenorScreen(),

                        const SizedBox(
                          // height: SizeConfig.blockSizeVertical * 4,
                          height: 10,
                        ),

                        // Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       PrimaryText(
                        //           text: 'Notifications',
                        //           size: 30,
                        //           fontWeight: FontWeight.w800),
                        //       PrimaryText(
                        //         text: 'Latest',
                        //         size: 16,
                        //         fontWeight: FontWeight.w400,
                        //         color: AppColors.secondary,
                        //       )
                        //     ]),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // RecentFiles(),

                        // SizedBox(
                        //   height: SizeConfig.blockSizeVertical * 3,
                        // ),
                        // HistoryTable(),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class ConvenorHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Dashboard',
              //   style: Theme.of(context).textTheme.headlineSmall,
              //),
              PrimaryText(
                  text: 'Dashboard', size: 24, fontWeight: FontWeight.w600),
              PrimaryText(
                text: 'External Evaluator',
                size: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
              )
            ]),
      ),
      Spacer(
        flex: 2,
      ),
      Expanded(
        flex: Responsive.isDesktop(context) ? 1 : 3,
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              contentPadding: EdgeInsets.only(left: 40.0, right: 5),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.white),
              ),
              prefixIcon: Icon(Icons.search, color: AppColors.black),
              hintText: 'Search',
              hintStyle: TextStyle(color: AppColors.secondary, fontSize: 14)),
        ),
      ),
    ]);
  }
}

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: 250,
        width: 280,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: TableCalendar(
            weekNumbersVisible: false,
            calendarStyle: const CalendarStyle(
                tablePadding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                defaultTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                isTodayHighlighted: true,
                todayTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            headerStyle: const HeaderStyle(
                titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                formatButtonVisible: false,
                titleCentered: true),
            locale: 'en_US',
            rowHeight: 33,
            focusedDay: today,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 10, 16)));
  }
}

class ConvenorScreen extends StatefulWidget {
  @override
  State<ConvenorScreen> createState() => _ConvenorScreenState();
}

class _ConvenorScreenState extends State<ConvenorScreen> {
  bool _isclicked = false;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Patient Record",
            //       style: Theme.of(context).textTheme.headline5,
            //     ),
            //     ElevatedButton.icon(
            //       style: TextButton.styleFrom(
            //         padding: EdgeInsets.symmetric(
            //           horizontal: 16.0 * 1.5,
            //           vertical: 16.0 / (Responsive.isMobile(context) ? 2 : 1),
            //         ),
            //       ),
            //       onPressed: () {
            //         setState(() {
            //           _isclicked = true;
            //         });

            //         // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //         //   content: Text('PDF generated and saved'),
            //         // ));
            //         // _multipage();
            //       },
            //       icon: Icon(Icons.add),
            //       label: Text("Add New"),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 16.0),
            Responsive2(
              mobile: FileInfoCardGridView(
                crossAxisCount: _size.width < 650 ? 2 : 4,
                childAspectRatio:
                    _size.width < 650 && _size.width > 350 ? 1.3 : 1,
              ),
              tablet: FileInfoCardGridView(),
              desktop: FileInfoCardGridView(
                childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // Visibility(visible: _isclicked, child: AddPatientScreen()),
          ],
        ),
      ),
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          StudentInfoCard(info: demoMyFiles[index]),
    );
  }
}

class StudentInfoCard extends StatelessWidget {
  const StudentInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final StudentCloudStorageInfo info;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      highlightColor: Colors.red,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExternalDashboard(
              selectedIndex2: info.index,
            ),
          ),
        );
        // final screenModel = Provider.of<ScreenModel>(context, listen: false);
        // screenModel.selectedScreen = info.navigatescreen;
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0 * 0.75),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: info.color!.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    info.svgSrc!,
                    color: info.color,
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.white54)
              ],
            ),
            Text(
              info.title!,
              style: TextStyle(fontSize: 20),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class StudentCloudStorageInfo {
  final String? svgSrc, title;
  final int index;
  final Color? color;
  final ScreenType navigatescreen;

  StudentCloudStorageInfo({
    required this.navigatescreen,
    this.svgSrc,
    this.title,
    required this.index,
    this.color,
  });
}

List demoMyFiles = [
  StudentCloudStorageInfo(
    title: "Groups",
    svgSrc: "assets/student-person-3-svgrepo-com.svg",
    index: 2,
    color: Colors.blue,
    navigatescreen: ScreenType.groups, ////////
  ),
  StudentCloudStorageInfo(
    title: "Evaluations",
    index: 3,
    svgSrc: "assets/groups.svg",
    color: Color(0xFFFFA113),
    navigatescreen: ScreenType.proposals,
  ),
  StudentCloudStorageInfo(
    title: "Results",
    index: 3,
    svgSrc: "assets/date-range-svgrepo-com.svg",
    color: Color(0xFFA4CDFF),
    navigatescreen: ScreenType.evaluations,
  ),
  StudentCloudStorageInfo(
    title: "Notifications",
    index: 0,
    svgSrc: "assets/date-range-svgrepo-com.svg",
    color: Color(0xFF007EE5),
    navigatescreen: ScreenType.profile,
  ),
];

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: 13,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text(
                    "File Name",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Date",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Action",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0 * 0.75),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: fileInfo.color!.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(
                Icons.description_rounded,
                size: 21,
                color: fileInfo.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                fileInfo.title!,
                style: GoogleFonts.roboto(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          fileInfo.date!,
          style: GoogleFonts.roboto(fontSize: 14),
        ),
      ),
      DataCell(Row(
        children: [
          Container(

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
                    tooltip: 'Read',
                    onPressed: () {},
                    icon: Icon(
                      Icons.description_rounded,
                      size: 20,
                    ),
                    color: Colors.blue),
              )),
          SizedBox(
            width: 8,
          ),
          Container(

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
                  tooltip: 'Download',
                  onPressed: () {
                    PresentableGroups();
                  },
                  icon: Icon(
                    Icons.download_rounded,
                    size: 20,
                  ),
                  color: Color(0xFF007EE5),
                ),
              ))
        ],
      )),
    ],
  );
}

class RecentFile {
  final String? id, title, date, size;
  final Color? color;

  RecentFile({this.id, this.color, this.title, this.date, this.size});
}

List demoRecentFiles = [
  RecentFile(
    id: "01",
    color: Colors.blue,

    // icon: "assets/icons/xd_file.svg",
    title: "External Evaluation",
    date: "02-06-2023",
    size: "13,15,17",
  ),
  RecentFile(
    id: "02",
    color: Colors.blue,
    // icon: "assets/icons/Figma_file.svg",
    title: "Internal Evaluation",
    date: "27-02-2021",
    size: "27,29,21",
  ),
  RecentFile(
    id: "03",
    color: Colors.blue,
    // icon: "assets/icons/doc_file.svg",
    title: "Approved Projects",
    date: "23-02-2021",
    size: "26,29,30",
  ),
  RecentFile(
    id: "04",
    color: Color(0xFF007EE5),
    // icon: "assets/icons/sound_file.svg",
    title: "Supervisor Allocation",
    date: "21-02-2021",
    size: "14,19,21",
  ),
];

_InternalNotification() async {
  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  QuerySnapshot snapshot = await _db
      .collection(
          "/Evaluations/evaluations/Semester 8/Internal Evaluation/Internal Evaluators/groups/groups")
      .orderBy('fyp-id')
      .get();
  List<DocumentSnapshot> documents = snapshot.docs;

  final doc = pw.Document();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          margin: const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
          child: pw.Column(children: [
            pw.Text(
              'National Textile University, Faisalabad',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text(
              'Department of Computer Science',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text(
                'BSIT Final Year Project (FYP) Internal Evaluation notification',
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(
              height: 30,
            ),
            pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(1),
                  1: pw.FlexColumnWidth(1),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(2),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(children: [
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'FYP ID',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Reg No',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Evaluators',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Project title',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
                  for (var i = 0; i < 14; i++) ...[
                    pw.TableRow(children: [
                      pw.Column(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6.0),
                          alignment: pw.Alignment.center,
                          child: pw.Center(
                            child: pw.Text(
                              documents[i]['fyp-id'],
                              style: const pw.TextStyle(
                                fontSize: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.Container(
                        padding: pw.EdgeInsets.all(6.0),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                documents[i]['regno1'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                documents[i]['regno2'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                documents[i]['regno3'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                            ]),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(6.0),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                documents[i]['8-evaluator1'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.SizedBox(height: 1),
                              pw.Text(
                                documents[i]['8-evaluator2'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                            ]),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(6.0),
                        child: pw.Text(
                          documents[i]['accepted-idea'],
                          style: const pw.TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ]),
                  ]
                ]),
            pw.SizedBox(height: 30),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Dated: ${getCurrentDate()}',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 10)),
                pw.Column(children: [
                  pw.Text('Shahbaz Ahmad Sahi',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 10)),
                  pw.Text('Convener, BSIT, FYP Committee',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 10)),
                ])
              ],
            )
          ]),
        ); // Center
      }));

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());

  return SafeArea(
    child: Center(
      child: Column(
        children: [
          const Text('zeeshan'),
          ElevatedButton(
              onPressed: () {
                _InternalNotification();
              },
              child: const Text("Print"))
        ],
      ),
    ),
  );
}

String getCurrentDate() {
  var date = DateTime.now().toString();

  var dateParse = DateTime.parse(date);

  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  return formattedDate.toString();
}

PresentableGroups() async {
  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  QuerySnapshot snapshot = await _db
      .collection("/External/accounts/presentable-groups")
      .orderBy('fyp-id')
      .get();
  List<DocumentSnapshot> documents = snapshot.docs;

  final doc = pw.Document();
  var font = await PdfGoogleFonts.tinosRegular();
  var fontBold = await PdfGoogleFonts.tinosBold();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          margin: const pw.EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
          child: pw.Column(children: [
            pw.Text(
              'National Textile Univeristy, Faisalabad',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text(
              'Department of Computer Science',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text(
                'BSIT Final Year Project (FYP) External Evaluation notification',
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(
              height: 20,
            ),
            pw.Text(
                'Based on the recommendations/evaluation of the supervisory committee and internal evaluation of the FYPs, it is notified that the following FYPs are selected for the display scheduled to be held on Thursday, 22 June, 2023. In this regard:All the selected groups must comply with the suggestions the supervisory committee and internal evaluators gave Furthermore, at least one member from each of the selected groups is advised to contact Dr. Muhammad Abdul Qayyum (Convener, FYP display committee) for the instructions regarding the display by Tuesday, ',
                style: pw.TextStyle(
                  fontSize: 10,
                )),
            pw.SizedBox(height: 30),
            pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(1),
                  1: pw.FlexColumnWidth(1),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(2),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(children: [
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'FYP ID',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Reg No',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Main Supervisor',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    pw.Column(children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            'Project title',
                            style: pw.TextStyle(
                              fontSize: 10.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
                  for (var i = 0; i < 8; i++) ...[
                    pw.TableRow(children: [
                      pw.Column(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6.0),
                          alignment: pw.Alignment.center,
                          child: pw.Center(
                            child: pw.Text(
                              documents[i]['fyp-id'],
                              style: const pw.TextStyle(
                                fontSize: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.Container(
                        padding: pw.EdgeInsets.all(6.0),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                documents[i]['regno1'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                documents[i]['regno2'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                              pw.Text(
                                documents[i]['regno3'],
                                style: const pw.TextStyle(
                                  fontSize: 8.0,
                                ),
                              ),
                            ]),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6.0),
                        alignment: pw.Alignment.center,
                        child: pw.Center(
                          child: pw.Text(
                            documents[i]['main-supervisor'],
                            style: const pw.TextStyle(
                              fontSize: 8.0,
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(6.0),
                        child: pw.Text(
                          documents[i]['accepted-idea'],
                          style: const pw.TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ]),
                  ]
                ]),
            pw.SizedBox(height: 220),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Dated: ${getCurrentDate()}',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 10)),
                pw.Column(children: [
                  pw.Text('Shahbaz Ahmad Sahi',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 10)),
                  pw.Text('Convener, BSIT, FYP Committee',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 10)),
                ])
              ],
            )
          ]),
        ); // Center
      }));

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());

  return SafeArea(
    child: Center(
      child: Column(
        children: [
          const Text('zeeshan'),
          ElevatedButton(
              onPressed: () {
                PresentableGroups();
              },
              child: const Text("Print"))
        ],
      ),
    ),
  );
}
