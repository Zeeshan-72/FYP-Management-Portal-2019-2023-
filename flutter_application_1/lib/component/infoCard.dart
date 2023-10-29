import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens2/student-screens-2/student-dashboard.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_application_1/config/size_config.dart';
import 'package:flutter_application_1/style/colors.dart';
import 'package:flutter_application_1/style/style.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String label;
  final String amount;

  InfoCard({required this.icon, required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minWidth: Responsive.isDesktop(context) ? 200 : 100),
      padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 20,
          right: Responsive.isMobile(context) ? 20 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.network(
            icon,
            width: 50,
            color: Colors.black54,
          ),
          PrimaryText(text: label, color: AppColors.secondary, size: 16),
          PrimaryText(
            text: amount,
            size: 18,
            fontWeight: FontWeight.w700,
          )
        ],
      ),
    );
  }
}

class CloudStorageInfo {
  final String? svgSrc, title;
  final int? numOfFiles;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.numOfFiles,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "My Group",
    svgSrc: "assets/student-person-3-svgrepo-com.svg",
    numOfFiles: 3,
    color: Colors.blue, ////////
  ),
  CloudStorageInfo(
    title: "Proposals",
    numOfFiles: 2,
    svgSrc: "assets/groups.svg",
    color: Color(0xFFFFA113),
  ),
  CloudStorageInfo(
    title: "Evaluations",
    numOfFiles: 1328,
    svgSrc: "assets/date-range-svgrepo-com.svg",
    color: Color(0xFFA4CDFF),
  ),
  CloudStorageInfo(
    title: "Notifications",
    numOfFiles: 5328,
    svgSrc: "assets/date-range-svgrepo-com.svg",
    color: Color(0xFF007EE5),
  ),
];

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Files",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0 * 1.5,
                  vertical: 16.0 / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Responsive2(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
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

class Responsive2 extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive2({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (_size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (_size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
